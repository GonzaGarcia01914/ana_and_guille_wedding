from __future__ import annotations

from pathlib import Path

from moviepy import VideoFileClip


def prepare_video(
    source_path: Path,
    target_path: Path,
    target_width: int = 1920,
    target_height: int = 1080,
) -> None:
    source_path = source_path.expanduser().resolve()
    target_path = target_path.expanduser().resolve()
    target_path.parent.mkdir(parents=True, exist_ok=True)

    print(f"Loading video from: {source_path}")
    clip = VideoFileClip(source_path.as_posix())

    print(f"Original resolution: {clip.w}x{clip.h}")
    clip_resized = clip.resized(height=target_height)
    print(f"Resized (by height) resolution: {clip_resized.w}x{clip_resized.h}")

    if clip_resized.w > target_width:
        crop_x = (clip_resized.w - target_width) / 2
        print(f"Cropping horizontally: x1={crop_x} x2={crop_x + target_width}")
        clip_final = clip_resized.cropped(x1=crop_x, x2=crop_x + target_width)
    else:
        print("Scaling to match target width")
        clip_final = clip_resized.resized(width=target_width)

    clip_final = clip_final.without_audio()

    print(f"Writing output to: {target_path}")
    clip_final.write_videofile(
        filename=target_path.as_posix(),
        codec="libx264",
        bitrate="8000k",
        preset="medium",
        audio=False,
    )

    clip.close()
    clip_resized.close()
    clip_final.close()
    print("Conversion completada:", target_path)


if __name__ == "__main__":
    project_root = Path(__file__).resolve().parents[1]
    input_video = (
        Path(r"C:\Users\gonza\Desktop\Proyectos\InvitacionBodaMama\Multimedia")
        / "WhatsApp Video 2025-10-14 at 12.15.41.mp4"
    )
    output_video = project_root / "web" / "assets" / "media" / "hero.mp4"
    prepare_video(input_video, output_video)
