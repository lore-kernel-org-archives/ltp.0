From: Ma Feng <mafeng.ma@huawei.com>
Date: Tue, 29 Oct 2019 14:19:08 +0800
Subject: [LTP] [PATCH] testcases/kernel/fs/ftest:Fix some comment errors
Message-ID: <1572329948-97062-1-git-send-email-mafeng.ma@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I found some comment errors may cause misunderstandings
when I simply read ftest's descriptions

Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 testcases/kernel/fs/ftest/ftest06.c | 2 +-
 testcases/kernel/fs/ftest/ftest07.c | 2 +-
 testcases/kernel/fs/ftest/ftest08.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index b434067..c3aebe5 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -25,7 +25,7 @@
  * 	this is the same as ftest2, except that it uses lseek64
  *
  * CALLS
- *	open, close,  read, write, llseek,
+ *	open, close,  read, write, lseek64,
  *	unlink, chdir
  *
  *
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index e5998b5..3b5b2a4 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -23,7 +23,7 @@
  *	ftest07.c -- test file I/O with readv and writev (ported from SPIE,
  *		    section2/filesuite/ftest9.c
  *
- * 	this is the same as ftest4, except that it uses lseek64
+ * 	this is the same as ftest3, except that it uses lseek64
  *
  * CALLS
  *	lseek64, readv, writev,
diff --git a/testcases/kernel/fs/ftest/ftest08.c b/testcases/kernel/fs/ftest/ftest08.c
index 5e46248..e7fb56f 100644
--- a/testcases/kernel/fs/ftest/ftest08.c
+++ b/testcases/kernel/fs/ftest/ftest08.c
@@ -23,7 +23,7 @@
  *	ftest08.c -- test single file io (tsfio.c by rbk) (ported from SPIE,
  *		     section2/filesuite/ftest10.c, by Airong Zhang)
  *
- * 	this is the same as ftest5, except that it uses lseek64
+ * 	this is the same as ftest4, except that it uses lseek64
  *
  * CALLS
  *	fsync, sync, lseek64, read, write
-- 
2.6.2

