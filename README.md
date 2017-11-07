# alfred-genius

An [Alfred 3](https://www.alfredapp.com/) workflow for searching song lyrics on [Genius](https://genius.com/).

![alfred-genius](https://i.imgur.com/FDacgV8.png)

## Installation

[Download](https://github.com/goronfreeman/alfred-genius/releases/latest) the latest `Genius.alfredworkflow` file and double click it to install.

## Setup

After installing alfred-genius, type `genius`, then attempt to search for a song. You will see a message saying `Genius is not set up yet!` Press `Enter`, and you will be taken to the [Genius API clients page](https://genius.com/api-clients/new). If you do not have a Genius account, you will have to create one first. Create a new API client with the following information (or whatever you want):

| New API Client    |                                                                            |
| ----------------- | -------------------------------------------------------------------------- |
| `APP NAME`        | alfred-genius                                                              |
| `ICON URL`        | http://images.rapgenius.com/f2cb660689994b2564b2d493759c02a7.114x114x1.png |
| `APP WEBSITE URL` | https://github.com/goronfreeman/alfred-genius                              |
| `REDIRECT URI`    | `(empty)`                                                                  |

Click `Save`. On the next page under `CLIENT ACCESS TOKEN`, click `Generate Access Token`, then copy the token to your clipboard. Finally, open Alfred and type `gsetup`. Paste in the access token you just copied and press `Enter`. You should see a notification saying `Genius is now ready!` You can now type `genius` to search for any song you want.

## Usage

Simply type `genius` followed by a song name. You will see a list of songs, along with the artist name and album cover. Press `Enter` to open the song page on Genius, or press `Shift` to view the page in a quicklook window.

You can also select a result and hold `cmd`, then press `Enter` to view the artist page on Genius, or hold `alt`, then press `Enter` to search for the song on Google. If you want to copy the song URL, highlight a result, then press `cmd + c`.

## Credits

alfred-genius uses these libraries:

* [alfred-workflow-ruby](https://github.com/joetannenbaum/alfred-workflow-ruby) by [Joe Tannenbaum](https://github.com/joetannenbaum)
* [genius](https://github.com/timrogers/genius) by [Tim Rogers](https://github.com/timrogers)
