From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Jun 2017 11:40:20 +0800
Subject: [LTP] [PATCH] commands: fix unmatched installation path of datafiles
Message-ID: <1498794020-9569-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Both file01 and unzip01 fail due to unmatched installation
path of datafiles.  It has been broken by:

commit f9a91c164ac52a4c91ff6aa9c156f110d04158d6
Author: Li Wang <liwang@redhat.com>
Date:   Wed May 24 15:18:31 2017 +0800

	tst_tests.sh: set the shell TST_ID automatically

We need to change installation path of datafiles to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/commands/file/datafiles/Makefile  | 2 +-
 testcases/commands/unzip/datafiles/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/file/datafiles/Makefile b/testcases/commands/file/datafiles/Makefile
index d3cb847..2b5ee3c 100644
--- a/testcases/commands/file/datafiles/Makefile
+++ b/testcases/commands/file/datafiles/Makefile
@@ -14,6 +14,6 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/file01
+INSTALL_DIR		:= testcases/data/file_test
 INSTALL_TARGETS		:= in*
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/unzip/datafiles/Makefile b/testcases/commands/unzip/datafiles/Makefile
index 1b993f6..f636215 100644
--- a/testcases/commands/unzip/datafiles/Makefile
+++ b/testcases/commands/unzip/datafiles/Makefile
@@ -14,6 +14,6 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
-INSTALL_DIR		:= testcases/data/unzip01
+INSTALL_DIR		:= testcases/data/unzip_tests
 INSTALL_TARGETS		:= test.zip dir.out
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.8.3.1



