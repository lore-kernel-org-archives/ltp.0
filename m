From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 15:21:50 +0200
Subject: [LTP] Can we assume at least GCC 4.1 for building LTP tests?
 (__builtin___clear_cache())
In-Reply-To: <CAFEAcA-w1oQiWSHtm-fXUMStFJdwyXyJr+4E8=4ObtJ8jcZVkA@mail.gmail.com>
References: <CAFEAcA-w1oQiWSHtm-fXUMStFJdwyXyJr+4E8=4ObtJ8jcZVkA@mail.gmail.com>
Message-ID: <20160726132150.GE11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi; is there a minimum GCC version we can assume for LTP tests,
> and is it GCC 4.1 or better?

From my point of view SLES10 comes with 4.1.x which is okay, but RHEL4
has extended support till 2017 and has gcc 3.4.x not sure how much
actively it will be tested though.

And we had to add fallbacks for __sync_add_and_fetch() since some
architectures implemented it later than 4.1.2 although general support
was added in 4.1.2. So if we decide to go without configure check for
the building it has to be tested on all platforms.

And of course the safest bet is configure check and TCONF if buildin is
not supported...

-- 
Cyril Hrubis
chrubis@suse.cz
