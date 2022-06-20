Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CAEC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:20:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59AB03C9221
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:20:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5E33C1B8F
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3C8F140005B
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 756351FB54
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5uKp1SyCloJtkvjdL29jxY/oSXCOtYwUkPBR1nDDo4=;
 b=josAqfpH8CKhUislqDqMJLixJCj+7B65eEhcmj3RxU3cpMu9h5ZcoO7GbeoE0yg3f8pgml
 S7Vy0WahV3lx2qFHaRtrBlYTvmiGO07mpx8CFRfiZrB+ChFI1GaPMzLylyqg/gOKulOuvI
 rFFufKZO1/OBJVwdJimEbYkxAMQY3zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5uKp1SyCloJtkvjdL29jxY/oSXCOtYwUkPBR1nDDo4=;
 b=2gE0a5VwNQwFxexRwEQj9esot90ipbcCagZ+qBCSzQtPmfGtq1Ib4QEkCdY/jy/LyT4tVS
 M0Rjx4+tQ+SUDCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61C7F134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wKSCFqw7sGJgQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:40 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:40 +0200
Message-Id: <20220620092146.7604-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/7] openposix: pthread_rwlockattr_getpshared/2-1: Fix
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

Propagate a failure in child to the parent properly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../pthread_rwlockattr_getpshared/2-1.c       | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/2-1.c
index 3ffdc0cea..72c40f117 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_getpshared/2-1.c
@@ -126,7 +126,11 @@ int main(void)
 	if (pid == -1) {
 		perror("Error at fork()");
 		return PTS_UNRESOLVED;
-	} else if (pid > 0) {
+	}
+
+	if (pid > 0) {
+		int status;
+
 		/* Parent */
 		/* wait until child do wrlock */
 		while (rwlock_data->data == 0) {
@@ -141,7 +145,7 @@ int main(void)
 		printf("Parent unlocked.\n");
 
 		/* Wait for child to end */
-		wait(NULL);
+		wait(&status);
 
 		if ((shm_unlink(shm_name)) != 0) {
 			perror("Error at shm_unlink()");
@@ -154,6 +158,16 @@ int main(void)
 			return PTS_FAIL;
 		}
 
+		if (!WIFEXITED(status)) {
+			printf("Parent: did not exit properly!\n");
+			return PTS_FAIL;
+		}
+
+		if (WEXITSTATUS(status)) {
+			printf("Parent: failure in child\n");
+			return WEXITSTATUS(status);
+		}
+
 		printf("Test PASSED\n");
 		return PTS_PASS;
 	} else {
@@ -195,5 +209,7 @@ int main(void)
 			rwlock_data->data = -1;
 			return PTS_FAIL;
 		}
+
+		return PTS_PASS;
 	}
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
