From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 24 Jun 2016 09:35:34 +0800
Subject: [LTP]  [PATCH v2] syscalls/waitpid12: break test if fork() failed
In-Reply-To: <20160623024144.GA29032@localhost.localdomain>
References: <20160623024144.GA29032@localhost.localdomain>
Message-ID: <20160624013534.GA3363@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Please take a look at this new version of the patch. Thanks in advance.

From 19db3543e66256b1d41bc5f58cdeb8c5d3428f01 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 23 Jun 2016 10:11:37 +0800
Subject: [PATCH] syscalls/waitpid12: break test if fork() failed

Or this test case will kill a lot of processes on the system (when -1 ends up
passed as a pid to kill()).

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid12.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid12.c b/testcases/kernel/syscalls/waitpid/waitpid12.c
index bf64662..ba23a39 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid12.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid12.c
@@ -54,6 +54,7 @@ char *TCID = "waitpid12";
 int TST_TOTAL = 1;
 
 volatile int intintr;
+static int fork_kid_pid[MAXKIDS];
 static void setup(void);
 static void cleanup(void);
 static void inthandlr();
@@ -71,7 +72,7 @@ int main(int argc, char **argv)
 	int kid_count, ret_val, status;
 	int i, j, k, found;
 	int group1, group2;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
+	int wait_kid_pid[MAXKIDS];
 	int pid;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
@@ -132,7 +133,7 @@ int main(int argc, char **argv)
 		}
 
 		if (ret_val < 0)
-			tst_resm(TFAIL | TERRNO, "forking kid %d failed",
+			tst_brkm(TFAIL | TERRNO, cleanup, "forking kid %d failed",
 				 kid_count);
 
 		/* parent */
@@ -269,6 +270,9 @@ int main(int argc, char **argv)
 			fail = 1;
 		}
 	}
+
+	memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
+
 	if (kid_count != (MAXKIDS / 2)) {
 		tst_resm(TFAIL, "Wrong number of children waited on "
 			 "for pid = 0");
@@ -299,6 +303,14 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0) {
+			kill(fork_kid_pid[i], SIGKILL);
+			fork_kid_pid[i] = 0;
+		}
+	}
 }
 
 static void inthandlr(void)
-- 
2.5.5




