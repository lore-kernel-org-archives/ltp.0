From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:46 +0300
Subject: [LTP] [PATCH v2 0/6] add open/openat + O_TMPFILE tests
Message-ID: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2:
* move dir_not_empty() -> tst_dir_is_empty() to a library,
* add SAFE_LINKAT, SAFE_READLINK macros,
* move O_TMPFILE definition to lapi/fcntl.h
* use relative path for test_dir,
* enable len_strict in SAFE_WRITE,
* set constant buffer size.

Alexey Kodanev (6):
  lib/tst_dir_is_empty: add a library function
  include/lapi/fcntl.h: add O_TMPFILE definition
  lib/safe_macros: add linkat()
  lib/safe_macros: add readlink()
  kernel/syscalls: add new test with 'open() + O_TMPFILE'
  kernel/syscalls/open14: openat03: add new test-cases

 include/lapi/fcntl.h                        |    4 +
 include/safe_macros.h                       |   13 ++
 include/test.h                              |    8 +
 lib/safe_macros.c                           |   35 ++++
 lib/tst_dir_is_empty.c                      |   49 +++++
 runtest/syscalls                            |    2 +
 testcases/kernel/syscalls/.gitignore        |    2 +
 testcases/kernel/syscalls/open/open14.c     |  253 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/openat/openat03.c |  252 ++++++++++++++++++++++++++
 9 files changed, 618 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_dir_is_empty.c
 create mode 100644 testcases/kernel/syscalls/open/open14.c
 create mode 100644 testcases/kernel/syscalls/openat/openat03.c

