From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 21 Nov 2017 16:15:37 +0000
Subject: [LTP] [PATCH v2 00/13] Collection of fixes
In-Reply-To: <20171114155929.24237-1-punit.agrawal@arm.com> (Punit Agrawal's
 message of "Tue, 14 Nov 2017 15:59:16 +0000")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
Message-ID: <87k1yjppzq.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Punit Agrawal <punit.agrawal@arm.com> writes:

> Hi,
>
> This is the second posting of that collects fixes for issues
> encountered when running ltp on internal test platforms. Previous
> version can be found at [0]. This update addresses all the feedback
> received on the previous version.
>
> Changes:
>
> v2:
> * removed check_hugepage() prototype from hugetlb.h (patch 1)
> * hugeshmctl01 - migrate to using checkpoint synchronisation primitives
> * sigwaitinfo - use child process to execute test instead of using
>   longjmp based solution
> * Dropped patches that are no longer applicable or already merged
>
> If there aren't anymore comments, please consider them for merging.

I'd appreciate any feedback on this patch set. This update addresses all
the comments received on the previous version.

If the patches look good, please consider merging them.

>
> Thanks,
> Punit
>
> [0] http://lists.linux.it/pipermail/ltp/2017-October/006225.html
>
> James Morse (2):
>   hotplug/cpu_hotplug: Repopulate cgroup:cpusets after testing hotplug
>   hotplug/cpu_hotplug: Remove bashism disown from kill_pid()
>
> Lorenzo Pieralisi (1):
>   hugeshmget02: add missing SHM_HUGETLB flag on segment creation
>
> Punit Agrawal (4):
>   Move check_hugepage() helper to mem/lib
>   hugeshmctl01: Convert to LTP synchronisation primitives
>   hugeshmctl01: Fix warning about signed/unsigned comparison
>   sigwaitinfo01: catch SEGV and report success for bad_address2 testcase
>
> Suzuki K. Poulose (3):
>   hugeshmctl02: Fix allocation size for odd number of hugepages
>   getdtablesize01: Handle ENFILE errno
>   perf_event_open: Handle absence of PMU gracefully
>
> Will Deacon (3):
>   thp: ensure THP/hugetlbfs is available
>   sigwaitinfo01: fix race between sending and dequeueing RT signals
>   syscalls/mount03: Copy setuid_test to execute instead of 'TEST FILE'
>
>  .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 36 ++++++++++
>  .../cpu_hotplug/include/cpuhotplug_testsuite.sh    |  1 -
>  .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 77 ++++------------------
>  .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  2 +-
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  3 +-
>  testcases/kernel/mem/hugetlb/lib/hugetlb.c         |  6 --
>  testcases/kernel/mem/hugetlb/lib/hugetlb.h         |  3 -
>  testcases/kernel/mem/include/mem.h                 |  2 +
>  testcases/kernel/mem/lib/mem.c                     |  6 ++
>  testcases/kernel/mem/thp/thp01.c                   |  3 +
>  testcases/kernel/mem/thp/thp02.c                   |  2 +
>  testcases/kernel/mem/thp/thp03.c                   |  2 +
>  .../syscalls/getdtablesize/getdtablesize01.c       | 17 +++--
>  testcases/kernel/syscalls/mount/mount03.c          |  4 +-
>  .../syscalls/perf_event_open/perf_event_open01.c   |  3 +-
>  .../syscalls/perf_event_open/perf_event_open02.c   |  4 +-
>  .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 34 +++++++++-
>  17 files changed, 117 insertions(+), 88 deletions(-)
