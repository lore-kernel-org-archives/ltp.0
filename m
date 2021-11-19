Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A41C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174AC61108
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 174AC61108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B542C3C89AB
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40BCD3C89AF
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:16 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D9671000A48
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:16 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id E14DB9F6A0;
 Fri, 19 Nov 2021 07:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307975; bh=J8HKqnhcOeTWBhrLbPDBMrW4UZrYs9xG6Hdx+yxQmDc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=jN1y0DwLRFhj9/DhfmtOK5CUBcqT1thg8pCrH3ciJ5tubOUo5n/D06oLT4s4rzvsx
 v2T5gzvfAa0VyfsPqbJfGSRVYCLV+D+85CwgrAiNogFqnQwaNTZE4gFwumMQKaYpjd
 ptA5+lfJd4YtmFTg3uob4LtVDKQ9dMKXZs11fFUI=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:55 +0100
Message-Id: <20211119074602.857595-6-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/12] posix/conformance/interfaces: Fix all unused
 variable warnings
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

Either by marking them as unused or by removing them, if there is no sideffect.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/aio_read/9-1.c                     | 3 +--
 .../conformance/interfaces/aio_write/7-1.c                    | 3 +--
 .../open_posix_testsuite/conformance/interfaces/fork/7-1.c    | 2 +-
 .../conformance/interfaces/pthread_cond_init/2-1.c            | 2 +-
 .../conformance/interfaces/pthread_exit/2-2.c                 | 2 +-
 .../conformance/interfaces/pthread_exit/3-2.c                 | 2 +-
 .../conformance/interfaces/pthread_mutex_init/3-1.c           | 4 ++--
 .../conformance/interfaces/pthread_mutex_timedlock/4-1.c      | 4 +---
 .../conformance/interfaces/pthread_mutex_timedlock/5-1.c      | 4 +---
 .../conformance/interfaces/pthread_mutex_timedlock/5-2.c      | 4 +---
 .../conformance/interfaces/pthread_mutex_timedlock/5-3.c      | 4 +---
 .../conformance/interfaces/pthread_mutex_trylock/4-3.c        | 1 -
 .../conformance/interfaces/pthread_mutex_unlock/2-1.c         | 4 ++--
 .../conformance/interfaces/pthread_mutexattr_setpshared/1-1.c | 2 --
 .../conformance/interfaces/pthread_once/4-1-buildonly.c       | 3 ++-
 15 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
index e1ae59e3b..cd1aa0318 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
@@ -48,7 +48,6 @@ int main(void)
 	int i;
 	struct aiocb aiocbs[NUM_AIOCBS];
 	int last_req;
-	int err;
 	int ret;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L
@@ -85,7 +84,7 @@ int main(void)
 	}
 
 	for (i = 0; i < last_req - 1; i++) {
-		err = aio_error(&aiocbs[i]);
+		aio_error(&aiocbs[i]);
 		ret = aio_return(&aiocbs[i]);
 
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
index 277573a38..52c8d7004 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
@@ -48,7 +48,6 @@ int main(void)
 	int i;
 	struct aiocb aiocbs[NUM_AIOCBS];
 	int last_req;
-	int err;
 	int ret;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L
@@ -79,7 +78,7 @@ int main(void)
 	}
 
 	for (i = 0; i < last_req - 1; i++) {
-		err = aio_error(&aiocbs[i]);
+		aio_error(&aiocbs[i]);
 		ret = aio_return(&aiocbs[i]);
 
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index aaf1403f9..9a0b148d9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -51,7 +51,7 @@
 
 static void read_catalog(nl_catd cat, char *who)
 {
-	char *msg = NULL;
+	char *msg PTS_ATTRIBUTE_UNUSED = NULL;
 	int i, j;
 
 #if VERBOSE > 0
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
index 4a60f7098..fbb7c68ff 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
@@ -14,7 +14,7 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_cond_t cond PTS_ATTRIBUTE_UNUSED = PTHREAD_COND_INITIALIZER;
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
index 2fc3ff700..16c658f73 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
@@ -92,7 +92,7 @@
 static int global = 0;
 static int tab[3];
 
-#define CLEANUP(n) static void clnp##n(void * arg)\
+#define CLEANUP(n) static void clnp##n(void * arg PTS_ATTRIBUTE_UNUSED)\
 {\
 	tab[global]=n; \
 	global++; \
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
index 5fa6c8b50..4437ffc77 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
@@ -94,7 +94,7 @@ static int global = 0;
 static int tab[4];
 static pthread_key_t tld[3];
 
-#define CLEANUP(n) static void clnp##n(void * arg)\
+#define CLEANUP(n) static void clnp##n(void * arg PTS_ATTRIBUTE_UNUSED)\
 {\
 	tab[global]=n; \
 	global++; \
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
index 9ee86a5db..8a9b989f1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
@@ -5,7 +5,7 @@
  * of this license, see the COPYING file at the top level of this
  * source tree.
 
- * Test that the macro PTHREAD_MUTEX_INITIALIZER can be sued to intiailize
+ * Test that the macro PTHREAD_MUTEX_INITIALIZER can be used to initialize
  * mutexes that are statically allocated.
  *
  */
@@ -20,7 +20,7 @@ typedef struct my_data {
 	int value;		/* Access protected by mutex */
 } my_data_t;
 
-static my_data_t data = { PTHREAD_MUTEX_INITIALIZER, 0 };
+static my_data_t data PTS_ATTRIBUTE_UNUSED = { PTHREAD_MUTEX_INITIALIZER, 0 };
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
index a7099688b..d3c0bdae9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
@@ -32,9 +32,7 @@ static void *f1(void *parm);
 static int ret;			/* Save return value of
 				   pthread_mutex_timedlock(). */
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
-static time_t currsec1, currsec2;	/* Variables for saving time before
-				   and afer locking the mutex using
-				   pthread_mutex_timedlock(). */
+
 /****************************
  *
  * MAIN()
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
index 077bfe76d..f51106bdf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
@@ -40,9 +40,7 @@ static void *f1(void *parm);
 static int ret;			/* Save return value of
 				   pthread_mutex_timedlock(). */
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
-static time_t currsec1, currsec2;	/* Variables for saving time before
-				   and afer locking the mutex using
-				   pthread_mutex_timedlock(). */
+
 /****************************
  *
  * MAIN()
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
index 0eda6e58f..afca84eed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
@@ -40,9 +40,7 @@ static void *f1(void *parm);
 static int ret;			/* Save return value of
 				   pthread_mutex_timedlock(). */
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
-static time_t currsec1, currsec2;	/* Variables for saving time before
-				   and afer locking the mutex using
-				   pthread_mutex_timedlock(). */
+
 /****************************
  *
  * MAIN()
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
index baf429503..a5f8b3383 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
@@ -36,9 +36,7 @@ static void *f1(void *parm);
 static int ret;			/* Save return value of
 				   pthread_mutex_timedlock(). */
 static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
-static time_t currsec1, currsec2;	/* Variables for saving time before
-				   and afer locking the mutex using
-				   pthread_mutex_timedlock(). */
+
 /****************************
  *
  * MAIN()
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
index e7e86bfa8..2145bde8a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
@@ -103,7 +103,6 @@ static struct _scenar {
 #define NSCENAR (sizeof(scenarii)/sizeof(scenarii[0]))
 
 static char do_it = 1;
-static char woken = 0;
 static unsigned long count_ope = 0;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
index 27f0ee3d7..39dacb73e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
@@ -39,13 +39,13 @@ static int value;			/* value protected by mutex */
 
 int main(void)
 {
-	int i, rc;
+	int i;
 	pthread_t threads[THREAD_NUM];
 
 	/* Create threads */
 	fprintf(stderr, "Creating %d threads\n", THREAD_NUM);
 	for (i = 0; i < THREAD_NUM; ++i)
-		rc = pthread_create(&threads[i], NULL, func, NULL);
+		pthread_create(&threads[i], NULL, func, NULL);
 
 	/* Wait to join all threads */
 	for (i = 0; i < THREAD_NUM; ++i)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
index 909b53bf4..8e8617bbd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
@@ -37,8 +37,6 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static pthread_mutex_t new_mutex;	/* The mutex. */
-
 int main(void)
 {
 	pthread_mutexattr_t mta;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
index 6e519962b..d3392f908 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
@@ -11,5 +11,6 @@
    */
 
 #include <pthread.h>
+#include "posixtest.h"
 
-static pthread_once_t dummy = PTHREAD_ONCE_INIT;
+static pthread_once_t dummy PTS_ATTRIBUTE_UNUSED = PTHREAD_ONCE_INIT;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
