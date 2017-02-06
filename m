From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Mon,  6 Feb 2017 20:24:19 +0700
Subject: [LTP] [PATCH] min_free_kbytes : Check panic_on_oom before running
Message-ID: <20170206132419.11060-1-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hoang Nguyen <the_hoang0709@yahoo.com>

Check panic_on_oom before running min_free_kbytes testcase.

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index cb00f40..8b6dc1c 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -71,6 +71,9 @@ int main(int argc, char *argv[])
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
+	if (get_sys_tune("panic_on_oom"))
+		tst_brkm(TCONF, NULL,
+			"panic_on_oom is set, disable it to run these testcases");
 	sa.sa_handler = sighandler;
 	if (sigemptyset(&sa.sa_mask) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
-- 
2.10.1.windows.1

