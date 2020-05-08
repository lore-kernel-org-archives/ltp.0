From: Alexander Gordeev <agordeev@linux.ibm.com>
Date: Fri,  8 May 2020 15:09:01 +0200
Subject: [LTP] [PATCH 0/2] syscalls/kcmp03.c: Fix CLONE_IO failure on s390
Message-ID: <cover.1588942426.git.agordeev@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

This series fixes the CLONE_IO flag test on s390:

	kcmp03.c:82: FAIL: clone() Failed: EBADF (9)

The reason for the failure is CLONE_IO flag is sign-
extended to unsigned long and CLONE_INTO_CGROUP gets
set unintentionally. The kernel does its job well and
fails the syscall.

The fix is probably wrong, as the right solution needs to
accomodate all archs. I however, post it as a short-term
solution that might work for other archs as well.

Thanks!

Alexander Gordeev (2):
  syscalls/kcmp03.c: Extend clone_type type to unsigned long
  lib/cloner.c: Use __clone instead of clone for s390

 lib/cloner.c                            | 5 +++++
 testcases/kernel/syscalls/kcmp/kcmp03.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.8.3.1

