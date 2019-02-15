From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Feb 2019 19:21:43 +0530
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <20190215132526.GC26339@rei>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
 <20190215132251.GB26339@rei> <20190215132526.GC26339@rei>
Message-ID: <CAFA6WYPCZc8TSim3VFJaExDd_9FcNpf6Py3pDEYkEscMfbCbAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 15 Feb 2019 at 18:55, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > Thanks for the pointers. IIUC, you are referring to following change:
> > >
> > > -       TEST(syncfs(fd));
> > > +       TEST(tst_syscall(__NR_syncfs, fd));
> > >
> > > If yes, then I will incorporate it.
> >
> > The most complete solution is configure check + fallback definition.
> >
> > Have a look at:
> >
> > include/lapi/execveat.h
> > m4/ltp-execveat.m4
> > configure.ac
>
> And then you have to also check for the return value to exit the test
> with TCONF on missing kernel support, you will most likely get EINVAL in
> that case as the syscall number is not known.
>

Ok got it. Will incorporate it.

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
