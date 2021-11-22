Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E2C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844FF3C8C57
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:26:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86973C8D68
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:17 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBF8E200BAF
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:15 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id F20229FB3D;
 Mon, 22 Nov 2021 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637565974; bh=qynIuYusIiXt9NZoQCSZqXpVf7braaEFiSOzjJcBwRk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=LmlzRhl/Kn3D8AqI7+at20Jf+SJ6fXCUS+xa4e552PqFMB52gK+0TkS5krsQVdKI5
 hCblkWy5sC0tYZtiMjdvc12KUcWO3iJcQh+cTtwijLkESLiqwaljLbJkr0yGmzVfCU
 LzGuO7nqBMfBFVCRlf5yvX1SP7212gQV/nkLNniY=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Mon, 22 Nov 2021 08:26:00 +0100
Message-Id: <20211122072601.4096577-3-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122072601.4096577-1-lkml@jv-coder.de>
References: <20211122072601.4096577-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] posix/conformance/interfaces: Fix unused result
 for write
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

Moved WRITE (as PTS_WRITE_MSG) macro to posixtest.h and suppress
unused result error message.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/mmap/11-2.c                    | 6 ++----
 .../conformance/interfaces/mmap/11-3.c                    | 6 ++----
 .../conformance/interfaces/pthread_create/1-3.c           | 8 +++-----
 .../conformance/interfaces/sigaction/19-1.c               | 4 +---
 .../conformance/interfaces/sigaction/19-10.c              | 4 +---
 .../conformance/interfaces/sigaction/19-11.c              | 4 +---
 .../conformance/interfaces/sigaction/19-12.c              | 4 +---
 .../conformance/interfaces/sigaction/19-13.c              | 4 +---
 .../conformance/interfaces/sigaction/19-14.c              | 4 +---
 .../conformance/interfaces/sigaction/19-15.c              | 4 +---
 .../conformance/interfaces/sigaction/19-16.c              | 4 +---
 .../conformance/interfaces/sigaction/19-17.c              | 4 +---
 .../conformance/interfaces/sigaction/19-18.c              | 4 +---
 .../conformance/interfaces/sigaction/19-19.c              | 4 +---
 .../conformance/interfaces/sigaction/19-2.c               | 5 ++---
 .../conformance/interfaces/sigaction/19-20.c              | 4 +---
 .../conformance/interfaces/sigaction/19-21.c              | 4 +---
 .../conformance/interfaces/sigaction/19-22.c              | 4 +---
 .../conformance/interfaces/sigaction/19-23.c              | 4 +---
 .../conformance/interfaces/sigaction/19-24.c              | 4 +---
 .../conformance/interfaces/sigaction/19-25.c              | 4 +---
 .../conformance/interfaces/sigaction/19-26.c              | 4 +---
 .../conformance/interfaces/sigaction/19-3.c               | 4 +---
 .../conformance/interfaces/sigaction/19-4.c               | 4 +---
 .../conformance/interfaces/sigaction/19-5.c               | 4 +---
 .../conformance/interfaces/sigaction/19-6.c               | 4 +---
 .../conformance/interfaces/sigaction/19-7.c               | 4 +---
 .../conformance/interfaces/sigaction/19-8.c               | 4 +---
 .../conformance/interfaces/sigaction/19-9.c               | 4 +---
 testcases/open_posix_testsuite/include/posixtest.h        | 6 ++++++
 30 files changed, 40 insertions(+), 91 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
index d63949418..be0f140dc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
@@ -33,13 +33,11 @@
 #include "posixtest.h"
 #include "tempfile.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static void sigbus_handler(int signum)
 {
 	if (signum == SIGBUS) {
-		WRITE("SIGBUS triggered\n");
-		WRITE("Test PASSED\n");
+		PTS_WRITE_MSG("SIGBUS triggered\n");
+		PTS_WRITE_MSG("Test PASSED\n");
 		_exit(PTS_PASS);
 	}
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
index 073b64ef9..7d38dacda 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-3.c
@@ -31,13 +31,11 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static void sigbus_handler(int signum)
 {
 	if (signum == SIGBUS) {
-		WRITE("SIGBUS triggered\n");
-		WRITE("Test PASSED\n");
+		PTS_WRITE_MSG("SIGBUS triggered\n");
+		PTS_WRITE_MSG("Test PASSED\n");
 		_exit(PTS_PASS);
 	}
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-3.c
index 30fcfe0e9..2fecdd197 100644
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
@@ -72,11 +72,9 @@ static void *a_thread_function()
 	return NULL;
 }
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 /* If this handler is called, that means that the test has failed. */
 static void alarm_handler()
 {
-	WRITE("Test FAILED: Alarm fired while waiting for cancelation\n");
+	PTS_WRITE_MSG("Test FAILED: Alarm fired while waiting for cancelation\n");
 	_exit(PTS_FAIL);
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
index a038ea92a..aadcfd840 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-1.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGABRT) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
index 019c98036..4ab58ae4b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-10.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGPIPE) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
index 7e3545e90..31d077c7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-11.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGQUIT) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
index 123ff169d..ec7c8ade3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-12.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGSEGV) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
index 6cfe1d7f9..da1241c2e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-13.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGTERM) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
index 9371b1bdb..0b33cc2e3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-14.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGTSTP) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
index 37a986d68..c5ef80910 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-15.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGTTIN) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
index 72446e792..73c632be2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-16.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGTTOU) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
index e6d5ba8be..50d9b7cd6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-17.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGUSR1) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
index 2d3f7437f..dc6976218 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-18.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGUSR2) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
index b124d08b8..3708f7e85 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-19.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGPOLL) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
index 0c7e8c698..b9c6ff9b5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-2.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,13 +48,14 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGALRM) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
 	called = 1;
 }
 
+
 int main(void)
 {
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
index f01a4c2ec..bf8f35ab0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-20.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGPROF) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
index 74fffa988..fa96eda85 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-21.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGSYS) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
index dbe6c55a1..3885f2a0c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-22.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGTRAP) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
index e0f54d835..e51d7ce18 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-23.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGURG) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
index bba928a57..8505c94ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-24.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGVTALRM) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
index 62ebe7390..404521ed9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-25.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGXCPU) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
index c02c77397..0e072823e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-26.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGXFSZ) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
index 5fb8c5fad..6674c9a53 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-3.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGBUS) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
index 993889041..a56f15bd2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-4.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGCHLD) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
index 9096ca426..9df9e428d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-5.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGCONT) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
index 3b6799a4e..da0b6ba7c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-6.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGFPE) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
index 5d6b84bd3..ed1bd3db4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-7.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGHUP) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
index ec2649165..4edf21e7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-8.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGILL) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
index 91044863a..e59bb745b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/19-9.c
@@ -40,8 +40,6 @@
 #include <errno.h>
 #include "posixtest.h"
 
-#define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
-
 static volatile sig_atomic_t called = 0;
 
 static void handler(int sig, siginfo_t *info, void *context)
@@ -50,7 +48,7 @@ static void handler(int sig, siginfo_t *info, void *context)
 	(void) context;
 
 	if (info->si_signo != SIGINT) {
-		WRITE("Wrong signal generated?\n");
+		PTS_WRITE_MSG("Wrong signal generated?\n");
 		_exit(PTS_FAIL);
 	}
 
diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index 833488280..d1e62bac0 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -23,3 +23,9 @@
 #define PTS_ATTRIBUTE_NORETURN		__attribute__((noreturn))
 #define PTS_ATTRIBUTE_UNUSED		__attribute__((unused))
 #define PTS_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+
+#define PTS_WRITE_MSG(msg) do { \
+         if (write(STDOUT_FILENO, msg, sizeof(msg) - 1)) { \
+                 /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425 */ \
+         } \
+} while (0) 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
