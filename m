Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE8C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C2461B1E
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81C2461B1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420743C89AD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:48:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3690F3C898B
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:23 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C73862011DF
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:20 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 9774B9F6A0;
 Fri, 19 Nov 2021 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307978; bh=xvfAN4IYgg+K6clV9HffYVabEwvmh6W1EDD5t/aXtYY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=n4yiKN3uVhEKlaHdbZhRJEmAq4VdxQKG0n6RAdJB2xlPZ7SXPyl04v0+LXnko6e5q
 UarnpKvCetKLJcmPxrGidrdVEhHIrweFKLU6bpsDtytGFhmzD3PLbTyPTGqr7n1LFB
 k4NxwRS8JOqv6UBAIRvf4rpzoXQc+dE4e+GJzXsM=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:46:02 +0100
Message-Id: <20211119074602.857595-13-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/12] posix/interface/conformance: Fix/supress all
 unused-result warnings
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The warnings for writes in signalhandlers can only be suppressed,
there is no good way to handle an error there. In all other locations
a failing function is printed and PTS_UNRESOLVED returned.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/clock_getcpuclockid/5-1.c  | 10 ++++++++--
 .../conformance/interfaces/fork/7-1.c                 |  3 ++-
 .../conformance/interfaces/kill/2-2.c                 |  5 ++++-
 .../conformance/interfaces/kill/3-1.c                 |  5 ++++-
 .../conformance/interfaces/mmap/11-2.c                |  5 +++++
 .../conformance/interfaces/mmap/11-3.c                |  5 +++++
 .../conformance/interfaces/mmap/18-1.c                |  6 +++++-
 .../conformance/interfaces/mq_open/16-1.c             |  8 ++++++--
 .../conformance/interfaces/pthread_create/1-3.c       | 11 +++++++++--
 .../conformance/interfaces/sched_setparam/2-1.c       |  5 ++++-
 .../conformance/interfaces/sched_setparam/2-2.c       |  5 ++++-
 .../conformance/interfaces/sched_yield/1-1.c          |  9 ++++++---
 .../conformance/interfaces/shm_open/26-2.c            |  9 ++++++---
 .../conformance/interfaces/shm_unlink/8-1.c           |  3 ++-
 .../conformance/interfaces/shm_unlink/9-1.c           |  6 ++++--
 .../conformance/interfaces/sigaction/19-1.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-10.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-11.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-12.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-13.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-14.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-15.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-16.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-17.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-18.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-19.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-2.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-20.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-21.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-22.c          |  8 ++++++--
 .../conformance/interfaces/sigaction/19-23.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-24.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-25.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-26.c          |  9 +++++++--
 .../conformance/interfaces/sigaction/19-3.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-4.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-5.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-6.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-7.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-8.c           |  9 +++++++--
 .../conformance/interfaces/sigaction/19-9.c           |  9 +++++++--
 .../conformance/interfaces/sigaltstack/9-1.c          |  5 ++++-
 testcases/open_posix_testsuite/include/affinity.h     |  3 ++-
 43 files changed, 261 insertions(+), 75 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
index 0046d5066..2e9961a19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/5-1.c
@@ -35,8 +35,14 @@ int main(void)
 
 		pwd = getpwnam("nobody");
 		if (pwd != NULL) {
-			setgid(pwd->pw_gid);
-			setuid(pwd->pw_uid);
+			if (setgid(pwd->pw_gid)) {
+				perror("setgid");
+				return PTS_UNRESOLVED;
+			}
+			if (setuid(pwd->pw_uid)) {
+				perror("setuid");
+				return PTS_UNRESOLVED;
+			}
 		}
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index 9a0b148d9..46350b7f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -157,7 +157,8 @@ int main(void)
 	if (ret != 0)
 		UNRESOLVED(errno, "Failed to close the message catalog");
 
-	system("rm -f " MESSCAT_IN " " MESSCAT_OUT);
+	unlink(MESSCAT_IN);
+	unlink(MESSCAT_OUT);
 
 #if VERBOSE > 0
 	output("Test passed\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
index dd566831c..1cd3b2fdc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/2-2.c
@@ -55,7 +55,10 @@ int main(void)
 	 */
 	/* this is added incase user is root. If user is normal user, then it
 	 * has no effect on the tests */
-	setuid(1);
+	if (setuid(1)) {
+		perror("setuid");
+		return PTS_UNRESOLVED;
+	}
 
 	if (-1 == kill(1, 0)) {
 		if (EPERM == errno) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
index a5999332b..70a8c590c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/3-1.c
@@ -23,7 +23,10 @@ int main(void)
 {
 	/* this is added incase user is root. If user is normal user, then it
 	 * has no effect on the tests */
-	setuid(1);
+	if (setuid(1)) {
+		perror("setuid");
+		return PTS_UNRESOLVED;
+	}
 
 	if (kill(1, 0) != -1) {
 		printf
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
index d63949418..27bfec8ca 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
@@ -33,6 +33,9 @@
 #include "posixtest.h"
 #include "tempfile.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
 #define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
 
 static void sigbus_handler(int signum)
@@ -44,6 +47,8 @@ static void sigbus_handler(int signum)
 	}
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 #ifndef _POSIX_MEMORY_PROTECTION
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
index 073b64ef9..704049290 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
@@ -31,6 +31,9 @@
 #include <unistd.h>
 #include "posixtest.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
 #define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
 
 static void sigbus_handler(int signum)
@@ -42,6 +45,8 @@ static void sigbus_handler(int signum)
 	}
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 #ifndef _POSIX_MEMORY_PROTECTION
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
index 113d01b8c..02fc73d80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
@@ -131,7 +131,11 @@ int main(void)
 		printf("Got EAGAIN: %s\n", strerror(errno));
 		printf("Test PASSED\n");
 		/* Change user to root */
-		seteuid(0);
+		if (seteuid(0)) {
+			close(fd);
+			perror("seteuid");
+			return PTS_UNRESOLVED;
+		}
 		close(fd);
 		munmap(pa, len);
 		return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index eee55a748..ecbfb0f79 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
@@ -61,10 +61,14 @@ int main(void)
 		printf(TNAME " Error at open(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
-	/* file is empty now, will cause "Bus error" */
-	write(fd, fname, sizeof(int));
 	unlink(fname);
 
+	if (ftruncate(fd, sizeof(int))) {
+		perror("ftruncate");
+		close(fd);
+		return PTS_UNRESOLVED;
+	}
+
 	pa = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (pa == MAP_FAILED) {
 		printf(TNAME " Error at mmap: %s\n", strerror(errno));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c
index 30fcfe0e9..d24810dce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c
@@ -10,8 +10,8 @@
  *
  * Steps:
  * 1.  Create a new thread that will go into a never-ending while loop.
- * 2.  If the thread is truly asynchronise, then the main function will
- *     continue instead of waiting for the thread to return (which in never
+ * 2.  If the thread is truly asynchronous, then the main function will
+ *     continue instead of waiting for the thread to return (which it never
  *     does in this test case).
  * 3.  An alarm is set to go off (i.e. send the SIGARLM signal) after 3
  *     seconds. This is done for 'timeing-out' reasons, in case main DOES
@@ -30,6 +30,8 @@
 static void *a_thread_function();
 static void alarm_handler();
 
+static volatile int alarm_triggered;
+
 static pthread_t a;
 
 int main(void)
@@ -72,6 +74,9 @@ static void *a_thread_function()
 	return NULL;
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
 #define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
 
 /* If this handler is called, that means that the test has failed. */
@@ -80,3 +85,5 @@ static void alarm_handler()
 	WRITE("Test FAILED: Alarm fired while waiting for cancelation\n");
 	_exit(PTS_FAIL);
 }
+
+#pragma GCC diagnostic pop
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index da56343d0..fb19ff6a4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -125,7 +125,10 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	pipe(the_pipe);
+	if (pipe(the_pipe)) {
+		perror("pipe");
+		return PTS_UNRESOLVED;
+	}
 
 	for (i = 0; i < nb_child; i++) {
 		child_pid[i] = fork();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 6f10618b6..6c68120c3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -129,7 +129,10 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	pipe(the_pipe);
+	if (pipe(the_pipe)) {
+		perror("pipe");
+		return PTS_UNRESOLVED;
+	}
 
 	for (i = 0; i < nb_child; i++) {
 		child_pid[i] = fork();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
index 602733e60..2e1e3197a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_yield/1-1.c
@@ -45,18 +45,21 @@ static int child_busy(int fd)
 	alarm(4);
 
 	/* Tell the parent we're ready */
-	write(fd, "go", 2);
+	if (write(fd, "go", 2) == -1) {
+		perror("write");
+		exit(PTS_UNRESOLVED);
+	}
 
 	for (;;) {
 		rc = sched_yield();
 		if (rc) {
 			ERR_LOG("child: sched_yield", rc);
-			exit(1);
+			exit(PTS_FAIL);
 		}
 	}
 
 	/* should not get here */
-	exit(2);
+	exit(PTS_UNRESOLVED);
 }
 
 int main(void)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
index 215d3e1af..69edeae85 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/26-2.c
@@ -95,19 +95,22 @@ int main(void)
 	fd = shm_open(SHM_NAME, O_RDWR | O_TRUNC, 0);
 	if (fd == -1) {
 		perror("An error occurs when calling shm_open()");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_UNRESOLVED;
 	}
 
 	if (fstat(fd, &stat_buf) != 0) {
 		perror("An error occurs when calling fstat()");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_UNRESOLVED;
 	}
 
-	seteuid(getuid());
+	if (seteuid(getuid()))
+		perror("seteuid");
 	shm_unlink(SHM_NAME);
 
 	if (stat_buf.st_uid == old_uid && stat_buf.st_gid == old_gid) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
index ed18cf213..d67d2fbe2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/8-1.c
@@ -86,7 +86,8 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	seteuid(getuid());
+	if (seteuid(getuid()))
+		perror("seteuid");
 
 	if (fstat(fd, &stat_after) != 0) {
 		perror("An error occurs when calling fstat()");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
index 5c52465c8..9ef4b0c65 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/9-1.c
@@ -69,12 +69,14 @@ int main(void)
 	result = shm_unlink(SHM_NAME);
 	if (result == -1 && errno == EACCES) {
 		printf("Test PASSED\n");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_PASS;
 	} else if (result == -1) {
 		perror("Unexpected error");
-		seteuid(getuid());
+		if (seteuid(getuid()))
+			perror("seteuid");
 		shm_unlink(SHM_NAME);
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
index a038ea92a..98b7e2e9d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
index 019c98036..649a6914f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
index 7e3545e90..e8223fb4b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
index 123ff169d..9b46baaf0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
index 6cfe1d7f9..944741014 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
index 9371b1bdb..3c1aa1f48 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
index 37a986d68..803851648 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
index 72446e792..e189fcd9c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
index e6d5ba8be..67405ec35 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
index 2d3f7437f..4cd275946 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
index b124d08b8..cc13b4a04 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
index 0c7e8c698..10a06b34b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
index f01a4c2ec..cf5c9a067 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
index 74fffa988..18c1be5ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
index dbe6c55a1..f9971b3f2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
@@ -39,10 +39,12 @@
 #include <signal.h>
 #include <errno.h>
 #include "posixtest.h"
+static volatile sig_atomic_t called = 0;
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
 
-static volatile sig_atomic_t called = 0;
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
 
 static void handler(int sig, siginfo_t *info, void *context)
 {
@@ -57,6 +59,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
index e0f54d835..ec07b89dc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
index bba928a57..fc2c87744 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
index 62ebe7390..828f1fd14 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
index c02c77397..0a666e59a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
index 5fb8c5fad..bd4a8831d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
index 993889041..6ab0f35ee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
index 9096ca426..a1f8ea115 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
index 3b6799a4e..ed7aeafdd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
index 5d6b84bd3..f6ff253cd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
index ec2649165..fe745aab9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
index 91044863a..7e55e2722 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
@@ -40,10 +40,13 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+
+#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
+
 static void handler(int sig, siginfo_t *info, void *context)
 {
 	(void) sig;
@@ -57,6 +60,8 @@ static void handler(int sig, siginfo_t *info, void *context)
 	called = 1;
 }
 
+#pragma GCC diagnostic pop
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
index 0236a752e..e9f9a8f71 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
@@ -59,7 +59,10 @@ int main(int argc, char *argv[])
 
 		/* Get abs path if needed and exec ourself */
 		if (*argv[0] != '/') {
-			getcwd(path, PATH_MAX);
+			if (getcwd(path, PATH_MAX) == NULL) {
+				perror("getcwd");
+				exit(PTS_UNRESOLVED);
+			}
 			strcat(path, "/");
 			strcat(path, argv[0]);
 		} else {
diff --git a/testcases/open_posix_testsuite/include/affinity.h b/testcases/open_posix_testsuite/include/affinity.h
index 86fb4f4c6..da7e6837e 100644
--- a/testcases/open_posix_testsuite/include/affinity.h
+++ b/testcases/open_posix_testsuite/include/affinity.h
@@ -46,7 +46,8 @@ static int get_online_cpu_from_sysfs(void)
 	f = fopen("/sys/devices/system/cpu/online", "r");
 	if (!f)
 		return -1;
-	fscanf(f, "%d", &cpu);
+	if (!fscanf(f, "%d", &cpu))
+		cpu = -1;
 	fclose(f);
 
 	return cpu;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
