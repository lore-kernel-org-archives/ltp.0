From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 19 Oct 2018 19:13:34 +0800
Subject: [LTP] [PATCH v2] ipc/msgstress*: Update test name in output
In-Reply-To: <20181019113244.GB31934@rei>
References: <20181019113244.GB31934@rei>
Message-ID: <1539947614-3797-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

msgctl[08-11] have been renamed in commit 3e882e3e4c2d,
so fix the obsolete name in output.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress02.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress03.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 6e7f0c1..7117e38 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -193,7 +193,7 @@ int main(int argc, char **argv)
 			 count, nprocs);
 	}
 
-	tst_resm(TPASS, "msgctl08 ran successfully!");
+	tst_resm(TPASS, "Test ran successfully!");
 
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index 1e63c56..43982bd 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -203,7 +203,7 @@ int main(int argc, char **argv)
 			 count, nprocs);
 	}
 
-	tst_resm(TPASS, "msgctl09 ran successfully!");
+	tst_resm(TPASS, "Test ran successfully!");
 
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index da4db1c..de4b459 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -190,7 +190,7 @@ int main(int argc, char **argv)
 			 count, nprocs);
 	}
 
-	tst_resm(TPASS, "msgctl10 ran successfully!");
+	tst_resm(TPASS, "Test ran successfully!");
 
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index 61a8108..18fad4f 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -183,7 +183,7 @@ int main(int argc, char **argv)
 		dotest_iteration(i*(MSGMNI / maxnprocs));
 	}
 
-	tst_resm(TPASS, "msgctl11 ran successfully!");
+	tst_resm(TPASS, "Test ran successfully!");
 
 	cleanup();
 	tst_exit();
-- 
1.8.3.1



