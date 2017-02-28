From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:34 +0100
Subject: [LTP] [COMMITTED] [PATCH 12/23] syscalls/memset01: Small cleanup.
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-12-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Get rid of unused function declarations

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/memset/memset01.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/memset/memset01.c b/testcases/kernel/syscalls/memset/memset01.c
index 5bb2496..1a0ccd0 100644
--- a/testcases/kernel/syscalls/memset/memset01.c
+++ b/testcases/kernel/syscalls/memset/memset01.c
@@ -39,12 +39,10 @@
 #include <stdlib.h>
 #include <errno.h>
 
-/*****	LTP Port *****/
 #include "test.h"
 
 char *TCID = "memset01";
 
-/*****	**	**	*****/
 #undef BSIZE
 #define BSIZE	4096
 #define LEN	100
@@ -53,26 +51,20 @@ char *TCID = "memset01";
 
 char buf[BSIZE];
 
-/*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
 int TST_TOTAL = 1;
 
-int anyfail();
-void setup();
-int blenter();
-/*****	**	**	*****/
-
-void fill();
+void fill(void);
 int checkit(char *str);
 
-/*--------------------------------------------------------------*/
 int main(int argc, char *argv[])
 {
 	register int i, j;
 	char *p;
 
-/*--------------------------------------------------------------*/
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	local_flag = PASSED;
 
 	fill();
@@ -99,18 +91,12 @@ int main(int argc, char *argv[])
 	(local_flag == FAILED) ? tst_resm(TFAIL,
 					  "Test failed") : tst_resm(TPASS,
 								    "Test passed");
-/*--------------------------------------------------------------*/
-/* Clean up any files created by test before call to anyfail.	*/
-
 	(local_flag == FAILED) ? tst_resm(TFAIL,
 					  "Test failed") : tst_resm(TPASS,
 								    "Test passed");
 	tst_exit();
 }
 
-/*--------------------------------------------------------------*/
-/* FUNCTIONS GO HERE */
-
 void fill(void)
 {
 	register int i;
-- 
2.10.2

