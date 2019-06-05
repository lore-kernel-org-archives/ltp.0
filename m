From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  5 Jun 2019 16:28:24 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/preadv203: Fix two bugs
Message-ID: <20190605142824.28921-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit:

commit d7ddbe1134cf825163992a6a761360d3ed9897e2
Author: Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed Jun 5 13:33:12 2019 +0800

    syscalls/preadv2/preadv203: set mount_device flag

The test would fail in two different ways.

First of all on subset of filesystem the test will end up with TBROK
because preadv2 returns EOPNOTSUP for the RWF_NOWAIT flag.

Secondly the size of the written data is too close to the default
test block device size and does not leave enough space for metadata. We
escaped that limitation by using the /tmp/ instead previously.

Anyways this is intended as fast fix for the test, I need to reevaluate
it later on, because I've been testing the call only on ext4 due to my
silly mistake.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Murphy Zhou <jencce.kernel@gmail.com>
CC: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index e4f68a51b..91618f5f5 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -50,7 +50,7 @@
 #define CHUNK_SZ 4123
 #define CHUNKS 60
 #define MNTPOINT "mntpoint"
-#define FILES 1000
+#define FILES 500
 
 static int fds[FILES];
 
@@ -225,6 +225,19 @@ static void verify_preadv2(void)
 		tst_res(TFAIL, "Haven't got EAGAIN");
 }
 
+static void check_preadv2_nowait(int fd)
+{
+	char buf[1];
+	struct iovec iovec[] = {
+		{buf, sizeof(buf)},
+	};
+
+	TEST(preadv2(fd, iovec, 1, 0, RWF_NOWAIT));
+
+	if (TST_ERR == EOPNOTSUPP)
+		tst_brk(TCONF | TERRNO, "preadv2()");
+}
+
 static void setup(void)
 {
 	char path[1024];
@@ -237,6 +250,9 @@ static void setup(void)
 
 		fds[i] = SAFE_OPEN(path, O_RDWR | O_CREAT, 0644);
 
+		if (i == 0)
+			check_preadv2_nowait(fds[i]);
+
 		for (j = 0; j < CHUNKS; j++) {
 			memset(buf, '0' + j, sizeof(buf));
 			SAFE_WRITE(1, fds[i], buf, sizeof(buf));
-- 
2.19.2

