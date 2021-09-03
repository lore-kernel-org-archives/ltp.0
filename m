From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri,  3 Sep 2021 23:48:10 +0200
Subject: [LTP] [RFC][PATCH 1/2] sched/process.c: Always use pointer to stderr
Message-ID: <20210903214811.61727-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which was previously used for non-linux OS (not relevant to LTP thus not
used in LTP), for linux stderr directly was used.

This fixes compilation on MUSL which does not like assignment to stderr:

process.c:553:14: error: assignment of read-only variable 'stderr'
  553 |      debugfp = fopen(foo, "a+");
      |              ^

NOTE: needed to initialization in main(), because C standard does not
require stdin, stdout and stderr to be constants (at least not C99),
otherwise it fails to compile:

process.c:144:15: error: initializer element is not constant

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

not really sure why anything needs to be assigned to stderr and whether
this is a correct approach. Comments are welcome.

Kind regards,
Petr

 testcases/kernel/sched/process_stress/process.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index a5ff80987..11837c3cb 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -141,13 +141,8 @@ timer_t timer;			/* timer structure */
 
 Pinfo *shmaddr;			/* Start address  of shared memory */
 
-#ifndef _LINUX
-FILE *errfp = stderr;		/* error file pointer, probably not necessary */
-FILE *debugfp = stderr;		/* debug file pointer, used if AUSDEBUG set */
-#else
-#define errfp stderr
-#define debugfp stderr
-#endif
+FILE *errfp;
+FILE *debugfp;
 
 struct envstruct *edat = envdata;	/* pointer to environment data */
 
@@ -1221,6 +1216,9 @@ void doit(void)
 /* main */
 int main(int argc, char *argv[])
 {
+	errfp = stderr;
+	debugfp = stderr;
+
 	extern Pinfo *shmaddr;	/* start address of shared memory */
 
 	prtln();
-- 
2.33.0

