From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 11:28:01 +0200
Subject: [LTP] [RFC PATCH 0/8] Fix compilation with -fno-common (gcc-10)
Message-ID: <20200415092809.20240-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

there was more broken code than I first expected.
Comments and testing are welcome.

https://travis-ci.org/github/pevik/ltp/builds/675216826

Kind regards,
Petr

Petr Vorel (8):
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
 include/tst_test.h                            |  6 ++--
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
 testcases/realtime/include/librttest.h        |  1 -
 testcases/realtime/lib/librttest.c            |  1 +
 20 files changed, 38 insertions(+), 47 deletions(-)

-- 
2.26.0

