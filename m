From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 4 Feb 2019 11:35:06 +0100
Subject: [LTP] [PATCH 4.14 00/68] 4.14.97-stable review
In-Reply-To: <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
 <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
 <20190130193223.GA20667@kroah.com>
 <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
Message-ID: <20190204103506.GB3614@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 04, 2019 at 12:12:39PM +0200, Amir Goldstein wrote:
> > > > fanotify09 failed on arm64 devices running 4.14 version kernel
> > > > fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> > > > https://bugs.linaro.org/show_bug.cgi?id=4271
> > > >
> > >
> > > fanotify09 was added a new regression test case for commit
> > >   b469e7e47c8a: fanotify: fix handling of events on child sub-directory
> > >
> > > That commit was backported to v4.19. As I wrote in "backport hint", the bug
> > > exists in older kernels, but fix does not apply cleanly to older kernels.
> >
> > If someone were to provide a tested backport to 4.14 and older, I'll be
> > glad to queue it up (hint hint hint...)
> >
> 
> Attached backport applies and tested on 4.14 and 4.9

Nice, thanks for this!  Now queued up.

greg k-h
