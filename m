From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:41 +0100
Subject: [LTP] [COMMITTED] [PATCH 19/23] syscalls/ipc/semctl06: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-19-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of UCLINUX ifdefs

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl06.c | 57 +------------------------
 1 file changed, 1 insertion(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
index 14af1af..b3af41f 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
@@ -90,27 +90,13 @@ static void term(int sig);
 static void dosemas(int id);
 static void dotest(key_t key);
 
-#ifdef UCLINUX
-static char *argv0;
-
-void do_child();
-static int id_uclinux;
-static char *maxsemstring;
-#endif
-
 int main(int argc, char **argv)
 {
 	register int i, pid;
 	int count, child, status, nwait;
 
-#ifdef UCLINUX
-	
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-	argv0 = argv[0];
-	maybe_run_child(&do_child, "dS", &id_uclinux, &maxsemstring);
-#endif
-
 	prog = argv[0];
 	nwait = 0;
 	setup();
@@ -205,25 +191,8 @@ static void dotest(key_t key)
 		if ((pid = FORK_OR_VFORK()) < 0) {
 			tst_resm(TFAIL, "\tfork failed");
 		}
-		if (pid == 0) {
-#ifdef UCLINUX
-			int j;
-			maxsemstring = "";
-			for (j = 0; j < NSEMS; j++) {
-				if (asprintf(&maxsemstring, "%s%s%d",
-					     maxsemstring, (j ? ":" : ""),
-					     maxsemvals[j]) < 0) {
-					tst_brkm(TBROK, NULL, "Could not serialize "
-						 "maxsemvals");
-				}
-			}
-			if (self_exec(argv0, "dS", id, maxsemstring) < 0) {
-				tst_resm(TFAIL, "\tself_exec failed");
-			}
-#else
+		if (pid == 0)
 			dosemas(id);
-#endif
-		}
 		if (pid > 0) {
 			kidarray[i] = pid;
 			nwait++;
@@ -285,30 +254,6 @@ static void dotest(key_t key)
 		exit(1);
 }
 
-#ifdef UCLINUX
-void do_child(void)
-{
-	int i;
-	char *tok;
-	char *endptr;
-
-	tok = strtok(maxsemstring, ":");
-	for (i = 0; i < NSEMS; i++) {
-		if (strlen(tok) == 0) {
-			tst_brkm(TBROK, NULL, "Invalid argument to -C option");
-		}
-
-		maxsemvals[i] = strtol(tok, &endptr, 10);
-		if (*endptr != '\0') {
-			tst_brkm(TBROK, NULL, "Invalid argument to -C option");
-		}
-		tok = strtok(NULL, ":");
-	}
-
-	dosemas(id_uclinux);
-}
-#endif
-
 static void dosemas(int id)
 {
 	int i, j;
-- 
2.10.2

