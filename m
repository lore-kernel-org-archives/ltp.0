From: Sandeep Patil <sspatil@google.com>
Date: Mon, 13 Nov 2017 18:11:14 -0800
Subject: [LTP] [PATCH v2 0/4] Miscellaneous fixes for Android systems
Message-ID: <20171114021118.103786-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Following series of patches fixes the review comments from the v1.
Each difference annotated in the patch.

Sandeep Patil (4):
  mm: mallocstress: use new library and safe macros
  checkpoint: add TST_CHECKPOINT_INIT() for new library headers
  mm: mallocstress: use futexes instead of SysV semaphores
  lib: mkfs: use 'mke2fs' for formatting extN filesystems

 include/tst_checkpoint.h                    |   9 +
 include/tst_fs.h                            |  13 ++
 lib/tst_mkfs.c                              |  17 +-
 lib/tst_supported_fs_types.c                |  38 +++-
 testcases/kernel/mem/mtest07/mallocstress.c | 310 ++++++++--------------------
 5 files changed, 150 insertions(+), 237 deletions(-)

-- 
2.15.0.448.gf294e3d99a-goog

