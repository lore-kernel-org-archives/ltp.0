From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Apr 2017 11:34:02 +0800
Subject: [LTP] [PATCH 2/2] syscalls/lseek11.c: fix undefined syncfs() &&
	SEEK_DATA
In-Reply-To: <1491968042-5173-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1491968042-5173-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1491968042-5173-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Compilation failed on RHEL6.9GA because syncfs() was not defined.
   this function was introduced since linux 2.6.39, so we could use
   sync() instead of syncfs().
2) We should Add a check if SEEK_DATA was implemented in get_blocksize().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/lseek/lseek11.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index fe226b5..01b9fa4 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -116,8 +116,15 @@ static void get_blocksize(void)
 		offset <<= 1;
 		SAFE_FTRUNCATE(fd, 0);
 		SAFE_PWRITE(1, fd, "a", 1, offset);
-		syncfs(fd);
-		pos = SAFE_LSEEK(fd, 0, SEEK_DATA);
+		sync();
+		pos = lseek(fd, 0, SEEK_DATA);
+		if (pos == -1) {
+			if (errno == EINVAL) {
+				tst_brk(TCONF | TERRNO,
+				"SEEK_DATA not implemented");
+			}
+			tst_brk(TBROK | TERRNO, "SEEK_DATA failed");
+		}
 	}
 
 	/* bisect for double check */
@@ -125,7 +132,7 @@ static void get_blocksize(void)
 	while (shift && offset < (st.st_blksize * 2)) {
 		SAFE_FTRUNCATE(fd, 0);
 		SAFE_PWRITE(1, fd, "a", 1, offset);
-		syncfs(fd);
+		sync();
 		pos = SAFE_LSEEK(fd, 0, SEEK_DATA);
 		offset += pos ? -shift : shift;
 		shift >>= 1;
@@ -178,7 +185,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_HOLE) < 0) {
 		if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
-				"SEEK_DATA and SEEK_HOLE not implemented");
+				"SEEK_HOLE not implemented");
 		}
 		tst_brk(TBROK | TERRNO, "SEEK_HOLE failed");
 	}
@@ -192,7 +199,7 @@ static void setup(void)
 	SAFE_LSEEK(fd, -128, SEEK_END);
 	write_data(fd, i + 1);
 
-	syncfs(fd);
+	sync();
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 }
 
-- 
1.8.3.1



