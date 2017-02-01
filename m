From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Feb 2017 09:31:24 +0100
Subject: [LTP] travis: getting emails for other people's forks
Message-ID: <20170201083124.6b3rrrx46xf2457b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

yesterday I was trying to figure out how to configure travis not to send us (i.e. to the
list) emails for other people's forks. I tried to use environment variable set in travis
web UI for email address, using conditional mailing with $TRAVIS_REPO_SLUG
variable or other workaround [1], but none worked.

There might be a way to play with 'after_script:' command.

Others seems to be using IRC or another services (hipchat or slack [2]) for notifications.

[1] https://github.com/travis-ci/travis-ci/issues/6100
[2] https://docs.travis-ci.com/user/notifications


Kind regards,
Petr
