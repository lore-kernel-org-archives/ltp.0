From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:14 +0200
Subject: [LTP] [PATCH v2 1/7] sched/process.c: Replace errfp with stderr
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

As comment suggest it's indeed not needed :).

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../kernel/sched/process_stress/process.c     | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index a5ff80987..2dd501f2e 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -142,10 +142,8 @@ timer_t timer;			/* timer structure */
 Pinfo *shmaddr;			/* Start address  of shared memory */
 
 #ifndef _LINUX
-FILE *errfp = stderr;		/* error file pointer, probably not necessary */
 FILE *debugfp = stderr;		/* debug file pointer, used if AUSDEBUG set */
 #else
-#define errfp stderr
 #define debugfp stderr
 #endif
 
@@ -201,12 +199,12 @@ void print_shm(void)
 		return;
 
 	for (pinfo = shmaddr, i = 0; i < nodesum; i++, pinfo++) {
-		fprintf(errfp,
+		fprintf(stderr,
 			"slot: %-4d pid: %-6d ppid: %-6d msg: %-2d err: %-2d lst:",
 			i, pinfo->pid, pinfo->ppid, pinfo->msg, pinfo->err);
 		for (j = 0, listp = pinfo->list; j < BVAL; j++, listp++)
-			fprintf(errfp, " %d", *listp);
-		fprintf(errfp, "\n");
+			fprintf(stderr, " %d", *listp);
+		fprintf(stderr, "\n");
 	}
 }
 
@@ -276,13 +274,13 @@ void rm_msgqueue(void)
 
 	/* remove message queue id. */
 	if (msgctl(msgid, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "msgctl failed msgid: errno %d\n", errno);
+		fprintf(stderr, "msgctl failed msgid: errno %d\n", errno);
 		perror("msgctl failed");
 	}
 
 	/* remove message queue id. */
 	if (msgctl(msgerr, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "msgctl failed msgerr: errno %d\n", errno);
+		fprintf(stderr, "msgctl failed msgerr: errno %d\n", errno);
 		perror("msgctl failed");
 	}
 }
@@ -297,7 +295,7 @@ void rm_shmseg(void)
 
 	/* remove shared memory id (and shared memory segment). */
 	if (shmctl(shmid, IPC_RMID, NULL) && errno != EINVAL) {
-		fprintf(errfp, "shmctl failed: errno %d\n", errno);
+		fprintf(stderr, "shmctl failed: errno %d\n", errno);
 		perror("shmctl failed");
 	}
 }
@@ -313,13 +311,13 @@ void rm_semseg(void)
 	/* remove sem_lock semaphore id */
 	semarg.val = 0;		/* to fix problem with 4th arg of semctl in 64 bits MARIOG */
 	if (semctl(sem_lock, 0, IPC_RMID, semarg.val) && errno != EINVAL) {
-		fprintf(errfp, "semctl failed: errno %d\n", errno);
+		fprintf(stderr, "semctl failed: errno %d\n", errno);
 		perror("semctl failed");
 	}
 	/* remove sem_count semaphore id. */
 	semarg.val = 0;		/* to fix problem with 4th arg of semctl in 64 bits MARIOG */
 	if (semctl(sem_count, 0, IPC_RMID, semarg.val) && errno != EINVAL) {
-		fprintf(errfp, "semctl failed: errno %d\n", errno);
+		fprintf(stderr, "semctl failed: errno %d\n", errno);
 		perror("semctl failed");
 	}
 }
@@ -1094,7 +1092,7 @@ void messenger(void)
 				case SIGALRM:
 					/* a process is hung, we will terminate */
 					killpg(procgrp, sig);
-					fprintf(errfp,
+					fprintf(stderr,
 						"ALERT! ALERT! WE HAVE TIMED OUT\n");
 					fprintf(stderr,
 						" SEVERE : SIGALRM: A process timed out, we failed\n");
@@ -1109,7 +1107,7 @@ void messenger(void)
 				default:
 					/* somebody sent a signal, we will terminate */
 					killpg(procgrp, sig);
-					fprintf(errfp,
+					fprintf(stderr,
 						"We received signal %d\n", sig);
 					fprintf(stderr,
 						" SEVERE : signal %d received, A proc was killed\n",
-- 
2.33.0

