# Docker Cloudfare DDNS

Simple Docker image to dynamically update a Cloudflare DNS record.

## Usage

All parameters are passed to the script using env variables, so export the following:

    DOMAIN=sub.example.com
    CF_API_EMAIL=admin@example.com
    CF_API_KEY=00000000000000000000

Then run. To execute from this directory, you can use the convenient Make target.

    make run

## Development

The script is straight from the examples provided by Cloudflare on their Github. The latest version can be downloaded using:

    make update
