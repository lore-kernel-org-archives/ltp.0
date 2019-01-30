From: Tommi Rantala <tt.rantala@gmail.com>
Date: Wed, 30 Jan 2019 17:00:47 +0200
Subject: [LTP] [PATCH] syscalls/setrlimit03.c: read /proc/sys/fs/nr_open for
	RLIMIT_NOFILE limit
Message-ID: <20190130150047.26307-1-tt.rantala@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Since kernel v2.6.25 RLIMIT_NOFILE limit is no longer hardcoded to
NR_OPEN, but can be set via /proc/sys/fs/nr_open, see kernel commit
9cfe015aa424b3c003baba3841a60dd9b5ad319b ("get rid of NR_OPEN and
introduce a sysctl_nr_open").

nr_open default value is 1024*1024, so setrlimit03 has been passing fine
on new kernels, only "unexpectedly succeeding" if nr_open is set to some
larger value.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit03.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index 29b52aa7f..643432bb4 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -36,6 +36,7 @@
 #endif
 
 static struct rlimit rlim1, rlim2;
+static unsigned int nr_open;
 
 static struct tcase {
 	struct rlimit *rlimt;
@@ -51,7 +52,10 @@ static void verify_setrlimit(unsigned int n)
 
 	TEST(setrlimit(RLIMIT_NOFILE, tc->rlimt));
 	if (TST_RET != -1) {
-		tst_res(TFAIL, "call succeeded unexpectedly");
+		tst_res(TFAIL, "call succeeded unexpectedly "
+			"(nr_open=%u rlim_cur=%lu rlim_max=%lu)", nr_open,
+			(unsigned long)(tc->rlimt->rlim_cur),
+			(unsigned long)(tc->rlimt->rlim_max));
 		return;
 	}
 
@@ -65,10 +69,16 @@ static void verify_setrlimit(unsigned int n)
 
 static void setup(void)
 {
+	if (tst_kvercmp(2, 6, 25) < 0) {
+		nr_open = NR_OPEN;
+	} else {
+		SAFE_FILE_SCANF("/proc/sys/fs/nr_open", "%u", &nr_open);
+	}
+
 	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim1);
 	rlim2.rlim_max = rlim1.rlim_cur;
 	rlim2.rlim_cur = rlim1.rlim_max + 1;
-	rlim1.rlim_max = NR_OPEN + 1;
+	rlim1.rlim_max = nr_open + 1;
 }
 
 static struct tst_test test = {
-- 
2.19.2

