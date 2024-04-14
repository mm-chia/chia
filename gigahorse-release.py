import requests

def get_latest_release(username, repo):
    url = f'https://api.github.com/repos/{username}/{repo}/releases'
    response = requests.get(url)
    releases = response.json()
    if releases:
        return sorted(releases, key=lambda x: x['created_at'], reverse=True)[0]['tag_name']
    return None

print(get_latest_release('madMAx43v3r', 'chia-gigahorse'))
