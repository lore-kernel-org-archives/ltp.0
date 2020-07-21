From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 21 Jul 2020 14:22:01 +0530
Subject: [LTP] [PATCH V2 0/3] syscalls: Rearrange sigwait syscall tests
Message-ID: <cover.1595321086.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

As suggested by you I have tried to rearrange stuff here and I was able
to fix the linking issues reported earlier by doing following:

-LDLIBS  += -lltpsigwait
+LDLIBS  := -lltpsigwait $(LDLIBS)

And so here is the proper series now, all working fine.

This is rebased over the earlier series which is under review
(specifically the following patch,
[PATCH V7 10/19] syscalls/rt_sigtimedwait: Add support for time64 tests).

V2:
- Fixed build issues with proper ordering of libraries.

--
Viresh

Viresh Kumar (3):
  syscalls: sigwaitinfo: Suppress all warnings around unused parameter
  syscalls: sigwaitinfo: Remove SUCCEED_OR_DIE() macro
  syscalls: sigwait: Separate out code to relevant folders

 include/libsigwait.h                               |  45 ++
 libs/libltpsigwait/Makefile                        |  11 +
 libs/libltpsigwait/sigwait.c                       | 428 +++++++++++++++++
 testcases/kernel/syscalls/rt_sigtimedwait/Makefile |  10 +-
 .../syscalls/rt_sigtimedwait/rt_sigtimedwait01.c   |  78 ++++
 testcases/kernel/syscalls/sigtimedwait/Makefile    |   9 +-
 .../kernel/syscalls/sigtimedwait/sigtimedwait01.c  |  37 ++
 testcases/kernel/syscalls/sigwait/Makefile         |   9 +-
 testcases/kernel/syscalls/sigwait/sigwait01.c      |  37 ++
 testcases/kernel/syscalls/sigwaitinfo/Makefile     |   4 +-
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 511 +--------------------
 11 files changed, 662 insertions(+), 517 deletions(-)
 create mode 100644 include/libsigwait.h
 create mode 100644 libs/libltpsigwait/Makefile
 create mode 100644 libs/libltpsigwait/sigwait.c
 create mode 100644 testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
 create mode 100644 testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c
 create mode 100644 testcases/kernel/syscalls/sigwait/sigwait01.c

-- 
2.14.1

