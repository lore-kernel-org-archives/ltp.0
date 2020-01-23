From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 23 Jan 2020 17:20:16 +0100
Subject: [LTP] [PATCH v3 0/3] Add test for misaligned fallocate()
Message-ID: <20200123162019.18958-1-mdoucha@suse.cz>
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

Martin Doucha (3):
  Add tst_purge_dir() helper function
  Add test for misaligned fallocate()
  Purge temp directory after each run of fallocate05

 include/tst_device.h                          |   5 +
 lib/tst_tmpdir.c                              | 106 +++++---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/fallocate/fallocate05.c   |  11 +-
 .../kernel/syscalls/fallocate/fallocate06.c   | 253 ++++++++++++++++++
 5 files changed, 333 insertions(+), 43 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fallocate/fallocate06.c

-- 
2.24.1

