From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Nov 2019 16:43:59 +0100
Subject: [LTP] [PATCH 0/2] LTP wrapper for Syzkaller reproducers
In-Reply-To: <20191107153458.16917-1-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
Message-ID: <CACT4Y+YuKTob0TovN9f2N_Fdnvg=ODe5dnR1bh=wgVaz=QGHEw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 7, 2019 at 4:35 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> Hello,
>
> This allows the user to run ./configure --with-syzkaller-repros and it will
> automatically fetch the reproducers and generate the necessary LTP runtest
> files which use 'syzwrap' to wrap the Syzkaller reproducers.
>
> Optimistically speaking, this should allow you to run the reproducers in your
> normal LTP test setup if you reduce the timeouts and your test runner is
> reasonably advanced (see README.md).
>
> I have been testing this with a modified version of Metan's runltp-ng which
> almost runs the reproducers smoothly ;-). We haven't got around to documenting
> it yet, but you can find it here:
>
> https://github.com/richiejp/runltp-ng/tree/syzkaller
>
> I began adding some sandboxing to syzwrap from the Syzkaller executor, but I
> found this simply broke many of the reproducers which need access to
> TAP/TUN. I guess the reproducers can be regenerated with the sanboxing built
> in if the user cares enough. However I have left in the ability for syzwrap to
> optionally add some sandboxing. This does appear to help prevent the root file
> system from being trashed at the cost of breaking some reproducers.
>
> Of course if the test runner can reset the SUT to a good state, then the
> sandboxing is not necessary. This is quite easy to do with QEMU using image
> overlays.
>
> Richard Palethorpe (2):
>   Wrapper for Syzkaller reproducers
>   lib: Allow timeout coefficient < 1
>
>  .gitmodules                                  |   5 +
>  configure.ac                                 |  11 ++
>  include/mk/features.mk.default               |   2 +
>  include/mk/features.mk.in                    |   2 +
>  lib/tst_test.c                               |   2 +-
>  runtest/.gitignore                           |   1 +
>  testcases/kernel/Makefile                    |   1 +
>  testcases/kernel/syzkaller-repros/.gitignore |   1 +
>  testcases/kernel/syzkaller-repros/Makefile   | 100 ++++++++++++++
>  testcases/kernel/syzkaller-repros/README.md  |  45 +++++++
>  testcases/kernel/syzkaller-repros/syzwrap.c  | 133 +++++++++++++++++++
>  11 files changed, 302 insertions(+), 1 deletion(-)
>  create mode 100644 runtest/.gitignore
>  create mode 100644 testcases/kernel/syzkaller-repros/.gitignore
>  create mode 100644 testcases/kernel/syzkaller-repros/Makefile
>  create mode 100644 testcases/kernel/syzkaller-repros/README.md
>  create mode 100644 testcases/kernel/syzkaller-repros/syzwrap.c
>
> --
> 2.23.0
>

+syzkaller mailing list FTR
