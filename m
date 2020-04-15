From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:26 +0200
Subject: [LTP] [PATCH v2 0/9] Fix compilation with -fno-common (gcc-10)
Message-ID: <20200415112635.14144-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I added 1st commit "Remove use of TCID in new API tests" which allows to
remove extern const char *TCID;

https://travis-ci.org/github/pevik/ltp/builds/675251626

Kind regards,
Petr

Petr Vorel (9):
  Remove use of TCID in new API tests
  lib: Fix linking error multiple TCID definitions with -fno-common
  controllers: Simplify fullpath definition
  controllers: Fix linking with -fno-common
  kernel/mem: Fix linking error with -fno-common
  hugepage: Fix linking error with -fno-common
  hugetlb: Fix linking error with -fno-common
  realtime: Fix linking error with -fno-common
  travis: Build with -fno-common

 build.sh                                      |  2 +-
 include/tst_hugepage.h                        |  4 +--
 include/tst_test.h                            |  4 ---
 lib/tst_hugepage.c                            |  2 ++
 lib/tst_test.c                                |  5 +++
 .../controllers/cpuctl/cpuctl_def_task01.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task02.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task03.c    |  2 --
 .../controllers/cpuctl/cpuctl_def_task04.c    |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test01.c |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test02.c |  1 -
 .../kernel/controllers/cpuctl/cpuctl_test03.c |  2 --
 .../kernel/controllers/cpuctl/cpuctl_test04.c |  2 --
 .../libcontrollers/libcontrollers.c           | 11 +++++++
 .../libcontrollers/libcontrollers.h           | 32 ++++++-------------
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  2 ++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  2 +-
 testcases/kernel/mem/include/mem.h            |  2 +-
 .../kernel/mem/tunable/overcommit_memory.c    |  4 +--
 .../security/integrity/ima/src/ima_mmap.c     |  3 +-
 .../syscalls/memfd_create/memfd_create01.c    |  3 +-
 testcases/realtime/include/librttest.h        |  1 -
 testcases/realtime/lib/librttest.c            |  1 +
 23 files changed, 42 insertions(+), 51 deletions(-)

-- 
2.26.0

