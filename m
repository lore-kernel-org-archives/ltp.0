From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 10 Nov 2016 09:37:45 +0800
Subject: [LTP] [PATCH] syscalls/nice05: remove obsolete data
Message-ID: <1478741865-23646-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove obsolete data since nice05 has been removed.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                      | 1 -
 runtest/quickhit                     | 2 --
 runtest/stress.part3                 | 1 -
 runtest/syscalls                     | 1 -
 testcases/kernel/syscalls/.gitignore | 1 -
 5 files changed, 6 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index 4ad77f3..c8d0ebf 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -547,7 +547,6 @@ nice01 nice01
 nice02 nice02
 nice03 nice03
 nice04 nice04
-nice05 nice05
 
 open01 open01
 open01A symlink01 -T open01
diff --git a/runtest/quickhit b/runtest/quickhit
index 282ad24..c286add 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -188,8 +188,6 @@ mkdir08 mkdir08
 # Basic test for mkdir(2)
 qmm01 mmap001 -m 1
 # Basic mmap() test.
-nice05 nice05
-# Basic test for nice(2)
 open03 open03
 # Basic test for open(2)
 pathconf01 pathconf01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 6b48316..aac1c00 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -461,7 +461,6 @@ nice01 nice01
 nice02 nice02
 nice03 nice03
 nice04 nice04
-nice05 nice05
 
 open01 open01
 open01A symlink01 -T open01
diff --git a/runtest/syscalls b/runtest/syscalls
index e6b36ae..64d09b2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -718,7 +718,6 @@ nice01 nice01
 nice02 nice02
 nice03 nice03
 nice04 nice04
-nice05 nice05
 
 open01 open01
 open01A symlink01 -T open01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0807e17..506219d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -621,7 +621,6 @@
 /nice/nice02
 /nice/nice03
 /nice/nice04
-/nice/nice05
 /open/open01
 /open/open02
 /open/open03
-- 
1.8.3.1



