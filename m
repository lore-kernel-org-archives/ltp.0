From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:06 +0100
Subject: [LTP] [PATCH 0/8] Fix uninitialized var errors
Message-ID: <20210622113514.22284-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

It would be nice if we could set --Werror=uninitialized by
default. Uninitialized variables can result in nasty compiler
behaviour. You may expect it just to result in garbage data being
used. The result being a crash. However as we compile with -O2 this is
not the case. Often the compiler chooses values for the variable which
will eliminate code. This often means the values are valid. The result
being a program which appears to execute correctly on the
surface. Meanwhile underneath it is doing very little.

In a lot of cases the compiler is simply confused and gives an error,
but there is no undefined behaviour. This is often caused by tst_brk
which is the source of much confusion. Most likely there should be two
versions of tst_brk. One which never returns and is used by test
authors and one which can return, but is usually only used in library
functions which may be called from cleanup.

Richard Palethorpe (8):
  ipc: Fix uninitialized var error by removing useless arg
  ftest: Fix uninitialized var error
  hotplug: Fix uninitialized var
  dio: Fix uninitialized var error
  ksmg01: Fix uninitialized var error
  shmat01: Fix uninitialized var error
  crash02: Save actual child PID instead of uninitialized variable
  locktests: Fix uninitialized var error

 libs/libltpipc/libipc.c                            | 4 +---
 testcases/kernel/fs/ftest/ftest01.c                | 3 +--
 testcases/kernel/fs/ftest/ftest05.c                | 3 +--
 testcases/kernel/hotplug/memory_hotplug/commands.c | 7 +------
 testcases/kernel/io/ltp-aiodio/dio_append.c        | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c        | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_truncate.c      | 4 ++--
 testcases/kernel/logging/kmsg/kmsg01.c             | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl01.c    | 4 +---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c      | 2 +-
 testcases/misc/crash/crash02.c                     | 6 +++---
 testcases/network/nfsv4/locks/locktests.c          | 2 +-
 12 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.31.1

