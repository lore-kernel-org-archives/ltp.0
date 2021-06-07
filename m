From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 7 Jun 2021 16:07:42 +0800
Subject: [LTP] [PATCH] syscalls/fchown: Make output nicer and add checks
 before SAFE_CLOSE(fd)
Message-ID: <20210607080742.21377-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Print values not variable names in TST_EXP_PASS().
2. Check if the fd has been opened in cleanup().

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fchown/fchown01.c | 2 +-
 testcases/kernel/syscalls/fchown/fchown02.c | 8 +++++---
 testcases/kernel/syscalls/fchown/fchown03.c | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index 77913ce32..16e1f677b 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -28,7 +28,7 @@ static gid_t gid;

 static void run(void)
 {
-	TST_EXP_PASS(FCHOWN(fd, uid, gid));
+	TST_EXP_PASS(FCHOWN(fd, uid, gid), "fchown(%i, %i, %i)", fd, uid, gid);
 }

 static void setup(void)
diff --git a/testcases/kernel/syscalls/fchown/fchown02.c b/testcases/kernel/syscalls/fchown/fchown02.c
index d541f0450..ec04b5c01 100644
--- a/testcases/kernel/syscalls/fchown/fchown02.c
+++ b/testcases/kernel/syscalls/fchown/fchown02.c
@@ -53,7 +53,7 @@ static void run(unsigned int i)

 	SAFE_CHMOD(tc[i].filename, tc[i].set_mode);

-	TST_EXP_PASS(FCHOWN(*tc[i].fd, uid, gid));
+	TST_EXP_PASS(FCHOWN(*tc[i].fd, uid, gid), "fchown(%i, %i, %i)", *tc[i].fd, uid, gid);

 	SAFE_STAT(tc[i].filename, &stat_buf);

@@ -78,8 +78,10 @@ static void cleanup(void)
 {
 	unsigned int i;

-	for (i = 0; i < ARRAY_SIZE(tc); i++)
-		SAFE_CLOSE(*tc[i].fd);
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (*tc[i].fd > 0)
+			SAFE_CLOSE(*tc[i].fd);
+	}
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
index 752d9c394..97d6c9d34 100644
--- a/testcases/kernel/syscalls/fchown/fchown03.c
+++ b/testcases/kernel/syscalls/fchown/fchown03.c
@@ -85,7 +85,9 @@ static void cleanup(void)
 {
 	SAFE_SETEGID(0);
 	SAFE_SETEUID(0);
-	SAFE_CLOSE(fd);
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
--
2.17.1

