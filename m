Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02255C5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786459757; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=wURe0iF88MXqLpoo3r01LYXqT7XRKiWPM4gwYl1aqX4=;
 b=VHoFpfgyOr59VHNcYjcZpESkeXCaqMPoD6i3b3y3s54JCD0+kBAZbOPG/z0sR39yqxFc3
 4MOaE41fi+b7bIJSkSE6Bk2LVnrt8GEoosnUl1ryRVFKmvCOCzLaFkph02JqB/VVizFGUex
 aIEKOM86vqGmkL94DbzFuuJ/IBIhvus=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06DF33D0B08
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 16:49:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA55E3CB8FE
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 16:48:57 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C38AE1400156
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 16:48:56 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1637695f8f.2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786459736; x=1787064536; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLzlyNrq6paWMe6SzfG00xUKY2PGF9alTG5K67alzcM=;
 b=CLXaaJ1uzuQRcrXqCpLbgZezah46/yYVLKpuRPdvFWIzFfeE76Wa3OJBq2sQyd/XvD
 75dW+O96n2YZrhBkzFDno9X4aPOZGj9XUxEJjE/CeR1yFmWiAmoaXXQH6jrDH80VeIqc
 eeBuDin8MmK1+/U+GtDeu9ysUG+EMpXX0GpXOH6hBqYG/8caNi34/YEdR1OTxr9x7xeP
 juIxPLlbliecwQgqwik7g0mXo174z+UFQuvS7QWLz5Qa8cUrKzR1AzwO5Mfw45Vdmgci
 KowZ/9P/x6ID1OdzKhQeuE0/cVnnbhuh8QiOSsxtLbsSyzaEt4CB+48GgBwbpZYoKxIp
 qFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786459736; x=1787064536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLzlyNrq6paWMe6SzfG00xUKY2PGF9alTG5K67alzcM=;
 b=jrddJnu8Bz/B/ER02u5EaIkHbSezdA0xrYNQzmo+FZbTf9Ym2TOCXu2QQHTWw6jcBV
 2S7S9s2oxu/B9w/3twssbPZP9NfGgq8P8NMYsPNotKTaAGq6aemNxd6qKFFDn9RUW03s
 +ywKmKeTFVrW2X+A5SAhQ74zJBDRDDZrYVPsB3rpXOW/zPBxcHuOc/sjrpmp1f3zWWCs
 2Tg0cAEqbdYRGM8cmnNNYFtPjwXQnufTQ6fX6WjPruXaG+dEncCNBcq0sIkQ0dLJiI5r
 hkukC8Y6flyHVKBvxx0D8p18UoSREYYlb8/xbamG08I3+mrGF+wg5ORefeQKMN35r6H+
 EzgA==
X-Gm-Message-State: AOJu0Yx1iPZMMaGNjoMwEYPFXlDHlIMghdfnpdOCv1QwQib7dxCxA6ms
 TsN039xREet3RgV/tuZ4Wj3K2jQUXIBSsZLtNJho80NS96zV47C8sJAxn/H0jTPNDcCqok1APPn
 W7Qz4mtk=
X-Gm-Gg: AR+sD12cO6r6bx7gKWxlL3MDCIbex+ew1Dv9eWeOc7r9wADNxd9E5Itc47itBq3HJR9
 oyvQupJTwfPwgbhk86fZH3kTeNP3xPcdYm8s/P9i4PkWjbbi80Pa2wdkLtLwgGGDYQGHrayJrHA
 xarSmPKUmuuU7flhEuqnsQ5guketVXjZ8NVMuQKv5qBN4r6LZQjUzxhVsH+9Mj1x6ZlGRaAlOVT
 ydd6Skijs6TeyBSbUPVBy5rehVD4y5taQy6suHVxVmOOalhlQ0JdAEoN8HryR4m9F8i8+q9yRgm
 22XeAKsGsvnQoHPoTJwScNk4m15a6pbYcviluUbUtmdPfSWxRMsa474dfaB/CwKzA5dXsKgM/rM
 NV2XkzV6NH2r3btIG0ByH7dX177pdlvLxEvOt4tXtUVbXooOaG2DWC5qygMDCPHyq5V/S3Ehhdv
 bLQX0uMvdgNYZS3I9v86sbn3M06DB91kT8AOliA/tU6Uo10r9vTrh+GhacWGA=
X-Received: by 2002:a05:6000:25c6:b0:47f:9759:7f0e with SMTP id
 ffacd0b85a97d-4814ad851eamr6355279f8f.7.1786459735655; 
 Tue, 11 Aug 2026 07:48:55 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5be29fsm4673767f8f.12.2026.08.11.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:48:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 16:48:52 +0200
Message-ID: <20260811144854.97821-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

timer_delete/speculative/5-{1,2}, timer_getoverrun/speculative/6-{1,2,3},
timer_gettime/speculative/6-{1,2,3}, and timer_settime/speculative/12-{1,2,3}
all test behavior for an invalid timerid that POSIX explicitly leaves
undefined (Issue 6/TC2 made EINVAL optional; some of these functions'
ERRORS sections define no errors at all). Remove them instead of
special-casing a SIGSEGV some implementations produce for this input[2].

[0] https://pubs.opengroup.org/onlinepubs/9799919799/functions/timer_getoverrun.html
[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/timer_delete.html
[2] https://lore.kernel.org/ltp/20260808150331.127440-1-avinesh.kumar@suse.com/

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../interfaces/timer_delete/coverage.txt      |  5 +-
 .../interfaces/timer_delete/speculative/5-1.c | 40 --------
 .../interfaces/timer_delete/speculative/5-2.c | 94 -------------------
 .../timer_delete/speculative/LDLIBS           |  1 -
 .../timer_getoverrun/speculative/6-1.c        | 39 --------
 .../timer_getoverrun/speculative/6-2.c        | 58 ------------
 .../timer_getoverrun/speculative/6-3.c        | 50 ----------
 .../timer_getoverrun/speculative/LDLIBS       |  1 -
 .../interfaces/timer_gettime/coverage.txt     |  6 +-
 .../timer_gettime/speculative/6-1.c           | 38 --------
 .../timer_gettime/speculative/6-2.c           | 48 ----------
 .../timer_gettime/speculative/6-3.c           | 52 ----------
 .../timer_gettime/speculative/LDLIBS          |  1 -
 .../interfaces/timer_settime/coverage.txt     | 10 +-
 .../timer_settime/speculative/12-1.c          | 42 ---------
 .../timer_settime/speculative/12-2.c          | 57 -----------
 .../timer_settime/speculative/12-3.c          | 59 ------------
 .../timer_settime/speculative/LDLIBS          |  1 -
 18 files changed, 15 insertions(+), 587 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/LDLIBS
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/LDLIBS
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/LDLIBS
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/LDLIBS

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/coverage.txt b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/coverage.txt
index 51b8c5a711d9..11276c261286 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/coverage.txt
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/coverage.txt
@@ -5,4 +5,7 @@ Assertion	Covered?
 2		YES
 3		YES
 4		YES
-5		YES
+5		WON'T*
+
+* EINVAL is optional here (POSIX Issue 6/TC2; no errors are defined
+at all as of Issue 8), so not testable.
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
deleted file mode 100644
index 912cf5800e6f..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-1.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
-
- * Test to see if timer_delete() returns -1 and sets errno==EINVAL if
- * timerid is not a valid timer ID or not.
- * Since this is a "may" requirement, either option is a PASS.
- */
-
-#include <time.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define BOGUSTIMERID 99999
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	timer_t tid;
-	int tval = BOGUSTIMERID;
-	tid = (timer_t) & tval;
-
-	if (timer_delete(tid) == -1) {
-		if (errno == EINVAL) {
-			printf
-			    ("timer_delete() returned -1 and set errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf
-			    ("timer_delete() returned -1, but didn't set errno!=EINVAL\n");
-			return PTS_FAIL;
-		}
-	}
-
-	printf("timer_delete() did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
deleted file mode 100644
index 74eeb46793b2..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
-
- * Test to see if timer_delete() returns -1 and sets errno==EINVAL when
- * trying to delete a timer that has already been deleted or not.
- * Since this is a "may" assertion, either option is a pass.
- * Steps:
- * - Run test case 1-1.c and then try to delete the timer again.
- *
- * For this test, signal SIGTOTEST will be used, clock CLOCK_REALTIME
- * will be used.
- */
-
-#include <time.h>
-#include <signal.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define SIGTOTEST SIGALRM
-#define TIMERSEC 3
-
-static void handler(int signo PTS_ATTRIBUTE_UNUSED)
-{
-	printf("Should not have caught signal\n");
-	exit(PTS_FAIL);
-}
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	struct sigaction act;
-	timer_t tid;
-	struct itimerspec its;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGTOTEST;
-
-	act.sa_handler = handler;
-	act.sa_flags = 0;
-
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = TIMERSEC;
-	its.it_value.tv_nsec = 0;
-
-	if (sigemptyset(&act.sa_mask) == -1) {
-		perror("Error calling sigemptyset\n");
-		return PTS_UNRESOLVED;
-	}
-	if (sigaction(SIGTOTEST, &act, 0) == -1) {
-		perror("Error calling sigaction\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_settime(tid, 0, &its, NULL) != 0) {
-		perror("timer_settime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_delete(tid) != 0) {
-		perror("timer_delete() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (sleep(TIMERSEC) != 0) {
-		printf("sleep() did not sleep full time\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_delete(tid) == -1) {
-		if (errno == EINVAL) {
-			printf("fcn returned -1 and set errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("errno!=EINVAL, but fcn returned -1\n");
-			return PTS_FAIL;
-		}
-	}
-
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/LDLIBS b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/LDLIBS
deleted file mode 100644
index 08f7cd60c2ad..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/LDLIBS
+++ /dev/null
@@ -1 +0,0 @@
--lrt
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
deleted file mode 100644
index 6e18560e5084..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_getoverrun() sets errno=EINVAL if no timers have been
- * created yet or not.  Since this is a "may" assertion, either way is
- * a pass.
- */
-
-#include <time.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define BOGUSTID 9999
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	timer_t tid;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
-
-	if (timer_getoverrun(tid) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1, but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
deleted file mode 100644
index 2d7f3967ced1..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-2.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_getoverrun() returns -1 and sets errno==EINVAL when
- * trying to call timer_getoverrun on a timer that has been deleted or not.
- * Since this assertion is a "may," either option is a pass.
- *
- * For this test, signal SIGCONT will be used, clock CLOCK_REALTIME
- * will be used.
- */
-
-#include <sys/types.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <time.h>
-#include <unistd.h>
-#include "posixtest.h"
-
-#define TIMERSEC 3
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGCONT;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_delete(tid) != 0) {
-		perror("timer_delete() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_getoverrun(tid) == -1) {
-		if (errno == EINVAL) {
-			printf("fcn returned -1 and set errno=EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
deleted file mode 100644
index 933a31dcd3e7..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-3.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if  timer_getoverrun() sets errno = EINVAL for  timerid != a
- * timer ID created via timer_create().  [Try to set timerid to a timer ID
- * created + 1.]
- * Since this assertion is a "may," either option is a pass.
- *
- * For this test, signal SIGCONT will be used, clock CLOCK_REALTIME
- * will be used.
- */
-
-#include <sys/types.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <time.h>
-#include "posixtest.h"
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGCONT;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_getoverrun(tid + 1) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/LDLIBS b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/LDLIBS
deleted file mode 100644
index 08f7cd60c2ad..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/LDLIBS
+++ /dev/null
@@ -1 +0,0 @@
--lrt
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/coverage.txt b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/coverage.txt
index aa9a47e4b5c2..dcfee8dfa2fe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/coverage.txt
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/coverage.txt
@@ -6,4 +6,8 @@ Assertion	Coverage
 3		YES
 4		YES
 5		YES
-6		YES
+6		WON'T*
+
+* POSIX explicitly states the behavior is undefined for an invalid
+timerid here (Issue 6/TC2 made EINVAL optional, not required), so
+not testable.
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
deleted file mode 100644
index d09c2f70901d..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-1.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_gettime() sets errno = EINVAL if no timers have been
- * created yet and it is called with a bogus timer ID.  Since this is a "may"
- * assertion, either way is pass.
- */
-
-#include <time.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define BOGUSTID 9999
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	timer_t tid;
-	struct itimerspec its;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
-	if (timer_gettime(tid, &its) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
deleted file mode 100644
index 88a8d221914b..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-2.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_gettime() sets errno = EINVAL timerid != a timer ID
- * created via timer_create().  [Try to set timerid to a timer ID
- * created + 1.]  Since this assertion is a "may," either way is a pass.
- *
- * For this test, signal SIGCONT will be used, clock CLOCK_REALTIME
- * will be used.
- */
-
-#include <time.h>
-#include <signal.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-	struct itimerspec its;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGCONT;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_gettime(tid + 1, &its) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
deleted file mode 100644
index ef7c37f5eb99..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/6-3.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_gettime() sets errno = EINVAL when timerid =
- * a timer ID of a deleted timer.  Since this assertion is a "may"
- * assertion, either way is a pass.
- *
- * For this test, signal SIGCONT will be used.
- * Clock CLOCK_REALTIME will be used.
- */
-
-#include <time.h>
-#include <signal.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-	struct itimerspec its;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGCONT;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-	if (timer_delete(tid) != 0) {
-		perror("timer_delete() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_gettime(tid, &its) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/LDLIBS b/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/LDLIBS
deleted file mode 100644
index 08f7cd60c2ad..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_gettime/speculative/LDLIBS
+++ /dev/null
@@ -1 +0,0 @@
--lrt
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/coverage.txt b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/coverage.txt
index 8e6034a21a6c..a4cd9d379fd7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/coverage.txt
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/coverage.txt
@@ -12,14 +12,16 @@ Assertion	Covered?
 9		YES
 10		YES
 11		YES
-12		YES
+12		WON'T**
 13		YES
 
 *Decided against testing this assertion as it would be quite difficult
 to get an accurate test.
 
+** POSIX explicitly states the behavior is undefined for an invalid
+timerid here (Issue 6/TC2 made EINVAL optional, not required), so
+not testable.
+
 Possible other items to test:
 assertion 6 - What happens if it_interval < it_value? - Would be easy to
-use code from 6-1 and replace numbers to test this.
-
-May also want to run canned boundary tests on tid values.
+use code from 6-1 and replace numbers to test this.
\ No newline at end of file
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
deleted file mode 100644
index 5d4e1dda30ba..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-1.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_settime() sets errno = EINVAL if no timers have been
- * created yet.  Since this is a "may" assertion, either way is a pass.
- */
-
-#include <time.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define BOGUSTID 9999
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	timer_t tid;
-	struct itimerspec its;
-	int tval = BOGUSTID;
-	tid = (timer_t) & tval;
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = 0;
-	its.it_value.tv_nsec = 0;
-
-	if (timer_settime(tid, 0, &its, NULL) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1, but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
deleted file mode 100644
index 3b6901c25dc7..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-2.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_settime() sets errno = EINVAL timerid != a timer ID
- * created via timer_create().  [Try to set timerid to a timer ID
- * created + 1.]  Since this test is a "may" assertion, either way is a
- * pass.
- *
- * For this test, signal SIGTOTEST will be used, clock CLOCK_REALTIME
- * will be used.
- */
-
-#include <sys/types.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <time.h>
-#include "posixtest.h"
-
-#define SIGTOTEST SIGALRM
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-	struct itimerspec its;
-
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = 0;
-	its.it_value.tv_nsec = 0;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGTOTEST;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_settime(tid + 1, 0, &its, NULL) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
deleted file mode 100644
index 04ceb2745af3..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/12-3.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (c) 2002, Intel Corporation. All rights reserved.
- * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test to see if timer_settime() sets errno = EINVAL when timerid =
- * a timer ID of a deleted timer.  Since this is a "may" assertion, either
- * way is a pass.
- *
- * For this test, signal SIGTOTEST will be used.
- * Clock CLOCK_REALTIME will be used.
- */
-
-#include <time.h>
-#include <signal.h>
-#include <stdio.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#define SIGTOTEST SIGALRM
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	struct sigevent ev;
-	timer_t tid;
-	struct itimerspec its;
-
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = 0;
-	its.it_value.tv_nsec = 0;
-
-	ev.sigev_notify = SIGEV_SIGNAL;
-	ev.sigev_signo = SIGTOTEST;
-
-	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
-		perror("timer_create() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-	if (timer_delete(tid) != 0) {
-		perror("timer_delete() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if (timer_settime(tid, 0, &its, NULL) == -1) {
-		if (EINVAL == errno) {
-			printf("fcn returned -1 and errno==EINVAL\n");
-			return PTS_PASS;
-		} else {
-			printf("fcn returned -1 but errno!=EINVAL\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
-	}
-	printf("fcn did not return -1\n");
-	return PTS_PASS;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/LDLIBS b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/LDLIBS
deleted file mode 100644
index 08f7cd60c2ad..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/speculative/LDLIBS
+++ /dev/null
@@ -1 +0,0 @@
--lrt
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
