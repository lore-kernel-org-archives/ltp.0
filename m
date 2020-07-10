From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 10 Jul 2020 13:31:45 +0530
Subject: [LTP] [RFC 0/3] syscalls: Rearrange sigwait syscall tests
Message-ID: <cover.1594367611.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

As suggested by you I have tried to rearrange stuff here and having some
difficulty in getting rid of the last few build and runtime errors. And
so sending this as RFC.

Problem 1: Build failure.
---------

This fails with the error:
ltp/libs/libltpsigwait/sigwaitinfo01.c:53: undefined reference to `create_sig_proc'

create_sig_proc() is defined in lib/ and I am trying to use it in libs/.
Somehow linking is failing here as there is no local user of the routine
create_sig_proc() within lib/ directory. If I create a dummy user
(https://pastebin.com/LiNukt1n) there, then the build passes.

I don't know how to properly fix this.

Problem 2: Runtime breakage.
---------

If I build it using the earlier hack then at runtime I have started to
get following error while running the tests now, right after the first
test passes:

tst_test.c:362: BROK: Child (14595) killed by signal SIGTERM

I don't really understand why this has started to come up now, while it
didn't happen earlier at all.

This is rebased over the earlier series which is under review
(specifically the following patch,
[PATCH V7 10/19] syscalls/rt_sigtimedwait: Add support for time64 tests).

--
viresh

Viresh Kumar (3):
  syscalls: sigwaitinfo: Suppress all warnings around unused parameter
  syscalls: sigwaitinfo: Remove SUCCEED_OR_DIE() macro
  syscalls: sigwait: Separate out code to relevant folders

 include/libsigwait.h                          |  45 ++
 libs/libltpsigwait/Makefile                   |  11 +
 libs/libltpsigwait/sigwait.c                  | 428 +++++++++++++++
 .../kernel/syscalls/rt_sigtimedwait/Makefile  |  10 +-
 .../rt_sigtimedwait/rt_sigtimedwait01.c       |  78 +++
 .../kernel/syscalls/sigtimedwait/Makefile     |   9 +-
 .../syscalls/sigtimedwait/sigtimedwait01.c    |  37 ++
 testcases/kernel/syscalls/sigwait/Makefile    |   9 +-
 testcases/kernel/syscalls/sigwait/sigwait01.c |  37 ++
 .../kernel/syscalls/sigwaitinfo/Makefile      |   4 +-
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 511 +-----------------
 11 files changed, 662 insertions(+), 517 deletions(-)
 create mode 100644 include/libsigwait.h
 create mode 100644 libs/libltpsigwait/Makefile
 create mode 100644 libs/libltpsigwait/sigwait.c
 create mode 100644 testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
 create mode 100644 testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c
 create mode 100644 testcases/kernel/syscalls/sigwait/sigwait01.c

-- 
2.25.0.rc1.19.g042ed3e048af

