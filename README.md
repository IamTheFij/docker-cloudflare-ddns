# Deprecated! Check out newer versions of ddclient

# Docker Cloudfare DDNS

Simple Docker image that wraps an example script to dynamically update a Cloudflare DNS record.

## Usage

There are two things to configure. First, the domain that you wish to update needs to be provided as a command line argument. This can be done by adding it to the end of your run command (example in the Makefile) or by adding it as a command to your compose file. Eg:

    ddns:
      image: IamTheFij/cloudflare-ddns
      command: ["example.com"]

Your Cloudflare credentials can be passed in any way that [python-cloudflare](https://github.com/cloudflare/python-cloudflare) allows. Generally, either via envioronment variables:

    CF_API_EMAIL=admin@example.com  # Do not set if using an API Token
    CF_API_KEY=00000000000000000000
    CF_API_CERTKEY='v1.0-...'

Or by providing a file mounted to the working directory in the image, `/src/.cloudflare.cfg` that contains something like:

    [CloudFlare]
    emal = admin@example.com  # Do not set if using an API Token
    token = 00000000000000000000
    certtoken = v1.0-...

Then run. To execute from this directory, you can use the convenient Make target.

    make run

## Source

Original source: https://git.iamthefij.com/iamthefij/docker-cloudflare-ddns

Github mirror: https://github.com/iamthefij/docker-cloudflare-ddns