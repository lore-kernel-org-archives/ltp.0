From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 6 Sep 2017 17:56:21 +0800
Subject: [LTP] [PATCH 1/3] syscalls/creat: Add "static" in creat01 and
	creat04
Message-ID: <20170906095623.10358-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat01.c | 4 ++--
 testcases/kernel/syscalls/creat/creat04.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat01.c b/testcases/kernel/syscalls/creat/creat01.c
index 571c771..6b70be2 100644
--- a/testcases/kernel/syscalls/creat/creat01.c
+++ b/testcases/kernel/syscalls/creat/creat01.c
@@ -36,12 +36,12 @@
 static char filename[40];
 static int fd;
 
-void setup(void)
+static void setup(void)
 {
 	sprintf(filename, "creat01.%d", getpid());
 }
 
-struct tcase {
+static struct tcase {
 	int mode;
 } tcases[] = {
 	{0644},
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index c973108..ebcaa17 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -68,7 +68,7 @@ static void verify_creat(unsigned int i)
 		child_fn(i);
 }
 
-void setup(void)
+static void setup(void)
 {
 	struct passwd *pw;
 	int fd;
-- 
2.9.4



