From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Nov 2020 15:16:24 +0100
Subject: [LTP] [PATCH v3 3/5] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <CAOQ4uxigsk5e7GHgDHydd03D1bAih1SJv36dB4209mpE_dU6PQ@mail.gmail.com>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-4-pvorel@suse.cz>
 <20201119102740.GD2785@yuki.lan>
 <CAOQ4uxigsk5e7GHgDHydd03D1bAih1SJv36dB4209mpE_dU6PQ@mail.gmail.com>
Message-ID: <20201125141624.GA32471@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> > > @@ -101,19 +101,8 @@ static void test_fanotify(unsigned int n)
> > >                       "failed", tc->init_flags);
> > >       }

> > > -     if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> > > -                       FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> > > -                       AT_FDCWD, fname) < 0) {
> > > -             if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
> > > -                     tst_res(TCONF,
> > > -                             "FAN_MARK_FILESYSTEM not supported in kernel?");
> > > -                     return;
> > > -             }

> > Here we had tst_res(TCONF, ...) followed by a return but we will can
> > tst_brk() after the change. I guess that we may skip part of the test on
> > older kernels with that change.


> That's not good. I missed that in my review.
> There are many tests where only the FAN_MARK_FILESYSTEM
> test cases are expected to result in TCONF, but the rest of the test
> cases should run.

I'm not sure if I understand you. Is my approach correct here?

Kind regards,
Petr

> In most of these tests the FAN_MARK_FILESYSTEM test cases are
> last because they were added later. This is not the case with fanotify01
> and fanotify15 and we do not want to reply on the ordering anyway.

> Thanks,
> Amir.
