From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:15 +0200
Subject: [LTP] [PATCH v2 2/7] sched/process.c: Open debugfp with freopen()
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

i.e. use the recommended way.

This fixes compilation on MUSL which does not like assignment to stderr:

    process.c:551:14: error: assignment of read-only variable 'stderr'
      551 |      debugfp = fopen(foo, "a+");
          |              ^

Also drop debugfp definition. It'd be more obvious to use FILE pointer
for logging, but some debug functions are intended to use to log into
both stderr and into the log files (or at least logging is before stderr
is redirected into the log files), thus use stderr as file descriptor.

Although not sure why part of the code is logged into stdout and other
part into file, let's keep it.

Suggested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/sched/process_stress/process.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 2dd501f2e..777cdecd4 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -141,12 +141,6 @@ timer_t timer;			/* timer structure */
 
 Pinfo *shmaddr;			/* Start address  of shared memory */
 
-#ifndef _LINUX
-FILE *debugfp = stderr;		/* debug file pointer, used if AUSDEBUG set */
-#else
-#define debugfp stderr
-#endif
-
 struct envstruct *edat = envdata;	/* pointer to environment data */
 
 /* external function declarations */
@@ -260,7 +254,7 @@ void debugout(char *fmt, ...)
 
 	if (AUSDEBUG) {
 		va_start(args, fmt);
-		vfprintf(debugfp, fmt, args);
+		vfprintf(stderr, fmt, args);
 		va_end(args);
 	}
 }
@@ -546,7 +540,12 @@ int spawn(int val)
 			if (!pid) {	/* CHILD */
 				if (AUSDEBUG) {
 					sprintf(foo, "%sslot%d", SLOTDIR, tval);
-					debugfp = fopen(foo, "a+");
+
+					if ((freopen(foo, "w", stderr)) == NULL) {
+						fprintf(stderr, "freopen(%s, w, stderr) failed: %s (%d)\n",
+								foo, strerror(errno), errno);
+						exit(1);
+					}
 				}
 				pinfo = put_proc_info(tval);
 
-- 
2.33.0

