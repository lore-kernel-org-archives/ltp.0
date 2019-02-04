From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Feb 2019 12:12:39 +0200
Subject: [LTP] [PATCH 4.14 00/68] 4.14.97-stable review
In-Reply-To: <20190130193223.GA20667@kroah.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
 <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
 <20190130193223.GA20667@kroah.com>
Message-ID: <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > fanotify09 failed on arm64 devices running 4.14 version kernel
> > > fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> > > https://bugs.linaro.org/show_bug.cgi?id=4271
> > >
> >
> > fanotify09 was added a new regression test case for commit
> >   b469e7e47c8a: fanotify: fix handling of events on child sub-directory
> >
> > That commit was backported to v4.19. As I wrote in "backport hint", the bug
> > exists in older kernels, but fix does not apply cleanly to older kernels.
>
> If someone were to provide a tested backport to 4.14 and older, I'll be
> glad to queue it up (hint hint hint...)
>

Attached backport applies and tested on 4.14 and 4.9

Thanks,
Amir.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: stable-4.9-fanotify-fix-handling-of-events-on-child-sub-directo.patch
Type: text/x-patch
Size: 2522 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190204/08552cbd/attachment.bin>
