From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Mar 2018 16:53:22 +0800
Subject: [LTP] [PATCH 1/2] syscalls/preadv01: Run test for all filesystems
Message-ID: <1522400003-11319-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/preadv/preadv01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 5ee27fb..1f3f714 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -30,6 +30,8 @@
 #include "preadv.h"
 
 #define CHUNK           64
+#define MNTPOINT	"mntpoint"
+#define FNAME	MNTPOINT"/file"
 
 static int fd;
 static char buf[CHUNK];
@@ -97,7 +99,7 @@ void setup(void)
 {
 	char buf[CHUNK];
 
-	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0644);
 
 	memset(buf, 'a', sizeof(buf));
 	SAFE_WRITE(1, fd, buf, sizeof(buf));
@@ -119,4 +121,7 @@ static struct tst_test test = {
 	.test = verify_preadv,
 	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 };
-- 
1.8.3.1



