import yt_dlp
import json

def extract(url, cookie_path=None):
    ydl_opts = {
        'quiet': True,
        'no_warnings': True,
        'format': 'best',
        'noplaylist': True,
        'socket_timeout': 30,
        'retries': 5,
    }

    if cookie_path:
        ydl_opts['cookiefile'] = cookie_path

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(url, download=False)

            # Detect platform
            platform = "unknown"
            if "tiktok.com" in url:
                platform = "tiktok"
            elif "instagram.com" in url:
                platform = "instagram"
            elif "x.com" in url or "twitter.com" in url:
                platform = "twitter"

            result = {
                "title": info.get('title', 'No Title'),
                "thumbnail": info.get('thumbnail'),
                "direct_url": info.get('url'),
                "ext": info.get('ext'),
                "duration": info.get('duration'),
                "platform": platform,
                "http_headers": info.get('http_headers', {})
            }
            return result
    except Exception as e:
        return {"error": str(e)}
