From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 12:27:55 +0200
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <20200519094201.llskyyq2jbx7onai@vireshk-i7>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
 <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
 <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
 <20200519094201.llskyyq2jbx7onai@vireshk-i7>
Message-ID: <CAK8P3a0_o+pme5Ejy9L4_xfmnMO1a0j52rkp_mXDet_fPmXLYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 11:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-05-20, 11:21, Arnd Bergmann wrote:
> > For msgctl/semctl/shmctl, the existing syscalls were extended in a
> > compatible way, using an extended 'high' field for each 32-bit
> > seconds value. I later learned that on some architectures, the
> > 'compat' version of that failed to zero-initialize those fields, so I
> > guess all we need is a test that ensures this was fixed correctly,
> > by initializing the '*_high' to something nonzero before calling
> > the syscall, and checking that it gets zero-filled by the syscall.
>
> Okay, I see the new structure (struct semid64_ds) getting added to the
> kernel. But I am not sure how to call the 'compat' version, can you
> please help ?
>
> Do I just need to call like this ?
>
>         struct semid64_ds buf_ds = {
>                 .sem_otime_high = 1,
>                 .sem_ctime_high = 1
>         };
>         union semun arg;
>
>         arg.buf = &buf_ds;
>         semctl(semid, 0, IPC_STAT, arg);
>
> ?

Yes, and then check that the two fields now contain zeroes.

This needs to be compile-time guarded in some form to avoid
running it on 64-bit machines (which don't have the fields), or
to run into compile-time failures with old kernel headers that
don't expose the fields. Note that the struct definitions are
architecture-specific, so unfortunately you can't just provide
a copy of that definition in ltp unless you add all eight versions
that the kernel defines.
Perhaps ltp already has a way to probe whether the headers
have the latest struct definition.

    Arnd
