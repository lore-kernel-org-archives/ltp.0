Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C3AC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 13:31:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D8F60E9C
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 13:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51D8F60E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 484273C7F55
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 15:31:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D377D3C1CC3
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 15:31:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C7891A01125
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 15:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633527082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=erSjctIALv4IE2HWokuxEkXwVkf+flUIOIFYdO9J/bg=;
 b=jOqUlz3tYV6VaiPHylEeQlLA03z5Sy4Jnx81NC8i1yKqz+qUYD6aDbUHzmS6qbdrYS6tny
 wQxgMfrEcLo+RE2XhhizQHIsX4eFvjX5d1znhZU5KtCF6BIkoQ4RPMwnMr2FD2xXzOOK3c
 eMG1nYEk8qgzHcxmlxB19iEPE1ctPp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-HogB9v6iNM2hDKeHeYsBqg-1; Wed, 06 Oct 2021 09:31:19 -0400
X-MC-Unique: HogB9v6iNM2hDKeHeYsBqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E9F41006AA5
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 13:31:18 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A67E71F436
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 13:31:17 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  6 Oct 2021 15:31:14 +0200
Message-Id: <281d8fbf1a7df4d85aea6bbd3ff74982923309c5.1633527038.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open_posix: remove pthread_kill/6-1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test fails on recent glibc (glibc-2.34).

Per https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_02:
  If an application attempts to use a thread ID whose lifetime has ended,
  the behavior is undefined."

In some scenarios leading to crash. Example from Florian Weimer [1]:
  Invoking pthread_kill with a thread ID whose lifetime has ended is
  undefined behavior, so this test is invalid. For example, if you run
  this test with GLIBC_TUNABLES=glibc.pthread.stack_cache_size=0,
  the pthread_kill call crashes because without a stack cache,
  the underlying thread control block is unmapped as part of pthread_join."

[1] https://gitlab.com/cki-project/kernel-tests/-/issues/768

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/pthread_kill/6-1.c | 62 -------------------
 .../interfaces/pthread_kill/assertions.xml    |  4 --
 .../interfaces/pthread_kill/coverage.txt      |  1 -
 3 files changed, 67 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c
deleted file mode 100644
index a462ba8e04ce..000000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (c) 2002-3, Intel Corporation. All rights reserved.
- * Created by:  salwan.searty REMOVE-THIS AT intel DOT com
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this
- * source tree.
- *
- * Test that the pthread_kill() function shall return ESRCH when no
- * thread could be found corresponding to that specified by the given
- * thread ID.
- *
- * NOTE: Cannot find 6-1.c in PTS cvs. So write this one.
- */
-
-#include <pthread.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include "posixtest.h"
-
-static void *thread_function(void *arg PTS_ATTRIBUTE_UNUSED)
-{
-	/* Does nothing */
-	pthread_exit(NULL);
-
-	/* To please some compilers */
-	return NULL;
-}
-
-int main(void)
-{
-	pthread_t child_thread;
-	pthread_t invalid_tid;
-
-	int rc;
-
-	rc = pthread_create(&child_thread, NULL, thread_function, NULL);
-	if (rc != 0) {
-		printf("Error at pthread_create()\n");
-		return PTS_UNRESOLVED;
-	}
-
-	rc = pthread_join(child_thread, NULL);
-	if (rc != 0) {
-		printf("Error at pthread_join()\n");
-		return PTS_UNRESOLVED;
-	}
-
-	/* Now the child_thread exited, it is an invalid tid */
-	memcpy(&invalid_tid, &child_thread, sizeof(pthread_t));
-
-	if (pthread_kill(invalid_tid, 0) == ESRCH) {
-		printf("pthread_kill() returns ESRCH.\n");
-		return PTS_PASS;
-	}
-
-	printf("Test Fail\n");
-	return PTS_FAIL;
-}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
index 2289b9bfbb2e..fa74c312bebb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
@@ -16,10 +16,6 @@
   <assertion id="5" tag="ref:XSH6:33594:33595 pt:THR">
     No signal shall be sent if the pthread_kill() function fails.
   </assertion>
-  <assertion id="6" tag="ref:XSH6:33598:33599 pt:THR">
-    [ESRCH] No thread could be found corresponding to that specified by
-    the given thread ID.
-  </assertion>
   <assertion id="7" tag="ref:XSH6:33600:33600 pt:THR">
     [EINVAL] The value of the sig argument is an invalid or unsupported
     signal number.
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
index 03dc3d5a718a..8cfa3d8b6ba3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
@@ -6,6 +6,5 @@ Assertion	Status
 3		YES
 4		IMPLICITLY tested by assertions 6 and 7.
 5		IMPLICITLY tested by assertions 6 and 7.
-6		YES
 7		YES
 8		WON'T test. No way to interrupt the pthread_kill() call.
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
