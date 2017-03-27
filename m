From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 27 Mar 2017 11:23:16 +0800
Subject: [LTP] [PATCH] nfsv4/locks: fix unmatched filename
Message-ID: <1490584996-3556-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Actually, locktests.tar.gz instead of locktests-2.tar.gz
is processed in locktests.py.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/network/nfsv4/locks/deploy_info  | 2 +-
 testcases/network/nfsv4/locks/locktests.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfsv4/locks/deploy_info b/testcases/network/nfsv4/locks/deploy_info
index 4402f94..b8a4660 100644
--- a/testcases/network/nfsv4/locks/deploy_info
+++ b/testcases/network/nfsv4/locks/deploy_info
@@ -1,7 +1,7 @@
 locktest.py script aims to help deploying and running locktests over multiple NFS
 clients accessing the same server.
 
-The source code of NFS client test is in ./deploy/locktests-2.tar.gz
+The source code of NFS client test is in ./deploy/locktests.tar.gz
 
 Setting up lock test with several test machines.
 ================================================
diff --git a/testcases/network/nfsv4/locks/locktests.py b/testcases/network/nfsv4/locks/locktests.py
index a01630d..dd518ab 100755
--- a/testcases/network/nfsv4/locks/locktests.py
+++ b/testcases/network/nfsv4/locks/locktests.py
@@ -19,7 +19,7 @@ TEST_HOME="/home/vincent/locks/"
 testfile=NFS4_PATH+"/testfile"
 
 app="locktests"
-SRC="locktests-2.tar.gz"
+SRC="locktests.tar.gz"
 SRC_PATH="deploy"
 install="'tar xzf "+SRC+"; cd locks;  make `"
 user="root"
-- 
1.8.3.1



