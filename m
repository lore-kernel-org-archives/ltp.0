From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:35 +0100
Subject: [LTP] [COMMITTED] [PATCH 13/23] syscalls/memcpy01: Small cleanup.
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-13-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/memcpy/memcpy01.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/memcpy/memcpy01.c b/testcases/kernel/syscalls/memcpy/memcpy01.c
index 9fb05e1..1212465 100644
--- a/testcases/kernel/syscalls/memcpy/memcpy01.c
+++ b/testcases/kernel/syscalls/memcpy/memcpy01.c
@@ -44,42 +44,38 @@
 #include <string.h>
 #include <errno.h>
 
-/*****	LTP Port	*****/
 #include "test.h"
 
 char *TCID = "memcpy1";
-/*****	**	**	*****/
+
 #undef  BSIZE
 #define BSIZE	4096
 #define LEN	100
 #define FAILED 0
 #define PASSED 1
 
-/*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
 FILE *temp;
 int TST_TOTAL = 1;
-/*****	**	**	*****/
 char buf[BSIZE];
 
-/*****	LTP Port	*****/
 
 int anyfail();
 int blenter();
 int blexit();
 
 void setup();
-/*****	**	**	*****/
 void clearit();
 void fill(char *str);
 int checkit(char *str);
 
-/*--------------------------------------------------------------*/
 int main(int argc, char *argv[])
 {
 	char *p, *q;
 
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	setup();		/* temp file is now open        */
 /*--------------------------------------------------------------*/
 	blenter();
@@ -135,16 +131,11 @@ int main(int argc, char *argv[])
 	}
 
 	blexit();
-/*--------------------------------------------------------------*/
-/* Clean up any files created by test before call to anyfail.	*/
 
-	anyfail();		/* THIS CALL DOES NOT RETURN - EXITS!!  */
+	anyfail();
 	tst_exit();
 }
 
-/*--------------------------------------------------------------*/
-/* FUNCTIONS GO HERE */
-
 void clearit(void)
 {
 	register int i;
-- 
2.10.2

