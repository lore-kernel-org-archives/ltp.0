From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 25 Aug 2020 18:07:35 +0200
Subject: [LTP] [PATCH v2 4/4] ioctl_sg01: Loop data leak check 100 times
In-Reply-To: <20200825160735.24602-1-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
Message-ID: <20200825160735.24602-5-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even with pre-polluted memory, running the test just once might result in
a false negative. Loop it a few times to increase reliability.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- New patch (split)

 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 21 +++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 8c9fd0dae..8ad2ffed5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -100,19 +100,22 @@ static void cleanup(void)
 
 static void run(void)
 {
-	size_t i;
+	size_t i, j;
 
 	memset(buffer, 0, BUF_SIZE);
-	TEST(ioctl(devfd, SG_IO, &query));
 
-	if (TST_RET != 0 && TST_RET != -1)
-		tst_brk(TBROK | TTERRNO, "Invalid ioctl() return value");
+	for (i = 0; i < 100; i++) {
+		TEST(ioctl(devfd, SG_IO, &query));
 
-	/* Check the output buffer even if ioctl() failed, just in case. */
-	for (i = 0; i < BUF_SIZE; i++) {
-		if (buffer[i]) {
-			tst_res(TFAIL, "Kernel memory leaked");
-			return;
+		if (TST_RET != 0 && TST_RET != -1)
+			tst_brk(TBROK|TTERRNO, "Invalid ioctl() return value");
+
+		/* Check the buffer even if ioctl() failed, just in case. */
+		for (j = 0; j < BUF_SIZE; j++) {
+			if (buffer[j]) {
+				tst_res(TFAIL, "Kernel memory leaked");
+				return;
+			}
 		}
 	}
 
-- 
2.28.0

