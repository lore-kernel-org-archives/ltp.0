From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 24 Jan 2020 13:55:34 +0100
Subject: [LTP] [PATCH v4 0/3] Add test for misaligned fallocate()
Message-ID: <20200124125537.17714-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch is a follow-up to the fallocate05 fix. The original fallocate05
test accidentally tested some misaligned allocation and deallocation
on platforms with block size bigger than 8k but it didn't validate
the results correctly. Test calling fallocate() on misaligned file range
and this time validate the results properly, taking into account advanced
FS features like copy-on-write.

Changes since v1:
- Fix compilation with --std=c89
- Misalign by at most 512 bytes, otherwise the test may miss an XFS bug on PPC
- Clear the temp directory using tst_purge_dir()
- Remove useless check in purge_dir()
- Fix potential buffer overflow in rmdir()/purge_dir()
- Add description of tst_purge_dir() to test writing guidelines

Martin Doucha (3):
  Add tst_purge_dir() helper function
  Add test for misaligned fallocate()
  Purge temp directory after each run of fallocate05

 doc/test-writing-guidelines.txt               |  11 +
 include/tst_device.h                          |   5 +
 lib/tst_tmpdir.c                              |  97 ++++---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/fallocate/fallocate05.c   |  11 +-
 .../kernel/syscalls/fallocate/fallocate06.c   | 253 ++++++++++++++++++
 6 files changed, 332 insertions(+), 46 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fallocate/fallocate06.c

-- 
2.24.1

