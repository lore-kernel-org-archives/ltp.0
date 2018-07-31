From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 31 Jul 2018 17:47:45 +0100
Subject: [LTP] [PATCH v3] ltp-pan: Increase allowed width of test name in
	logs
Message-ID: <20180731164745.7289-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ltp-pan truncates the test name when logging the outcome of
tests. This is causing issues with tooling which is expecting to parse
unique test names from the log.

cgroup_fj_stress_cpuacct_2_2_o PASS       0
cgroup_fj_stress_cpuacct_3_3_o PASS       0
cgroup_fj_stress_cpuacct_4_4_o PASS       0
cgroup_fj_stress_cpuacct_2_9_o PASS       0
cgroup_fj_stress_cpuacct_10_3_ PASS       0

Fix this by increasing the expected size of test name and removing the
hard restriction on the size of the name. Refactor the common part of
the format string into a macro as it seems to be repeated a few.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
Hi,

I've updated the patch to fix the issues from the previous version, viz,

* corrected the bogus macro definition
* re-factored only part of the format string

Thanks,
Punit

 pan/ltp-pan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index a2bb9b7ef..8ac484ec6 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -130,6 +130,9 @@ static char *test_out_dir = NULL;	/* dir to buffer output to */
 zoo_t zoofile;
 static char *reporttype = NULL;
 
+/* Common format string for ltp-pan results */
+#define ResultFmt	"%-50s %-10.10s"
+
 /* zoolib */
 int rec_signal;			/* received signal */
 int send_signal;		/* signal to send */
@@ -350,9 +353,9 @@ int main(int argc, char **argv)
 			fprintf(logfile, "Test Start Time: %s\n", s);
 			fprintf(logfile,
 				"-----------------------------------------\n");
-			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
+			fprintf(logfile, ResultFmt" %-10.10s\n",
 				"Testcase", "Result", "Exit Value");
-			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
+			fprintf(logfile, ResultFmt" %-10.10s\n",
 				"--------", "------", "------------");
 		}
 		fflush(logfile);
@@ -825,7 +828,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 						}
 
 						fprintf(logfile,
-							"%-30.30s %-10.10s %-5d\n",
+							ResultFmt" %-5d\n",
 							running[i].cmd->name,
 							result_str,
 							w);
@@ -1104,7 +1107,7 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 				if (termid != 0)
 					++ * failcnt;
 
-				fprintf(logfile, "%-30.30s %-10.10s %-5d\n",
+				fprintf(logfile, ResultFmt" %-5d\n",
 					colle->name,
 					((termid != 0) ? "FAIL" : "PASS"),
 					termid);
-- 
2.18.0

