Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F769C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFD253CACBA
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAB6F3CA994
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E7911000956
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BD4F21872;
 Tue,  3 May 2022 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpLsIIYCHe2lBi4iNcFB2jktpucj8fTnJhuO37Mm/Ts=;
 b=rR1/Cps3p5b5aLwnYvzTV/x+BhxR6v6j03O9TBpMaWsWXftLH9fPr6XJRr4Cl9Cj2k0121
 LfWhUVVVFONpjlJvAG/iHPLUu3REGK6P7lyg+M6xrzVotZP/a8NDcoQZpLgqWf9kquzxBu
 PO3sVuxPVafIcHJG+5KaF5UgxOFuyMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpLsIIYCHe2lBi4iNcFB2jktpucj8fTnJhuO37Mm/Ts=;
 b=RzeI6jEe2EU3xtl3dn2IX4icSFpUGlWqmIXbLF3OXHyUW0Qd+qdj1hIkRFdUV/z0Az6Ztj
 b6F1WveoREWGDqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24FB813ABE;
 Tue,  3 May 2022 17:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0hOjBypqcWIaPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:10 +0200
Message-Id: <20220503174718.21205-23-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 22/30] crypto/af_alg02: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/crypto/af_alg02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index b96b8b341..9c2f488c4 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -65,7 +65,7 @@ static void run(void)
 	TST_CHECKPOINT_WAIT(0);
 
 	while (!completed) {
-		if (tst_remaining_runtime()) {
+		if (!tst_remaining_runtime()) {
 			pthread_cancel(thr);
 			tst_brk(TBROK,
 				"Timed out while reading from request socket.");
@@ -77,7 +77,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.runtime_per_iteration = 20,
+	.max_iteration_runtime = 20,
 	.needs_checkpoints = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ecaaab564978"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
