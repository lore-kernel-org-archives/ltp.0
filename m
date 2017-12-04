From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:43 +0000
Subject: [LTP] [PATCH v3 00/12] Collection of fixes
Message-ID: <20171204163655.8838-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi again,

This is the third posting of a collection of fixes for issues
encountered when running ltp on internal test platforms. Previous
versions can be found at [0][1]. This update addresses all the
feedback received on the previous version.

Changes from v2:

* Dropped check for THP in Patch 2 for thp01.c
* Updated parent/child synchronisation to cover for cases missed in
  the previous version of Patch 3
* Improved detection of successful child exit based on feedback in
  Patch 8
* Patch 9 - renamed helper binary and used TST_RESOURCE_COPY() to copy
  the helper in setup and before usage
* Patch 10 - Changed loop to open files to be infinite. Test still
  breaks out of the loop if there is an error opening the file.
* Dropped Patch 12

[0] http://lists.linux.it/pipermail/ltp/2017-November/006414.html
[1] http://lists.linux.it/pipermail/ltp/2017-October/006225.html

James Morse (1):
  hotplug/cpu_hotplug: Remove bashism disown from kill_pid()

Lorenzo Pieralisi (1):
  hugeshmget02: add missing SHM_HUGETLB flag on segment creation

Punit Agrawal (5):
  Move check_hugepage() helper to mem/lib
  hugeshmctl01: Convert to LTP synchronisation primitives
  hugeshmctl01: Fix warning about signed/unsigned comparison
  sigwaitinfo01: catch SEGV and report success for bad_address2 testcase
  syscalls/mount03: Copy setuid_test to execute instead of 'TEST FILE'

Suzuki K. Poulose (3):
  hugeshmctl02: Fix allocation size for odd number of hugepages
  getdtablesize01: Handle ENFILE errno
  perf_event_open: Handle absence of PMU gracefully

Will Deacon (2):
  thp: ensure hugetlbfs is available
  sigwaitinfo01: fix race between sending and dequeueing RT signals

 .../cpu_hotplug/include/cpuhotplug_testsuite.sh    |  1 -
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 75 ++++------------------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  3 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c         |  7 --
 testcases/kernel/mem/hugetlb/lib/hugetlb.h         |  1 -
 testcases/kernel/mem/include/mem.h                 |  2 +
 testcases/kernel/mem/lib/mem.c                     |  6 ++
 testcases/kernel/mem/thp/thp02.c                   |  2 +
 testcases/kernel/mem/thp/thp03.c                   |  2 +
 .../syscalls/getdtablesize/getdtablesize01.c       | 15 +++--
 testcases/kernel/syscalls/mount/mount03.c          | 11 ++--
 .../mount/{setuid_test.c => mount03_setuid_test.c} |  0
 .../syscalls/perf_event_open/perf_event_open01.c   |  3 +-
 .../syscalls/perf_event_open/perf_event_open02.c   |  4 +-
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 28 +++++++-
 16 files changed, 75 insertions(+), 87 deletions(-)
 rename testcases/kernel/syscalls/mount/{setuid_test.c => mount03_setuid_test.c} (100%)

-- 
2.15.0

