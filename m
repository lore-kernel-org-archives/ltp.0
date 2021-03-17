From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 11:53:14 +0100
Subject: [LTP] [PATCH v3 0/4] Add proper filesystem skiplist
Message-ID: <20210317105318.32017-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a proper .skip_filesystems array to the tst_test structure and
implements support for both test with .all_filesystems enabled and
disabled.

As a bonus point we get the list of filesystems that the test does not
support exported to the metadata as well.

Changes in v3:

* Moved the skiplist out of tst_fs_is_supported()
  (as requested by Martin)

* Move paragraph in docs
  (as requested by Peter)

Changes in v2:

* Add docs (as Jan requested)

* Move the skiplist detection from the is_supported_by_kernel()
  to tst_fs_is_supported()
  (as requested by Martin and Li)
  (which also fixed the double message reported by Peter)

* Fixed typos in tst_fs.h header (as requested by Peter)


Cyril Hrubis (4):
  lib: Add proper filesystem skiplist
  lib: tst_fs_type change fs names to lowercase
  lib: Apply the skip_filesystems to rest of test as well
  doc: Update docs on filesystem detection

 doc/test-writing-guidelines.txt               | 47 +++++++++----
 include/tst_fs.h                              | 25 +++++--
 include/tst_test.h                            |  9 ++-
 lib/tst_fs_type.c                             | 36 +++++-----
 lib/tst_supported_fs_types.c                  | 66 +++++++++++++++----
 lib/tst_test.c                                | 14 +++-
 testcases/kernel/syscalls/fcntl/fcntl33.c     | 19 ++----
 .../kernel/syscalls/fsconfig/fsconfig01.c     |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount01.c |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount02.c |  2 +-
 testcases/kernel/syscalls/fsopen/fsopen01.c   |  2 +-
 testcases/kernel/syscalls/fspick/fspick01.c   |  2 +-
 testcases/kernel/syscalls/fspick/fspick02.c   |  2 +-
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 11 ++--
 .../kernel/syscalls/move_mount/move_mount01.c |  2 +-
 .../kernel/syscalls/move_mount/move_mount02.c |  2 +-
 .../kernel/syscalls/open_tree/open_tree01.c   |  2 +-
 .../kernel/syscalls/open_tree/open_tree02.c   |  2 +-
 .../sync_file_range/sync_file_range02.c       |  2 +-
 .../kernel/syscalls/vmsplice/vmsplice01.c     |  9 ++-
 .../kernel/syscalls/vmsplice/vmsplice02.c     |  9 ++-
 testcases/lib/tst_supported_fs.c              |  4 +-
 22 files changed, 176 insertions(+), 95 deletions(-)

-- 
2.26.2

