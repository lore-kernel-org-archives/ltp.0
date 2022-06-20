Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A96C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:20:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACA443C9230
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:20:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11EC23C1B8F
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0AD31000451
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0067B21BDF
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SF4S41HYI4P+U0E88wmsZRggSp+RanVv/y7kZf2T84=;
 b=MTIfJQTRd2tf+2N7zMsDDnGVvnbHk+09r/bagYptPCPODCXeZSQaooqWtAy+8oSiZvn9dC
 qqVsNDiLLqXXvgiIz3MPYoJEhqTatg49INSZ6Cmi9hQE/wLGAkTT7ghjqg31f7zjyZNwA+
 GX6pMXDbCHGMp4nhUejGd7JRUYeC6HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SF4S41HYI4P+U0E88wmsZRggSp+RanVv/y7kZf2T84=;
 b=FIGmAEem4kFtke6q96wTcosiu2Ai5w0SPRX4h3Tmmn6+uQcXocRMK/3n0xXttc8AFbDSww
 KBfaQnN81US9WkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDEB6134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IoupNKw7sGJiQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:40 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:41 +0200
Message-Id: <20220620092146.7604-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/7] openposix: pthread_spin_init/{2-1,2-2}: Fix
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
 .../interfaces/pthread_spin_init/2-1.c        | 20 +++++++++++++++++--
 .../interfaces/pthread_spin_init/2-2.c        | 20 +++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
index b7dd9e05e..f20822c50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-1.c
@@ -100,7 +100,11 @@ int main(void)
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
 		/* wait until child writes to spinlock data */
 		while (spinlock_data->data != 1)
@@ -116,13 +120,23 @@ int main(void)
 		spinlock_data->data = 2;
 
 		/* Wait until child ends */
-		wait(NULL);
+		wait(&status);
 
 		if ((shm_unlink(shm_name)) != 0) {
 			perror("Error at shm_unlink()");
 			return PTS_UNRESOLVED;
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
@@ -170,5 +184,7 @@ int main(void)
 			printf("Child: error at pthread_spin_destroy()\n");
 			return PTS_UNRESOLVED;
 		}
+
+		return PTS_PASS;
 	}
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
index f3cb9b2a3..df0d4df87 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/2-2.c
@@ -106,7 +106,11 @@ int main(void)
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
 		/* wait until child writes to spinlock data */
 		while (spinlock_data->data != 1)
@@ -122,13 +126,23 @@ int main(void)
 		spinlock_data->data = 2;
 
 		/* Wait until child ends */
-		wait(NULL);
+		wait(&status);
 
 		if ((shm_unlink(shm_name)) != 0) {
 			perror("Error at shm_unlink()");
 			return PTS_UNRESOLVED;
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
@@ -175,5 +189,7 @@ int main(void)
 			printf("Child: error at pthread_spin_destroy()\n");
 			return PTS_UNRESOLVED;
 		}
+
+		return PTS_PASS;
 	}
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
