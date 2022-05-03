Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE15C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9CCB3CAA91
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:46:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263433CA968
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5D991000953
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80483210DF;
 Tue,  3 May 2022 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXhvMotBIOFGO7U/GlwzFIRmAYspQvkKIkYMGb3rcsc=;
 b=msoyD1Ne3GVFi7Rdys6s/w1iXDlQkxZNa5/Q6esWgFgPJLDkaOAfWEUb2D7tdFZ9hxXsdl
 I/WPK0kCDgIUGmcEcthuQfjHN2/TBqFcH/1Hq8n+KnXRuUidWjNPAhUPDVworVl8itUsAr
 wYVIJsYMQO7tMT8rFFAJf4PPerv4X5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXhvMotBIOFGO7U/GlwzFIRmAYspQvkKIkYMGb3rcsc=;
 b=aMG8x0Zt+Ih+O4CkSISwbB0PnK44KroL5koGC78YT8Tn1SJKrBlEe3hEW+Wp4hHbxAJ3i4
 yYoQAmuB5U03+UBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DBCB13ABE;
 Tue,  3 May 2022 17:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lWyNGSBqcWLyPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:55 +0200
Message-Id: <20220503174718.21205-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/30] crypto/pcrypt_aead01: Convert to runtime
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
 testcases/kernel/crypto/pcrypt_aead01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 0609af9f6..d10d744c5 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -55,7 +55,7 @@ void run(void)
 		if (TST_RET)
 			tst_brk(TBROK | TRERRNO, "del_alg");
 
-		if (tst_timeout_remaining() < 10) {
+		if (!tst_remaining_runtime()) {
 			tst_res(TINFO, "Time limit reached, stopping at "
 				"%d iterations", i);
 			break;
@@ -75,6 +75,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_iteration_runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d76c68109f37"},
 		{"CVE", "2017-5754"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
