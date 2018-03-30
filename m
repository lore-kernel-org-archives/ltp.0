From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Mar 2018 16:53:23 +0800
Subject: [LTP] [PATCH 2/2] syscalls/pwritev01: Run test for all filesystems
In-Reply-To: <1522400003-11319-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1522400003-11319-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1522400003-11319-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pwritev/pwritev01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 7c97f72..aeff995 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -31,6 +31,8 @@
 #include "tst_safe_prw.h"
 
 #define	CHUNK		64
+#define MNTPOINT	"mntpoint"
+#define FNAME	MNTPOINT"/file"
 
 static char buf[CHUNK];
 static char initbuf[CHUNK * 2];
@@ -99,7 +101,7 @@ static void setup(void)
 {
 	memset(&buf, 0x61, CHUNK);
 
-	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0644);
 }
 
 static void cleanup(void)
@@ -115,4 +117,7 @@ static struct tst_test test = {
 	.test = verify_pwritev,
 	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 };
-- 
1.8.3.1



