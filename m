From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 20:52:37 +0800
Subject: [LTP] [PATCH 3/4] syscalls/getpgid01: Replace TINFO with TPASS or
 TFAIL
Message-ID: <20210429125237.31461-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)remove fail flag
2)remove redundant log
3)replace TINFO with TPASS or TFAIL

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/getpgid/getpgid01.c | 74 ++++---------------
 1 file changed, 13 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 9af523d88..060486e7e 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -62,7 +62,7 @@ int main(int ac, char **av)

 	register int pgid_0, pgid_1;
 	register int my_pid, my_ppid;
-	int ex_stat, fail = 0;
+	int ex_stat;

 	tst_parse_opts(ac, av, NULL, NULL);

@@ -77,30 +77,19 @@ int main(int ac, char **av)
 			while ((pgid_0 = wait(&ex_stat)) != -1) ;

 			if (WEXITSTATUS(ex_stat) == 0)
-				tst_resm(TINFO, "%s PASSED", TCID);
+				tst_resm(TPASS, "%s PASSED", TCID);
 			else
-				tst_resm(TINFO, "%s FAILED", TCID);
+				tst_resm(TFAIL, "%s FAILED", TCID);

 			exit(0);
 		}

-		tst_resm(TINFO, "Enter block 1");
-		fail = 0;
-		if ((pgid_0 = getpgid(0)) == -1) {
+		if ((pgid_0 = getpgid(0)) == -1)
 			tst_resm(TFAIL | TERRNO, "getpgid(0) failed");
-			fail = 1;
-		}
-
-		if (fail)
-			tst_resm(TINFO, "Test block 1: getpgid(0) FAILED");
 		else
-			tst_resm(TPASS, "Test block 1: getpgid(0) PASSED");
-		tst_resm(TINFO, "Exit block 1");
+			tst_resm(TPASS, "getpgid(0) PASSED");

 //block2:
-		tst_resm(TINFO, "Enter block 2");
-		fail = 0;
-
 		my_pid = getpid();
 		if ((pgid_1 = getpgid(my_pid)) == -1)
 			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", my_pid);
@@ -108,20 +97,10 @@ int main(int ac, char **av)
 		if (pgid_0 != pgid_1) {
 			tst_resm(TFAIL, "getpgid(my_pid=%d) != getpgid(0) "
 				 "[%d != %d]", my_pid, pgid_1, pgid_0);
-			fail = 1;
-		}
-		if (fail)
-			tst_resm(TINFO, "Test block 2: getpgid(getpid()) "
-				 "FAILED");
-		else
-			tst_resm(TPASS, "Test block 2: getpgid(getpid()) "
-				 "PASSED");
-		tst_resm(TINFO, "Exit block 2");
+		} else
+			tst_resm(TPASS, "getpgid(getpid()) PASSED");

 //block3:
-		tst_resm(TINFO, "Enter block 3");
-		fail = 0;
-
 		my_ppid = getppid();
 		if ((pgid_1 = getpgid(my_ppid)) == -1)
 			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", my_ppid);
@@ -129,51 +108,24 @@ int main(int ac, char **av)
 		if (pgid_0 != pgid_1) {
 			tst_resm(TFAIL, "getpgid(%d) != getpgid(0) [%d != %d]",
 				 my_ppid, pgid_1, pgid_0);
-			fail = 1;
-		}
-
-		if (fail) {
-			tst_resm(TINFO, "Test block 3: getpgid(getppid()) "
-				 "FAILED");
-		} else {
-			tst_resm(TPASS, "Test block 3: getpgid(getppid()) "
-				 "PASSED");
-		}
-		tst_resm(TINFO, "Exit block 3");
+		} else
+			tst_resm(TPASS, "getpgid(getppid()) PASSED");

 //block4:
-		tst_resm(TINFO, "Enter block 4");
-		fail = 0;
-
 		if ((pgid_1 = getpgid(pgid_0)) < 0)
 			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", pgid_0);

 		if (pgid_0 != pgid_1) {
 			tst_resm(TFAIL, "getpgid(%d) != getpgid(0) [%d != %d]",
 				 pgid_0, pgid_1, pgid_0);
-			fail = 1;
-		}
-
-		if (fail)
-			tst_resm(TINFO, "Test block 4: getpgid(1) FAILED");
-		else
-			tst_resm(TPASS, "Test block 4: getpgid(1) PASSED");
-		tst_resm(TINFO, "Exit block 4");
+		} else
+			tst_resm(TPASS, "getpgid(%d) PASSED", pgid_0);

 //block5:
-		tst_resm(TINFO, "Enter block 5");
-		fail = 0;
-
-		if (getpgid(1) < 0) {
+		if (getpgid(1) < 0)
 			tst_resm(TFAIL | TERRNO, "getpgid(1) failed");
-			fail = 1;
-		}
-
-		if (fail)
-			tst_resm(TINFO, "Test block 5: getpgid(1) FAILED");
 		else
-			tst_resm(TPASS, "Test block 5: getpgid(1) PASSED");
-		tst_resm(TINFO, "Exit block 5");
+			tst_resm(TPASS, "getpgid(1) PASSED");
 	}
 	cleanup();
 	tst_exit();
--
2.17.1

