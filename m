From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Fri,  3 Nov 2017 19:59:40 +0100
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal handling
Message-ID: <20171103185941.17651-1-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

Very occasionally, we ran into unexpected failures with exit code 1
when running mtest06/mmap1. This was caused by a race condition during
unmap() - read with SIGSEGV - mmap() loop, where read after unmap was
attempted, but before the actual signal handling occurred the area was
mapped again and signal handler was changed back. Instead of test
continuation when a read after unmap happens, the handler which takes
SIGSEGV as fatal becomes active before it should and kills the test. See
simplified strace output:

[pid  8650] <... munmap resumed> ) ...
[pid  8651] --- SIGSEGV ...
[pid  8650] mmap ...
[pid  8651] write(1, "mmap1    0  TINFO :  created writing thread ...
[pid  8650] <... mmap resumed> ) ...
[pid  8651] <... write resumed> ) ...
[pid  8650] sched_yield ...
[pid  8651] exit_group(1 ...
[pid  8651] +++ exited with 1 +++

Fix the race condition by using a proper locking mechanism for thread
synchronization to prevent mapping changes before the caught signal is
actually handled, and simplify the test by using only a single handler.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 86 +++++++++++++-----------------------
 1 file changed, 31 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 8894b0dbf..cd41aebf0 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -7,6 +7,7 @@
 /* Copyright (c) 2007 <rsalveti@linux.vnet.ibm.com>                           */
 /* Copyright (c) 2007 Suzuki K P <suzuki@in.ibm.com>                          */
 /* Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>                          */
+/* Copyright (c) 2017 Red Hat, Inc.                                           */
 /*									      */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -65,8 +66,9 @@
 static int verbose_print = 0;
 static char *volatile map_address;
 static jmp_buf jmpbuf;
-static volatile char read_lock = 0;
+static sig_atomic_t volatile active_map;
 static void *distant_area;
+static pthread_mutex_t thread_lock = PTHREAD_MUTEX_INITIALIZER;
 
 char *TCID = "mmap1";
 int TST_TOTAL = 1;
@@ -78,6 +80,11 @@ static void sig_handler(int signal, siginfo_t * info, void *ut)
 		tst_resm(TPASS, "Test ended, success");
 		_exit(TPASS);
 	case SIGSEGV:
+		if (active_map) {
+			tst_resm(TINFO, "[%lu] Unexpected page fault at %p",
+				 pthread_self(), info->si_addr);
+			_exit(TFAIL);
+		}
 		longjmp(jmpbuf, 1);
 		break;
 	default:
@@ -86,27 +93,6 @@ static void sig_handler(int signal, siginfo_t * info, void *ut)
 	}
 }
 
-/*
- * Signal handler that is active, when file is mapped, eg. we do not expect
- * SIGSEGV to be delivered.
- */
-static void sig_handler_mapped(int signal, siginfo_t * info, void *ut)
-{
-	switch (signal) {
-	case SIGALRM:
-		tst_resm(TPASS, "Test ended, success");
-		_exit(TPASS);
-	case SIGSEGV:
-		tst_resm(TINFO, "[%lu] Unexpected page fault at %p",
-			 pthread_self(), info->si_addr);
-		_exit(TFAIL);
-		break;
-	default:
-		fprintf(stderr, "Unexpected signal - %d --- exiting\n", signal);
-		_exit(TBROK);
-	}
-}
-
 int mkfile(int size)
 {
 	char template[] = "/tmp/ashfileXXXXXX";
@@ -132,7 +118,6 @@ int mkfile(int size)
 
 void *map_write_unmap(void *ptr)
 {
-	struct sigaction sa;
 	long *args = ptr;
 	long i;
 	int j;
@@ -148,32 +133,28 @@ void *map_write_unmap(void *ptr)
 			 args[0], args[1], args[2]);
 
 	for (i = 0; i < args[2]; i++) {
+		pthread_mutex_lock(&thread_lock);
 		map_address = mmap(distant_area, (size_t) args[1],
 			PROT_WRITE | PROT_READ, MAP_SHARED, (int)args[0], 0);
 
 		if (map_address == (void *)-1) {
 			perror("map_write_unmap(): mmap()");
+			pthread_mutex_unlock(&thread_lock);
 			pthread_exit((void *)1);
 		}
-
-		while (read_lock)
-			sched_yield();
-
-		sigfillset(&sa.sa_mask);
-		sigdelset(&sa.sa_mask, SIGSEGV);
-		sa.sa_flags = SA_SIGINFO | SA_NODEFER;
-		sa.sa_sigaction = sig_handler_mapped;
-
-		if (sigaction(SIGSEGV, &sa, NULL)) {
-			perror("map_write_unmap(): sigaction()");
-			pthread_exit((void *)1);
-		}
+		active_map = 1;
+		pthread_mutex_unlock(&thread_lock);
 
 		if (verbose_print)
 			tst_resm(TINFO, "map address = %p", map_address);
 
-		for (j = 0; j < args[1]; j++) {
-			map_address[j] = 'a';
+		j = 0;
+		while (j < args[1]) {
+			if (!pthread_mutex_trylock(&thread_lock)) {
+				map_address[j] = 'a';
+				j++;
+				pthread_mutex_unlock(&thread_lock);
+			}
 			if (random() % 2)
 				sched_yield();
 		}
@@ -184,20 +165,14 @@ void *map_write_unmap(void *ptr)
 				 "map_write_unmap():memset() content of memory = %s",
 				 i, args[2], (char *)map_address);
 
-		sigfillset(&sa.sa_mask);
-		sigdelset(&sa.sa_mask, SIGSEGV);
-		sa.sa_flags = SA_SIGINFO | SA_NODEFER;
-		sa.sa_sigaction = sig_handler;
-
-		if (sigaction(SIGSEGV, &sa, NULL)) {
-			perror("map_write_unmap(): sigaction()");
-			pthread_exit((void *)1);
-		}
-
+		pthread_mutex_lock(&thread_lock);
+		active_map = 0;
 		if (munmap(map_address, (size_t) args[1]) == -1) {
 			perror("map_write_unmap(): mmap()");
+			pthread_mutex_unlock(&thread_lock);
 			pthread_exit((void *)1);
 		}
+		pthread_mutex_unlock(&thread_lock);
 	}
 
 	pthread_exit(NULL);
@@ -218,29 +193,30 @@ void *read_mem(void *ptr)
 			 "read from address %p", args[2], map_address);
 
 	for (i = 0; i < args[2]; i++) {
-
 		if (verbose_print)
 			tst_resm(TINFO, "read_mem() in while loop %ld times "
 				 "to go %ld times", i, args[2]);
 
 		if (setjmp(jmpbuf) == 1) {
-			read_lock = 0;
+			pthread_mutex_unlock(&thread_lock);
 			if (verbose_print)
 				tst_resm(TINFO, "page fault occurred due to "
 					 "a read after an unmap");
 		} else {
 			if (verbose_print) {
-				read_lock = 1;
+				pthread_mutex_lock(&thread_lock);
 				tst_resm(TINFO,
 					 "read_mem(): content of memory: %s",
 					 (char *)map_address);
-				read_lock = 0;
+				pthread_mutex_unlock(&thread_lock);
 			}
 			for (j = 0; j < args[1]; j++) {
-				read_lock = 1;
-				if (map_address[j] != 'a')
+				pthread_mutex_lock(&thread_lock);
+				if (map_address[j] != 'a') {
+					pthread_mutex_unlock(&thread_lock);
 					pthread_exit((void *)-1);
-				read_lock = 0;
+				}
+				pthread_mutex_unlock(&thread_lock);
 				if (random() % 2)
 					sched_yield();
 			}
-- 
2.13.6

