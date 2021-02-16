From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Feb 2021 06:33:12 +0530
Subject: [LTP] LTP: madvise08.c:203: TFAIL: No sequence in dump after
 MADV_DODUMP.
In-Reply-To: <YCqGX36I+KR7SoA8@zeniv-ca.linux.org.uk>
References: <CA+G9fYsvDWDogC+xgeG2V9MMofV5svTipDigDiUBje+2jSRK8g@mail.gmail.com>
 <CAK8P3a2OeeW29ekbD70Ns4LTjGRJRT9P0wM-SAxUin1zAxP7TA@mail.gmail.com>
 <CA+G9fYv89bfbixjuudPWkBAucTYg7qhNxcV54RMEkRP5is-bnQ@mail.gmail.com>
 <YCmAGNyFAOZs7GCG@zeniv-ca.linux.org.uk>
 <CA+G9fYsZnBv4wAEKYb0mgMd-BsgXcPUGBQ=VRKcONqAZry_4XQ@mail.gmail.com>
 <YCqGX36I+KR7SoA8@zeniv-ca.linux.org.uk>
Message-ID: <CA+G9fYuq7bpDhY3cA5O66bf0nxKUkbtiTMcLMqBYvWKLhNfrjQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 15 Feb 2021 at 20:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 15, 2021 at 02:11:15PM +0530, Naresh Kamboju wrote:
>
> > fs/coredump.c:903:9: error: 'return' with a value, in function
> > returning void [-Werror=return-type]
> >  903 | return 0;
> >         | ^
> >
> > Build failed due to above error.
>
> FWIW, here the test results in
> Running tests.......
> <<<test_start>>>
> tag=madvise08 stime=1613398818
> cmdline="madvise08"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
> madvise08.c:78: TINFO: Temporary core pattern is '/tmp/ltp-tgvQ3Lz1UZ/B6lwy6/dump-%p'
> madvise08.c:117: TINFO: Dump file should be dump-2276
> madvise08.c:201: TPASS: madvise(..., MADV_DONTDUMP)
> madvise08.c:117: TINFO: Dump file should be dump-2277
> madvise08.c:205: TPASS: madvise(..., MADV_DODUMP)
>
> Summary:
> passed   2
> failed   0
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
>
> (built without -Werror=return-type, so I'd missed the warnings)
>
> Anyway, I've folded the fix (with those stray return 0 removed, of course)
> into #work.coredump and #for-next; works here.  Could you test either
> branch (in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git)?

By using Linaro tuxsuite [1] I have built your tree and tested on x86_64 and
the reported test PASS now.

LTP syscalls [2] and LTP fs [3] tested on x86_64 and both PASS.

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>


[1] https://gitlab.com/Linaro/tuxsuite
[2] https://lkft.validation.linaro.org/results/2278012
[3] https://lkft.validation.linaro.org/results/2280979

- Naresh
