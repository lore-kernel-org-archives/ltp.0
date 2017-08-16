From: Xiong Zhou <xzhou@redhat.com>
Date: Wed, 16 Aug 2017 15:15:34 +0800
Subject: [LTP] [PATCH v4 0/3] add SAFE_FANOTIFY_INIT and FAN_CLOEXEC check
In-Reply-To: <20170815133616.GD30800@rei>
References: <20170815133616.GD30800@rei>
Message-ID: <1502867737-26158-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v4:
  Delete else branch in helper.
  Make TST_TOTAL a macro instead of integer.
  Use SAFE_CLOSE in cleanup in old cases.
  Use iteration of tst_test.test instead of 2 files.

v3:
  Add SAFE_FANOTIFY_INIT helper.
  Rewrite old cases. Too big a patch, we can also split it.
  Split FAN_CLOEXEC case to 2 separate cases.

Thanks for reviewing!

Xiong Zhou (3):
  lib: add helper SAFE_FANOTIFY_INIT
  fanotify: rewrite old cases with new lib
  syscalls/fanotify08: add sanity check for FAN_CLOEXEC

 include/tst_safe_macros.h                       |   5 +
 lib/tst_safe_macros.c                           |  21 +
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/fanotify/fanotify01.c | 526 +++++++++++-------------
 testcases/kernel/syscalls/fanotify/fanotify02.c | 326 +++++++--------
 testcases/kernel/syscalls/fanotify/fanotify03.c | 254 +++++-------
 testcases/kernel/syscalls/fanotify/fanotify04.c | 165 +++-----
 testcases/kernel/syscalls/fanotify/fanotify05.c | 155 +++----
 testcases/kernel/syscalls/fanotify/fanotify06.c | 193 ++++-----
 testcases/kernel/syscalls/fanotify/fanotify07.c |   9 +-
 testcases/kernel/syscalls/fanotify/fanotify08.c |  91 ++++
 11 files changed, 838 insertions(+), 908 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify08.c

-- 
1.8.3.1

