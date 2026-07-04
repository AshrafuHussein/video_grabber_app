import yt_dlp
import json

def extract(url, cookie_path=None):
    ydl_opts = {
        'quiet': True,
        'format': 'best',
        'noplaylist': True,
        'socket_timeout': 30,
        'retries': 5,
        'nocheckcertificate': True,
    }

    if cookie_path:
        ydl_opts['cookiefile'] = cookie_path

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=False)

            # Identify platform
            platform = "unknown"
            if "tiktok.com" in url:
                platform = "tiktok"
            elif "instagram.com" in url:
                platform = "instagram"
            elif "twitter.com" in url or "x.com" in url:
                platform = "x"

            return {
                "title": info.get('title', 'Video'),
                "thumbnail": info.get('thumbnail', ''),
                "direct_url": info.get('url', ''),
                "ext": info.get('ext', 'mp4'),
                "duration": info.get('duration', 0),
                "platform": platform
            }
    except Exception as e:
        return {"error": str(e)}
