From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jun 2019 14:31:46 +0200
Subject: [LTP] [PATCH 0/2] sync_file_range02 skip tests on FUSE
Message-ID: <20190619123148.29733-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As discussed on LTP ML it does not make sense to run the
sync_file_range.

Cyril Hrubis (2):
  lib: Add flags to tst_get_supported_fs_types()
  syscalls/sync_file_range02: Skip test on fuse.

 include/tst_fs.h                                  |  6 ++++--
 include/tst_test.h                                |  2 ++
 lib/tst_supported_fs_types.c                      | 15 ++++++++++-----
 lib/tst_test.c                                    |  2 +-
 .../syscalls/sync_file_range/sync_file_range02.c  |  1 +
 testcases/lib/tst_supported_fs.c                  |  4 ++--
 6 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.19.2

