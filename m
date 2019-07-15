From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 15 Jul 2019 23:16:36 +0800
Subject: [LTP] [PATCH] syscalls/acct02.c: Read threshold from
 /proc/sys/kernel/acct
Message-ID: <1563203796-22102-1-git-send-email-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't use hardcoded threshold(default 4%) to check free space
because it can be changed by writing "/proc/sys/kernel/acct"
or using sysctl.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index c2c2066..9e2f934 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -150,18 +150,21 @@ static void run(void)
 static void setup(void)
 {
 	struct statfs buf;
+	float limit;
 
 	clock_ticks = SAFE_SYSCONF(_SC_CLK_TCK);
 
 	SAFE_STATFS(".", &buf);
 
 	float avail = (100.00 * buf.f_bavail) / buf.f_blocks;
+	SAFE_FILE_SCANF("/proc/sys/kernel/acct", "%f %*i %*i", &limit);
+	limit += 0.1;
 
 	/* The accounting data are silently discarded on nearly FS */
-	if (avail < 4.1) {
+	if (avail < limit) {
 		tst_brk(TCONF,
-			"Less than 4.1%% (%.2f) of free space on filesystem",
-			avail);
+			"Less than (%.2f)%% (%.2f) of free space on filesystem",
+			limit, avail);
 	}
 
 	TEST(acct(NULL));
-- 
1.8.3.1


