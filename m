From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Fri, 7 May 2021 10:04:16 +0800
Subject: [LTP] [PATCH] syscalls/mlockall03: Bugfix for running with option
 "-i"
Message-ID: <20210507020416.29792-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When run the test with option "-i 2", test will fail and
report "mlockall03.c:144: mlockall() Failed while setup
for checking error tried to lock more memory than the
limit permitted"

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/mlockall/mlockall03.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 5e8e55648..7418dd64d 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -231,7 +231,7 @@ int setup_test(int i)
 		rl.rlim_cur = 7;

 		if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
-			tst_resm(TWARN, "setrlimit failed to set the "
+			tst_resm(TWARN | TERRNO, "setrlimit failed to set the "
 				 "resource for RLIMIT_MEMLOCK to check "
 				 "for mlockall() error %s\n", TC[i].edesc);
 			return 1;
@@ -268,6 +268,7 @@ void cleanup_test(int i)

 	switch (i) {
 	case 0:
+	case 1:
 		SAFE_SETEUID(cleanup, 0);

 		rl.rlim_max = -1;
@@ -280,11 +281,6 @@ void cleanup_test(int i)
 				 "checking for mlockall() error %s\n",
 				 TC[i].edesc);
 		}
-
-		return;
-
-	case 1:
-		SAFE_SETEUID(cleanup, 0);
 		return;

 	}
--
2.17.1

