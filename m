From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Sun,  5 Mar 2017 11:00:54 +0700
Subject: [LTP]  [PATCH v3] min_free_kbytes: Check panic_on_oom in advance
Message-ID: <1488686454-2025-1-git-send-email-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hoang Nguyen <the_hoang0709@yahoo.com>

Testcase usually trigger reset if panic_on_oom is enabled by default.
Add panic_on_oom checking before running.

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index cb00f40..493c37e 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -239,6 +239,11 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
 void setup(void)
 {
 	tst_require_root();
+	if (get_sys_tune("panic_on_oom")) {
+		tst_brkm(TCONF, NULL,
+			"panic_on_oom is set, disable it to run these testcases");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-- 
2.7.4

