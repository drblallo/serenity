import argparse
from PIL import Image, ImageDraw
import random

def exponential_interpolation(x, x0, x1, y0, y1):
    """
    Returns the exponential interpolation y-value at x,
    given two anchor points (x0, y0) and (x1, y1).

    Specifically, y(x) = y0 * (y1 / y0) ^ ((x - x0) / (x1 - x0)).

    Parameters:
    -----------
    x  : float
        The x-value at which you want to interpolate.
    x0 : float
        The x-coordinate of the first anchor point.
    x1 : float
        The x-coordinate of the second anchor point.
    y0 : float
        The y-coordinate of the first anchor point.
    y1 : float
        The y-coordinate of the second anchor point.

    Returns:
    --------
    float
        The interpolated y-value at x.
    """

    # Avoid division by zero:
    if x1 == x0:
        raise ValueError("x1 and x0 must be different to perform interpolation.")

    # Avoid invalid logarithm or ratio if y0 is 0:
    if y0 == 0:
        raise ValueError("y0 must be nonzero for exponential interpolation.")

    # Calculate the interpolation factor (alpha) between 0 and 1
    alpha = (x - x0) / (x1 - x0)

    # Perform the exponential interpolation
    # y(x) = y0 * exp(ln(y1 / y0) * alpha)
    # which is the same as y0 * (y1 / y0)^alpha
    y = y0 * (y1 / y0) ** alpha

    return y


def draw_line_with_blend(base_image, xy_start, xy_end, color, width=5):
    """
    Draw a semi-transparent line onto base_image, blending only the bounding box region.
    """
    # Calculate bounding box of the line
    min_x = min(xy_start[0], xy_end[0])
    min_y = min(xy_start[1], xy_end[1])
    max_x = max(xy_start[0], xy_end[0])
    max_y = max(xy_start[1], xy_end[1])

    # Expand bounding box by the line width so we don’t cut off edges
    half_w = width // 2
    min_x -= half_w
    min_y -= half_w
    max_x += half_w
    max_y += half_w

    # Ensure bounding box is within the image
    min_x = max(min_x, 0)
    min_y = max(min_y, 0)
    max_x = min(max_x, base_image.width)
    max_y = min(max_y, base_image.height)

    if min_x >= max_x or min_y >= max_y:
        return  # No valid region

    # Crop out the region from the base image
    region_box = (min_x, min_y, max_x, max_y)
    region = base_image.crop(region_box)

    # Create an overlay the size of the bounding box (fully transparent)
    overlay = Image.new("RGBA", (region.width, region.height), (0, 0, 0, 0))
    draw_overlay = ImageDraw.Draw(overlay)

    # Adjust the line coordinates relative to the overlay
    offset_start = (xy_start[0] - min_x, xy_start[1] - min_y)
    offset_end   = (xy_end[0]   - min_x, xy_end[1]   - min_y)

    # Draw onto overlay using RGBA color (with alpha <255 for partial transparency)
    draw_overlay.ellipse([offset_start, offset_end], fill=color, outline=color, width=width)

    # Alpha-composite the overlay onto the cropped region
    blended_region = Image.alpha_composite(region, overlay)

    # Paste blended region back into base image
    base_image.paste(blended_region, region_box)


def main():
    parser = argparse.ArgumentParser(description='Add randomly placed dots to an image with varying sizes.')
    parser.add_argument('image_path', type=str, help='Path to the source image')
    parser.add_argument('num_dots', type=int, help='Number of dots to add')
    parser.add_argument('start_size', type=int, help='Starting dot size in pixels')
    parser.add_argument('end_size', type=int, help='Final dot size in pixels')

    args = parser.parse_args()

    # Load the image
    original = Image.open(args.image_path).convert("RGBA")
    original.putalpha(255)
    target = original.copy()
    draw = ImageDraw.Draw(target)
    width, height = original.size

    for i in range(args.num_dots):
        # Calculate interpolated size
        if args.num_dots > 1:
            t = i / (args.num_dots - 1)
        else:
            t = 0.0
        # current_size = args.start_size + t * (args.end_size - args.start_size)
        current_size = exponential_interpolation(t, 0.0, 1.0, args.start_size, args.end_size)
        current_size = max(1, int(round(current_size)))  # Ensure minimum size of 1 pixel

        # Generate random position
        x = random.randint(0, width - 1)
        y = random.randint(0, height - 1)

        x2 = x + random.randint(1, 5 * current_size)
        y2 = y + random.randint(1, 5 * current_size)

        # Get color from original image
        color = original.getpixel((x, y))

        new_alpha = 128  # For example, set alpha to 50% transparency
        color = (color[0], color[1], color[2], new_alpha)

        # Calculate bounding box
        half_size = current_size // 2
        left = x - half_size
        top = y - half_size
        right = x2+ half_size- 1
        bottom = y2+ half_size- 1

        # Draw the dot
        draw_line_with_blend(target, [left, top], [right, bottom], color, half_size)
        # draw.line(, fill=color, width=half_size)

    # Save the result
    output_path = args.image_path.replace('.', '_modified.')
    target.save(output_path)
    print(f"Saved modified image to {output_path}")

if __name__ == '__main__':
    main()

