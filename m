From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:29 +0100
Subject: [LTP] [PATCH 00/18] Collection of fixes
Message-ID: <20171026141447.26749-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This series collects fixes for issues encountered when running ltp on
internal test platforms. The fixes touch a variety of tests - I've
grouped patches touching related tests togther.

The patches fix issue with missing kernel feature detection, improper
synchronisation in certain scenarios, and executing on systems with
minimal userspace such as busybox.

Although the problems were encountered on internal platforms the
patches improve the robustness of the tests and are applicable in wide
ranging test scenarios.

Please consider merging them.

Thanks,
Punit

James Morse (2):
  hotplug/cpu_hotplug: Repopulate cgroup:cpusets after testing hotplug
  hotplug/cpu_hotplug: Remove bashism disown from kill_pid()

Lorenzo Pieralisi (1):
  hugeshmget02: add missing SHM_HUGETLB flag on segment creation

Mark Rutland (2):
  inotify: fix inotify.h breakage
  ioctl: fix stty usage for busybox

Punit Agrawal (1):
  Move check_hugepage() helper to mem/lib

Suzuki K. Poulose (5):
  hugeshmctl01: Fix synchronisation with child processes
  hugeshmctl01: Fix synchronization issue in parent process
  hugeshmctl02: Fix allocation size for odd number of hugepages
  getdtablesize01: Handle ENFILE errno
  perf_event_open: Handle absence of PMU gracefully

Will Deacon (7):
  thp: ensure THP/hugetlbfs is available
  vma03: accept ENOMEM return value from mremap
  creat08: ensure test directories are created in /tmp/
  kill05: fix race on getpwnam
  sigwaitinfo01: fix race between sending and dequeueing RT signals
  sigwaitinfo: catch SEGV and report success for bad_address2 testcase
  syscalls/mount03: Copy setuid_test to execute instead of 'TEST FILE'

 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 36 ++++++++++++
 .../cpu_hotplug/include/cpuhotplug_testsuite.sh    |  1 -
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 64 ++++++++--------------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  3 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c         |  6 --
 testcases/kernel/mem/hugetlb/lib/hugetlb.h         |  1 -
 testcases/kernel/mem/include/mem.h                 |  2 +
 testcases/kernel/mem/lib/mem.c                     |  6 ++
 testcases/kernel/mem/thp/thp01.c                   |  3 +
 testcases/kernel/mem/thp/thp02.c                   |  2 +
 testcases/kernel/mem/thp/thp03.c                   |  2 +
 testcases/kernel/mem/vma/vma03.c                   |  2 +-
 testcases/kernel/syscalls/creat/creat08.c          |  4 +-
 .../syscalls/getdtablesize/getdtablesize01.c       | 17 +++---
 testcases/kernel/syscalls/inotify/inotify.h        |  8 +--
 testcases/kernel/syscalls/ioctl/test_ioctl         |  2 +-
 testcases/kernel/syscalls/kill/kill05.c            |  7 ++-
 testcases/kernel/syscalls/mount/mount03.c          |  4 +-
 .../syscalls/perf_event_open/perf_event_open01.c   |  3 +-
 .../syscalls/perf_event_open/perf_event_open02.c   |  4 +-
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 36 +++++++++++-
 22 files changed, 141 insertions(+), 74 deletions(-)

-- 
2.14.2

