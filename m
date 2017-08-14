From: Xiong Zhou <xzhou@redhat.com>
Date: Mon, 14 Aug 2017 22:01:48 +0800
Subject: [LTP] [PATCH v3 0/3] add SAFE_FANOTIFY_INIT and FAN_CLOEXEC cases
In-Reply-To: <20170811084138.GA3341@rei.lan>
References: <20170811084138.GA3341@rei.lan>
Message-ID: <1502719311-18774-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v3:
  Add SAFE_FANOTIFY_INIT helper.
  Rewrite old cases. Too big a patch, we can also split it.
  Split FAN_CLOEXEC case to 2 separate cases.

Thanks for reviewing!

Xiong Zhou (3):
  lib: add helper SAFE_FANOTIFY_INIT
  fanotify: rewrite old cases with new lib
  syscalls/fanotify0[89]: add sanity check for FAN_CLOEXEC

 include/tst_safe_macros.h                       |   5 +
 lib/tst_safe_macros.c                           |  23 ++
 runtest/syscalls                                |   2 +
 testcases/kernel/syscalls/fanotify/fanotify01.c | 520 +++++++++++-------------
 testcases/kernel/syscalls/fanotify/fanotify02.c | 320 +++++++--------
 testcases/kernel/syscalls/fanotify/fanotify03.c | 248 +++++------
 testcases/kernel/syscalls/fanotify/fanotify04.c | 159 +++-----
 testcases/kernel/syscalls/fanotify/fanotify05.c | 153 +++----
 testcases/kernel/syscalls/fanotify/fanotify06.c | 191 ++++-----
 testcases/kernel/syscalls/fanotify/fanotify07.c |   9 +-
 testcases/kernel/syscalls/fanotify/fanotify08.c |  77 ++++
 testcases/kernel/syscalls/fanotify/fanotify09.c |  77 ++++
 12 files changed, 891 insertions(+), 893 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify08.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify09.c

-- 
1.8.3.1

