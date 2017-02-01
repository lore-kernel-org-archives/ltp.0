From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Feb 2017 10:55:26 +0100
Subject: [LTP] travis: getting emails for other people's forks
In-Reply-To: <20170201083124.6b3rrrx46xf2457b@dell5510>
References: <20170201083124.6b3rrrx46xf2457b@dell5510>
Message-ID: <20170201095525.GB13898@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> yesterday I was trying to figure out how to configure travis not to send us (i.e. to the
> list) emails for other people's forks. I tried to use environment variable set in travis
> web UI for email address, using conditional mailing with $TRAVIS_REPO_SLUG
> variable or other workaround [1], but none worked.

Frankly I do not care that much. I do not see it as a serious problem
unless we get continuous flow of travis emails.

> Others seems to be using IRC or another services (hipchat or slack [2]) for notifications.
> 
> [1] https://github.com/travis-ci/travis-ci/issues/6100
> [2] https://docs.travis-ci.com/user/notifications

I would rather keep using emails.

We have IRC #ltp channel on freenode, but it's rarely used. And the
biggest problem with notifications on IRC is that they would end up lost
either somewhere far away in log or on on reconnections, etc.

And for the hipchat or slack, call me old fashioned but I do not want to
create another account on some kind of proprietary communication tool.

-- 
Cyril Hrubis
chrubis@suse.cz
