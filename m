From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 12 Apr 2021 15:54:59 +0100
Subject: [LTP] [PATCH v3 0/7] CGroup API rewrite
Message-ID: <20210412145506.26894-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This is a complete rewrite of the CGroups API. It has big changes even
compared to V2 of the patchset. To understand why this is so
complicated, please see the commments in tst_cgroup.h and
tst_cgroup.c.

V3:

* Replaced the object API with a string based lookup.

* Replaced tst_cgroup_css struct and name mapping functions with an
  item info tree.

* Merged the header files again as there is no longer much seperation
  between the core and item parts of the library.

* Rename some variables and functions to make them more consistent.

V2:

* Created an object (Item) API which looks a bit like the unified V2
  hierarchy. The implementation is quite verbose, but not complicated
  IMO.

* Add the ability to extend the LTP CGroup hierarchy with child
  groups. We already have a reproducer that requires such a hierarchy,
  but I have not had chance to turn it into a test case yet.

* Add documentation for the new API in test-writing-guidelines.txt.

* Convert madvise06 to the CGroups API

* Better error reporting for the *at functions. Add tst_decode_fd
  which tries to print the path an FD was opened with.

TODO/NOTES:

* There are other tests which mount CGroups in an ad-hoc way and need
  to be converted to the new API. This at least includes memcg_test_3
  and maybe cgroup_xattr.

Richard Palethorpe (7):
  API: Add safe openat, printfat, readat and unlinkat
  API: Add macro for the container_of trick
  Add new CGroups APIs
  Add new CGroups API library tests
  docs: Update CGroups API
  mem: Convert tests to new CGroups API
  madvise06: Convert to new CGroups API

 doc/test-writing-guidelines.txt               |  175 ++-
 include/tst_cgroup.h                          |  194 ++-
 include/tst_common.h                          |    5 +
 include/tst_safe_file_ops.h                   |   39 +
 include/tst_test.h                            |    1 -
 lib/Makefile                                  |    2 +
 lib/newlib_tests/.gitignore                   |    2 +
 lib/newlib_tests/test21.c                     |   45 +-
 lib/newlib_tests/tst_cgroup01.c               |   51 +
 lib/newlib_tests/tst_cgroup02.c               |   90 ++
 lib/tst_cgroup.c                              | 1205 ++++++++++++-----
 lib/tst_safe_file_ops.c                       |  171 +++
 testcases/kernel/mem/cpuset/cpuset01.c        |   34 +-
 testcases/kernel/mem/include/mem.h            |    2 +-
 testcases/kernel/mem/ksm/ksm02.c              |   13 +-
 testcases/kernel/mem/ksm/ksm03.c              |   12 +-
 testcases/kernel/mem/ksm/ksm04.c              |   17 +-
 testcases/kernel/mem/lib/mem.c                |   10 +-
 testcases/kernel/mem/oom/oom03.c              |   18 +-
 testcases/kernel/mem/oom/oom04.c              |   19 +-
 testcases/kernel/mem/oom/oom05.c              |   32 +-
 testcases/kernel/syscalls/madvise/madvise06.c |   82 +-
 22 files changed, 1720 insertions(+), 499 deletions(-)
 create mode 100644 lib/newlib_tests/tst_cgroup01.c
 create mode 100644 lib/newlib_tests/tst_cgroup02.c
 create mode 100644 lib/tst_safe_file_ops.c

-- 
2.30.2

