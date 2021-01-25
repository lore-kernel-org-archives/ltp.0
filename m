From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Jan 2021 22:01:48 +0530
Subject: [LTP] LTP: madvise08.c:203: TFAIL: No sequence in dump after
 MADV_DODUMP.
In-Reply-To: <CAK8P3a2OeeW29ekbD70Ns4LTjGRJRT9P0wM-SAxUin1zAxP7TA@mail.gmail.com>
References: <CA+G9fYsvDWDogC+xgeG2V9MMofV5svTipDigDiUBje+2jSRK8g@mail.gmail.com>
 <CAK8P3a2OeeW29ekbD70Ns4LTjGRJRT9P0wM-SAxUin1zAxP7TA@mail.gmail.com>
Message-ID: <CA+G9fYv89bfbixjuudPWkBAucTYg7qhNxcV54RMEkRP5is-bnQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Arnd,

On Mon, 25 Jan 2021 at 20:41, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Jan 25, 2021 at 3:48 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > LTP syscalls madvise08 test case failed on all devices from
> > Linux next 20210118 to till day.
> > strace log attached to this email and link provided below.
> >
> > BAD: next-20210118
> > GOOD: next-20210115
> >
> > This failure is easily reproducible on Linux next tag 20210118 above.
> >
> > tst_test.c:1250: TINFO: Timeout per run is 0h 15m 00s
> > madvise08.c:73: TINFO: Temporary core pattern is
> > '/scratch/ltp-2nftQzNI1K/HclFMH/dump-%p'
> > madvise08.c:112: TINFO: Dump file should be dump-10109
> > madvise08.c:196: TPASS: madvise(..., MADV_DONTDUMP)
> > madvise08.c:112: TINFO: Dump file should be dump-10110
> > madvise08.c:203: TFAIL: No sequence in dump after MADV_DODUMP.
> >
> > strace log,
> > https://lkft.validation.linaro.org/scheduler/job/2184866#L1257
>
> Ok, so in this part of the log,
>
> [pid   485] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_DUMPED,
> si_pid=487, si_uid=0, si_status=SIGABRT, si_utime=0, si_stime=0} ---
> [pid   485] write(2, \"madvise08.c:117: \33[1;34mTINFO: \33\"...,
> 64madvise08.c:117: [1;34mTINFO: [0mDump file should be dump-487
> ) = 64
> [pid   485] access(\"dump-487\", F_OK)    = 0
> [pid   485] openat(AT_FDCWD, \"dump-487\", O_RDONLY) = 3
> [pid   485] read(3,
> \"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\4\0>\0\1\0\0\0\0\0\0\0\0\0\0\0\"...,
> 1024) = 1024
> [pid   485] read(3,
> \"\0\320\3\0\0\0\0\0\0\340\375\24\304\177\0\0\0\0\0\0\0\0\0\0\0\20\0\0\0\0\0\0\"...,
> 1024) = 292
> [pid   485] read(3, \"\", 1024)           = 0
> [pid   485] close(3)                    = 0
> [pid   485] write(2, \"madvise08.c:208: \33[1;31mTFAIL: \33\"...,
> 74madvise08.c:208: [1;31mTFAIL: [0mNo sequence in dump after
> MADV_DODUMP.
>
> it seems that the data that was requested to be dumped with MADV_DODUMP is
> indeed completely absent.
>
> There was exactly one commit that got merged between next-20210115 and
> next-20120118
> related to core dumps: 8a3cc755b138 ("coredump: don't bother with
> do_truncate()").
> Adding Al Viro to Cc for that.
>
> Naresh, could you try reverting that patch?

This suspecting commit reverted and tested and the test case PASS.

commit 8a3cc755b13808eba74846dfd1033fcbc21f9a65
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Mar 8 09:16:37 2020 -0400

    coredump: don't bother with do_truncate()

    have dump_skip() just remember how much needs to be skipped,
    leave actual seeks/writing zeroes to the next dump_emit()
    or the end of coredump output, whichever comes first.
    And instead of playing with do_truncate() in the end, just
    write one NUL at the end of the last gap (if any).

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 fs/binfmt_elf.c          |  1 -
 fs/coredump.c            | 56 +++++++++++++++++++++++++++---------------------
 include/linux/binfmts.h  |  1 +
 include/linux/coredump.h |  1 -


Test case output link,
https://lkft.validation.linaro.org/scheduler/job/2184975#L1369
https://lkft.validation.linaro.org/scheduler/job/2184972#L1358

- Naresh
