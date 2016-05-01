From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 1 May 2016 09:24:23 +0200
Subject: [LTP] [PATCH] Fix typo in clock_nanosleep01
Message-ID: <20160501072423.GA14891@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that fix a typo in clock_nanosleep01 error
message.

Regards.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit 01a19b7a3a09b0481be03664344485b45a7679f4
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Mon Apr 18 09:50:44 2016 +0200

    clock_nanosleep/clock_nanosleep01: Small typo in error message.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 312b695..08c1fbd 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -291,7 +291,7 @@ static int do_test(struct test_case *tc)
 	 */
 	TEST(rc = clock_gettime(tc->clk_id, &beftp));
 	if (rc < 0) {
-		tst_resm(TFAIL | TTERRNO, "iclock_gettime failed");
+		tst_resm(TFAIL | TTERRNO, "clock_gettime failed");
 		result = 1;
 		goto EXIT;
 	}
