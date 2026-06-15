Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15041CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:25:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8516D3E5BB3
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:25:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DBCC3C5763
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:25:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1A7E6002D7
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:25:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E21756ADA3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781533527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ycbv5SfU/WFMeavFjDtHwG/B9h/hI/begFa+Fh7oZs=;
 b=mZCN0OIvMJzmZ7bypWmweDL2ggcejoxCTOpaBbIIj6Gg6p9LZZSoJV/L2+PRyLbnQd3Ln+
 wzKy7QZk9Ot8YjIqNrG2bjYPfcQY8UjlRcQyK68s83y+3+C+YeAFgo5y6uGIc5uheU1haM
 PnsbPUqkBdFpnL7TJolumFK/DMZx+mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781533527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ycbv5SfU/WFMeavFjDtHwG/B9h/hI/begFa+Fh7oZs=;
 b=h53/TqeThVOdTGYY4Fb6JT2S2N2tStI3PMdQWUGjKMOlw75t5rAYnZZNICRd99kI5d+Zi0
 l9jjBMboH5ZR/5BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781533526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ycbv5SfU/WFMeavFjDtHwG/B9h/hI/begFa+Fh7oZs=;
 b=TuswMVMtm0iLx8AI+wnaWEWKNwndFa0gcngaa83UbO8sYxQRMAOQF1+Wiaxzm59PNZWMqU
 +Kt2bBEIGybIZOirmmZhkAjrc+tjLNwao3okZyCAMOoJr4p+ZZ2xvCNB7C1TeTiXp5gXCJ
 bMuNkEvPIr8Zv0EMYOt3bW5h32dKORg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781533526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ycbv5SfU/WFMeavFjDtHwG/B9h/hI/begFa+Fh7oZs=;
 b=6wu9ElLfhUTyHVREFeteZBJbL5aaW0L3xganOwK/kzu84KiU++ZdLR8EzRC4NlnmNKn34R
 xnpEvWrCvR81XLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF4F2779A7
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MqDQMVYLMGpBagAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:25:26 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 16:25:24 +0200
Message-ID: <20260615142526.70655-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: Remove pthread_detach_1-2
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

The POSIX specification of pthread_join() has changed in recent years and
pthread_detach_1-2 test scenario is no longer valid. The POSIX standard
issue 8 says that the behavior of pthread_join() called on a thread ID
which does not refer to a joinable thread is undefined.

https://pubs.opengroup.org/onlinepubs/9799919799/functions/pthread_join.html

The test creates a thread, detaches it using pthread_detach() and then
calls pthread_join(), expecting an error. As stated above, the expected
behavior is now undefined. Remove the test.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../interfaces/pthread_detach/1-2.c           | 218 ------------------
 1 file changed, 218 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c
deleted file mode 100644
index dc5ed39d3..000000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/1-2.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Copyright (c) 2004, Bull S.A..  All rights reserved.
- * Created by: Sebastien Decugis
-
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
- * This sample test aims to check the following assertion:
- *
- * pthread_detach() will indicate that the thread resources
- * can be reclaimed as soon as the thread terminates.
- * This means that pthread_join() will fail on such a thread.
-
- * The steps are:
- *
- * -> create a thread with a joinable state
- * -> detach the thread, either from inside the thread or from outside
- * -> try and join the thread, and check an error is returned.
-
- * The test fails if pthread_join succeeds.
-
- */
-
-/********************************************************************************************/
-/****************************** standard includes *****************************************/
-/********************************************************************************************/
-#include <pthread.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include <sched.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <assert.h>
-/********************************************************************************************/
-/******************************   Test framework   *****************************************/
-/********************************************************************************************/
-#include "../testfrmw/testfrmw.h"
-#include "../testfrmw/testfrmw.c"
- /* This header is responsible for defining the following macros:
-  * UNRESOLVED(ret, descr);
-  *    where descr is a description of the error and ret is an int (error code for example)
-  * FAILED(descr);
-  *    where descr is a short text saying why the test has failed.
-  * PASSED();
-  *    No parameter.
-  *
-  * Both three macros shall terminate the calling process.
-  * The testcase shall not terminate in any other maneer.
-  *
-  * The other file defines the functions
-  * void output_init()
-  * void output(char * string, ...)
-  *
-  * Those may be used to output information.
-  */
-
-/********************************************************************************************/
-/********************************** Configuration ******************************************/
-/********************************************************************************************/
-#ifndef VERBOSE
-#define VERBOSE 1
-#endif
-
-/********************************************************************************************/
-/***********************************    Test cases  *****************************************/
-/********************************************************************************************/
-
-#include "../testfrmw/threads_scenarii.c"
-
-/* This file will define the following objects:
- * scenarii: array of struct __scenario type.
- * NSCENAR : macro giving the total # of scenarii
- * scenar_init(): function to call before use the scenarii array.
- * scenar_fini(): function to call after end of use of the scenarii array.
- */
-
-/********************************************************************************************/
-/***********************************    Real Test   *****************************************/
-/********************************************************************************************/
-
-static unsigned int sc;
-
-static void *threaded(void *arg)
-{
-	int ret = 0;
-
-	if (arg != NULL) {
-		ret = pthread_detach(pthread_self());
-		if (ret != 0) {
-			UNRESOLVED(ret, "Failed to detach the thread");
-		}
-	}
-
-	/* Post the semaphore to unlock the main thread in case of a detached thread */
-	do {
-		ret = sem_post(&(scenarii[sc].sem));
-	}
-	while ((ret == -1) && (errno == EINTR));
-	if (ret == -1) {
-		UNRESOLVED(errno, "Failed to post the semaphore");
-	}
-
-	return arg;
-}
-
-int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
-{
-	int ret = 0;
-	pthread_t child;
-
-	output_init();
-
-	scenar_init();
-
-	for (sc = 0; sc < NSCENAR; sc++) {
-#if VERBOSE > 0
-		output("-----\n");
-		output("Starting test with scenario (%i): %s\n", sc,
-		       scenarii[sc].descr);
-#endif
-
-		if (scenarii[sc].detached != 0) {	/* only joinable threads can be detached */
-			ret =
-			    pthread_attr_setdetachstate(&scenarii[sc].ta,
-							PTHREAD_CREATE_JOINABLE);
-			if (ret != 0) {
-				UNRESOLVED(ret,
-					   "Unable to set detachstate back to joinable");
-			}
-		}
-
-		/* for detached scenarii, we will call pthread_detach from inside the thread.
-		   for joinable scenarii, we'll call pthread_detach from this thread. */
-
-		ret =
-		    pthread_create(&child, &scenarii[sc].ta, threaded,
-				   (scenarii[sc].detached != 0) ? &ret : NULL);
-		switch (scenarii[sc].result) {
-		case 0:	/* Operation was expected to succeed */
-			if (ret != 0) {
-				UNRESOLVED(ret, "Failed to create this thread");
-			}
-			break;
-
-		case 1:	/* Operation was expected to fail */
-			if (ret == 0) {
-				UNRESOLVED(-1,
-					   "An error was expected but the thread creation succeeded");
-			}
-#if VERBOSE > 0
-			break;
-
-		case 2:	/* We did not know the expected result */
-		default:
-			if (ret == 0) {
-				output
-				    ("Thread has been created successfully for this scenario\n");
-			} else {
-				output
-				    ("Thread creation failed with the error: %s\n",
-				     strerror(ret));
-			}
-#endif
-		}
-		if (ret == 0) {	/* The new thread is running */
-			/* Just wait for the thread to terminate */
-			do {
-				ret = sem_wait(&(scenarii[sc].sem));
-			}
-			while ((ret == -1) && (errno == EINTR));
-			if (ret == -1) {
-				UNRESOLVED(errno,
-					   "Failed to post the semaphore");
-			}
-
-			/* If we must detach from here, we do it now. */
-			if (scenarii[sc].detached == 0) {
-				ret = pthread_detach(child);
-				if (ret != 0) {
-					UNRESOLVED(ret,
-						   "Failed to detach the child thread.");
-				}
-			}
-
-			/* now check that the thread resources are freed. */
-			ret = pthread_join(child, NULL);
-			if (ret == 0) {
-				FAILED
-				    ("We were able to join a detached thread.");
-			}
-
-			/* Let the thread an additionnal row to cleanup */
-			sched_yield();
-		}
-	}
-
-	scenar_fini();
-#if VERBOSE > 0
-	output("-----\n");
-	output("All test data destroyed\n");
-	output("Test PASSED\n");
-#endif
-
-	PASSED;
-}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
