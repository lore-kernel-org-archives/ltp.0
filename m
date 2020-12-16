From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 16 Dec 2020 10:01:16 +0000
Subject: [LTP] [RFC PATCH 0/5] CGroups
Message-ID: <20201216100121.16683-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a request for comment on a new CGroups API. I have tried to
keep the existing API functions, but there are many changes in the
implementation. Please see the commit message to "CGroup API rewrite"
in this series.

A previous failed attempt to correct some problems and discussion is
here: http://lists.linux.it/pipermail/ltp/2020-November/019586.html
This is a much bigger change than I would like, but CGroups make it
very difficult to do anything simply.

I have done a direct conversion of the test cases to the new API, but
I am not sure that it makes sense to call tst_cgroup_move_current
within the run method of a test because after the first iteration it
will be a NOP. There is also the issue that on the unified hierarchy
when calling

tst_cgroup_move_current(TST_CGROUP_MEMORY);
... testing ...
tst_cgroup_move_current(TST_CGROUP_CPUSET);

the second call is a NOP as there is only one CGroup, but when the
hierarchies are mounted seperately on V1 the current process will not
be added to cpuset CGroup until the second call. We probably do not
want different behaviour between commonly used hierarchies.

In a lot of cases, the test probably only requires the process to be
moved into a CGroup during setup, but this requires an investigation
of each test. Some tests scan for NUMA information and use this in the
CGroup config which complicates matters. However it seems unlikely to
me that the available NUMA nodes will change between test iterations
unless we are testing hotplugging or failover.

For tests which are actually testing CGroups themselves, most of the
API is too high-level. Please see the kernel self tests for what may
be required for those kinds of tests.

This is not meant for full review and has not been tested on older
setups yet.

Richard Palethorpe (5):
  safe_file_ops: Introduce openat and printfat API
  CGroup API rewrite
  CGroup API tests
  CGroup test guidelines
  cgroups: convert tests to use API rewrite

 doc/test-writing-guidelines.txt        |  18 +-
 include/tst_cgroup.h                   | 103 ++-
 include/tst_safe_file_ops.h            |  38 +
 lib/newlib_tests/.gitignore            |   1 +
 lib/newlib_tests/test21.c              |  30 +-
 lib/newlib_tests/tst_cgroup.c          |  61 ++
 lib/tst_cgroup.c                       | 960 ++++++++++++++++---------
 lib/tst_safe_file_ops.c                | 126 ++++
 testcases/kernel/mem/cpuset/cpuset01.c |  18 +-
 testcases/kernel/mem/include/mem.h     |   2 +-
 testcases/kernel/mem/ksm/ksm02.c       |   8 +-
 testcases/kernel/mem/ksm/ksm03.c       |   8 +-
 testcases/kernel/mem/ksm/ksm04.c       |  15 +-
 testcases/kernel/mem/lib/mem.c         |   8 +-
 testcases/kernel/mem/oom/oom03.c       |  12 +-
 testcases/kernel/mem/oom/oom04.c       |  10 +-
 testcases/kernel/mem/oom/oom05.c       |  23 +-
 17 files changed, 996 insertions(+), 445 deletions(-)
 create mode 100644 lib/newlib_tests/tst_cgroup.c
 create mode 100644 lib/tst_safe_file_ops.c

-- 
2.29.2

