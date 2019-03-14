From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 10:49:15 +0100
Subject: [LTP] [PATCH v2 0/4] shell: Add tst_mount() helper
Message-ID: <20190314094919.12723-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

just single change in tst_mount(): it does not require $TST_FS_TYPE any
more (it's optional). This was required by mkfs01.sh which has it's
first run in runtest/commands without specifying filesystem.
I guess this is valid testcase (testing some obscure fs e.g. some FUSE)
which is not in runtest/commands + it also tests mkfs itself.

Kind regards,
Petr

Petr Vorel (4):
  shell: Add tst_mount() helper
  ima, commands/{df,mkfs}: Use tst_mount()
  shell: Move mkfs.foo into tst_mkfs()
  shell: Use $TST_FS_TYPE and $TST_DEVICE in tst_mkfs()

 doc/test-writing-guidelines.txt               | 16 +++++++---
 testcases/commands/df/df01.sh                 | 28 +++-------------
 testcases/commands/mkfs/mkfs01.sh             | 27 ++++------------
 .../security/integrity/ima/tests/ima_setup.sh | 14 +++-----
 testcases/lib/tst_test.sh                     | 32 ++++++++++++++++---
 5 files changed, 56 insertions(+), 61 deletions(-)

-- 
2.21.0

