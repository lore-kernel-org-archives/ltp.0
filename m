From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 30 Apr 2021 12:26:42 +0100
Subject: [LTP] [PATCH v5 0/7] CGroup API rewrite
Message-ID: <20210430112649.16302-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This is a complete rewrite of the CGroups API. To understand why this
is so complicated, please see the commments in tst_cgroup.h and
tst_cgroup.c.

V5:

* Change group_name to a dynamic buffer and use NAME_MAX for file name
  buffer sizes.

* Compare whole string in file_find and brk if name is not in
  recognised format.

* Fix bug introduced in V4 by mixing up cgroup.subtree_control and
  cgroup.clone_children.

* Add note to for_each_dir.

* Add check for the number of conversions in cgroup_scanf. This
  requires count_scanf_conversions to become public.

* Constify

* Add license and stdio.h to tst_safe_file_at.c

V4:

* Move openat based helpers to tst_safe_file_at.h.

* Switch to userland naming of controllers (ctrl for short) instead of
  kernel's css (CGroup subsystem).

* Use more descriptive names such as dir_fd and tst_cgroup_group. Note
  that we discussed calling it tst_cgroup_node. However in the end I
  thought this was too generic and instead went with repetition.

* Split cgroup_item into cgroup_file and cgroup_ctrl. Also make the
  lookup tree definition more verbose to avoid the missing field
  warnings and setting the ctrl index at runtime.

* make enum tst_cgroup_ctrl private; use controller name in
  tst_cgroup_require.

* make struct tst_cgroup_dir private.

* Eliminate use of cgroup_get_ctrl and pass the ctrl struct around
  instead of the indx.

* Deleted test21 as it is superseded by tst_cgroup02.c.

* Remove container_of macro as it is no longer used by this patch set.

* Fix tst_cgroup_{scan,require,mount} in unlikely case it is run
  inside cleanup or some other context where tst_brk may return.

* Fix potential null-ptr-deref in cgroup_file_alias.

* Include sys/types.h in header due to use of (s)size_t.

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
  API: Make tst_count_scanf_conversions public
  Add new CGroups APIs
  Add new CGroups API library tests
  docs: Update CGroups API
  mem: Convert tests to new CGroups API
  madvise06: Convert to new CGroups API

 doc/test-writing-guidelines.txt               |  175 ++-
 include/safe_file_ops_fn.h                    |   10 +
 include/tst_cgroup.h                          |  179 ++-
 include/tst_safe_file_at.h                    |   51 +
 include/tst_test.h                            |    1 -
 lib/newlib_tests/.gitignore                   |    3 +-
 lib/newlib_tests/test21.c                     |   66 -
 lib/newlib_tests/tst_cgroup01.c               |   51 +
 lib/newlib_tests/tst_cgroup02.c               |   90 ++
 lib/safe_file_ops.c                           |   16 +-
 lib/tst_cgroup.c                              | 1290 +++++++++++++----
 lib/tst_safe_file_at.c                        |  176 +++
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
 22 files changed, 1799 insertions(+), 548 deletions(-)
 create mode 100644 include/tst_safe_file_at.h
 delete mode 100644 lib/newlib_tests/test21.c
 create mode 100644 lib/newlib_tests/tst_cgroup01.c
 create mode 100644 lib/newlib_tests/tst_cgroup02.c
 create mode 100644 lib/tst_safe_file_at.c

-- 
2.31.1

