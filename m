Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFCAC43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E48CE3C9282
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:20:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8693C1B8F
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5DE060072B
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87E0B21BE2
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1S5CMDadnKWsS0ZHwUJm5dUxwiiKnLI2F6ewtB4hp4=;
 b=Caw6cjav1UlFyiZzgaiKoLo2tTqtbnxaalOWspSGjUSRZVfgghP7HAu3sAVuyPRmR89yvc
 akREHjQ3NvY8a5zLd+08AWqrv/yoJyGK53nuu+wxznMHrBvbGWYe0fMQBgyv+mqFK9TY5x
 k0byNW/GMUyaPokNdS4PDYFWgQeQlHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1S5CMDadnKWsS0ZHwUJm5dUxwiiKnLI2F6ewtB4hp4=;
 b=pPpZgzEc6LcTH7WCXtv91Ng35oFwwK5vkb6PkkEpI1wrlPaiyzL2NsUk+oFS+aRO/OxL+k
 R5WdCXXtZI8uloBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70793134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h9bXGa07sGJkQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:41 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:42 +0200
Message-Id: <20220620092146.7604-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] openposix: sem_destroy/3-1: Fix
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

There were several problems in the test and it actually didn't even call
the sem_destroy() function at all.

- The main thread did call thread_exit() before actually attempting to
  destroy the semaphores

- The program exit value was undefined (random garbage) in the unlikely
  case that pthread_join() failed for one of the threads

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/sem_destroy/3-1.c  | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/3-1.c
index 2a02a7532..bca21371f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_destroy/3-1.c
@@ -19,11 +19,11 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <pthread.h>
+#include <string.h>
 #include "posixtest.h"
 
 #define TEST "3-1"
 #define FUNCTION "sem_destroy"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 static sem_t psem, csem;
 static int n;
@@ -33,6 +33,7 @@ static void *consumer(void *);
 int main(void)
 {
 	pthread_t prod, cons;
+	int err;
 	long cnt = 3;
 
 	n = 0;
@@ -40,28 +41,40 @@ int main(void)
 		perror("sem_init");
 		return PTS_UNRESOLVED;
 	}
+
 	if (sem_init(&psem, 0, 1) < 0) {
 		perror("sem_init");
 		return PTS_UNRESOLVED;
 	}
+
 	if (pthread_create(&prod, NULL, producer, (void *)cnt) != 0) {
 		perror("pthread_create");
 		return PTS_UNRESOLVED;
 	}
+
 	if (pthread_create(&cons, NULL, consumer, (void *)cnt) != 0) {
 		perror("pthread_create");
 		return PTS_UNRESOLVED;
 	}
 
-	if (pthread_join(prod, NULL) == 0 && pthread_join(cons, NULL) == 0) {
+	err = pthread_join(prod, NULL);
+	if (err) {
+		printf("Failed to join thread: %s", strerror(err));
+		return PTS_UNRESOLVED;
+	}
+
+	err = pthread_join(cons, NULL);
+	if (err) {
+		printf("Failed to join thread: %s", strerror(err));
+		return PTS_UNRESOLVED;
+	}
+
+	if (sem_destroy(&psem) == 0 && sem_destroy(&csem) == 0) {
 		puts("TEST PASS");
-		pthread_exit(NULL);
-		if ((sem_destroy(&psem) == 0) && sem_destroy(&csem) == 0) {
-			return PTS_PASS;
-		} else {
-			puts("TEST FAILED");
-			return PTS_FAIL;
-		}
+		return PTS_PASS;
+	} else {
+		puts("TEST FAILED");
+		return PTS_FAIL;
 	}
 }
 
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
