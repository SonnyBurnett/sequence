import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import json
import pprint as pp
import time


spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials())

artist_id = '1dfeR4HaWDbWqFHLkxsg1d'
artist_uri = 'spotify:artist:' + artist_id

results = spotify.artist_albums(artist_uri, album_type='album')
albums = results['items']
while results['next']:
    results = spotify.next(results)
    albums.extend(results['items'])

for album in albums:
    #print(album)
    art = album.get('artists')
    for y in art:
        art_name = y.get('name')
    print("{} * {} * {} * {}". format(art_name, album['name'], album['release_date'], album['id']))
    track_list = spotify.album_tracks(album['uri'])
    tj2 = track_list.keys()
    tj3 = track_list.get('items')
    for x in tj3:
        t = x.get('duration_ms')
        seconds = int((t / 1000) % 60)
        minutes = int((t / (1000 * 60)) % 60)
        print("{:3d} {:55s} {:2d}:{:02d} {:35s}".format(x.get('track_number'), x.get('name'), minutes, seconds, x.get('id')))
    print()
