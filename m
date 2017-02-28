From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:37 +0100
Subject: [LTP] [COMMITTED] [PATCH 15/23] syscalls/memcmp01: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-15-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Make use of tst_parse_opts

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/memcmp/memcmp01.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/memcmp/memcmp01.c b/testcases/kernel/syscalls/memcmp/memcmp01.c
index ecfe86e..3b4b4e3 100644
--- a/testcases/kernel/syscalls/memcmp/memcmp01.c
+++ b/testcases/kernel/syscalls/memcmp/memcmp01.c
@@ -39,7 +39,6 @@
 #include <string.h>
 #include <errno.h>
 
-/*****	LTP Port	*****/
 #include "test.h"
 
 char *TCID = "memcmp1";
@@ -49,11 +48,9 @@ char *TCID = "memcmp1";
 #define LEN	100
 #define FAILED 0
 #define PASSED 1
-/*****	**	**	*****/
 
 char buf[BSIZE];
 
-/*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
 FILE *temp;
@@ -64,19 +61,18 @@ int blexit();
 int instress();
 
 void setup();
-/*****	**	**	*****/
 
 void clearit();
 void fill(char *str);
 int checkit(char *str);
 
-/*--------------------------------------------------------------*/
 int main(int argc, char *argv[])
 {
 	char *p, *q;
 
-	setup();		/* temp file is now open        */
-/*--------------------------------------------------------------*/
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
 	blenter();
 
 	clearit();
@@ -186,16 +182,11 @@ int main(int argc, char *argv[])
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

