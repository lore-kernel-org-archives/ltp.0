From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 10:27:11 +0000
Subject: [LTP] travis: getting emails for other people's forks
In-Reply-To: <20170201083124.6b3rrrx46xf2457b@dell5510>
References: <20170201083124.6b3rrrx46xf2457b@dell5510>
Message-ID: <CAFEAcA8=fTOTi1AkS6hgGWHQji=Hh8aUQGDZk5zW9UJMMnOmqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1 February 2017 at 08:31, Petr Vorel <pvorel@suse.cz> wrote:
> yesterday I was trying to figure out how to configure travis not to send us (i.e. to the
> list) emails for other people's forks. I tried to use environment variable set in travis
> web UI for email address, using conditional mailing with $TRAVIS_REPO_SLUG
> variable or other workaround [1], but none worked.
>
> There might be a way to play with 'after_script:' command.
>
> Others seems to be using IRC or another services (hipchat or slack [2]) for notifications.
>
> [1] https://github.com/travis-ci/travis-ci/issues/6100
> [2] https://docs.travis-ci.com/user/notifications

That issue 6100 includes some comments that suggest that you
can work around this with the same thing we do in QEMU's
.travis.yml to only send notifications to IRC for the official
fork. Basically you use
  recipients:
    secure: "<encrypted string>"

where the encrypted string is generated using the commandline
utility:

travis encrypt -r github-repo-name "target-email@wherever.com"

This sets this up so that only the named github repo will decrypt
the encrypted bit of config and apply it -- forks won't be able
to decrypt it and so will not send emails.

example:
https://github.com/facebook/flow/commit/8ec791d5d1623aafa144de4e0692d40352125ec9

(QEMU doesn't use email notifications but this definitely works for
our IRC channel notifications.)

thanks
-- PMM
