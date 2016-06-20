From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 17:28:48 +0300
Subject: [LTP] [PATCH 0/8] network/nfs: fix/cleanup tests
Message-ID: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alexey Kodanev (8):
  lib: add safe_gethostname()
  network/nfs05: rewrite the test, make use of new library
  network/nfs_lib.sh: add options, socket type and NFS ver
  network/nfs/fsx: cleanup test, use test_net library
  network/nfs/nfsstat: cleanup test, use test_net.sh library
  network/nfs/nfsflock: clenaup & use test_net library
  network/nfs/nfs_fsstress: remove fsstress test
  network/nfs: remove README

 include/safe_net_fn.h                              |    3 +
 include/tst_safe_net.h                             |    3 +
 lib/safe_net.c                                     |   14 +
 runtest/net.nfs                                    |   83 +-
 testcases/network/.gitignore                       |    1 -
 testcases/network/nfs/README                       |   28 -
 testcases/network/nfs/fsx-linux/fsx.sh             |  204 +--
 testcases/network/nfs/nfs_fsstress/Makefile        |    7 -
 testcases/network/nfs/nfs_fsstress/fsstress.c      | 2591 --------------------
 testcases/network/nfs/nfs_fsstress/global.h        |   66 -
 testcases/network/nfs/nfs_fsstress/xfscompat.h     |    7 -
 testcases/network/nfs/nfs_stress/Makefile          |    2 +-
 testcases/network/nfs/nfs_stress/nfs05             |    8 +-
 testcases/network/nfs/nfs_stress/nfs05_make_tree.c |  911 ++------
 testcases/network/nfs/nfs_stress/nfs_lib.sh        |   32 +-
 testcases/network/nfs/nfslock01/nfs_flock_frk.c    |   39 -
 testcases/network/nfs/nfslock01/nfslock01          |  155 +-
 testcases/network/nfs/nfsstat01/nfsstat01          |  343 +--
 18 files changed, 433 insertions(+), 4064 deletions(-)
 delete mode 100644 testcases/network/nfs/README
 delete mode 100644 testcases/network/nfs/nfs_fsstress/fsstress.c
 delete mode 100644 testcases/network/nfs/nfs_fsstress/global.h
 delete mode 100644 testcases/network/nfs/nfs_fsstress/xfscompat.h
 delete mode 100644 testcases/network/nfs/nfslock01/nfs_flock_frk.c

