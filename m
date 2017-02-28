From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:44 +0100
Subject: [LTP] [COMMITTED] [PATCH 22/23] syscalls/string01: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-22-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/string/string01.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/string/string01.c b/testcases/kernel/syscalls/string/string01.c
index 9dcf3ec..0ae09a4 100644
--- a/testcases/kernel/syscalls/string/string01.c
+++ b/testcases/kernel/syscalls/string/string01.c
@@ -39,7 +39,6 @@
 #include <sys/types.h>
 #include <string.h>
 
-/*****	LTP Port	*****/
 #include <errno.h>
 #include <stdlib.h>
 #include "test.h"
@@ -72,9 +71,6 @@ char dst0[LONGSTR + 1];		/* place holders for various tests */
 char dst1[LONGSTR + 1];
 char dst2[LONGSTR + 1];
 
-/*
- *	Data structures for testing.
- */
 
 /*	Strlen	(strlen( s ) == e_res)		*/
 struct t_strlen {
@@ -236,7 +232,6 @@ struct t_strncpy {
 	NULL, NULL, 0, NULL, 0}
 };
 
-/*****	LTP Port	*****/
 void setup();
 int blenter();
 int blexit();
@@ -266,15 +261,13 @@ int anyfail(void)
 	tst_exit();
 }
 
-/*****	**	**	*****/
-
-/*--------------------------------------------------------------*/
-
 int main(int argc, char *argv[])
 {
 	register int n, i;
 	char *s, *pr;
 
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	/*
 	 * Init longstr
 	 */
-- 
2.10.2

