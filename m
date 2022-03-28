Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A3C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 20:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 414A23C9C72
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 22:46:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9F3E3C97CE
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 22:46:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A02A1A00930
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 22:46:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7F31F85F;
 Mon, 28 Mar 2022 20:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648500406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X6NIxGNottqljoTasC6vRjEbRw8uZfFfQW5dJ7q06EE=;
 b=z1HcTuKOBf2ZObci56N+90ZHlhVBVnHXpkkuLSdoMuMA6igtFtR9fyC6O4t8+rAf95iqVP
 sSK2k1JVzNm77Wx7yyJNyNiEKLFj33Yn5edgOlhIcR+XR+X5muBf4SkuQvxX0DLQDfMGkS
 9hRzgOlt1fRxdOKeGqI3Galc5MFbyK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648500406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=X6NIxGNottqljoTasC6vRjEbRw8uZfFfQW5dJ7q06EE=;
 b=1MJTRo/QomHYG7ct5CPZtEIDGEu0G7GFAl3UxZ+EIayLzHE4Ppj1ZIt0HxAE43SRSKufrN
 czxCJFnMjpAQ6VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A7F1332D;
 Mon, 28 Mar 2022 20:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RHTXD7YeQmIpUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Mar 2022 20:46:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 28 Mar 2022 22:46:43 +0200
Message-Id: <20220328204643.2601-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lib: Retry safe_clone() on ENOSPC|EUSERS
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

In some tests we are creating the namespaces faster than they are being
asynchronously cleaned up in the kernel:

$ sudo ./userns08 -i 10
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:36: TBROK: clone3 failed: ENOSPC (28)

Thus retrying the clone() on ENOSPC (or EUSERS for kernel < 4.9).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* use TST_RETRY_FN_EXP_BACKOFF() (Cyril)

NOTE: 0.1s seems to be safe, although using TST_RETRY_FUNC() with 1s
(the default) would be of course OK.

Kind regards,
Petr

 lib/tst_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 384c73e163..2e89d954ec 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -436,6 +436,9 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
 	return pid;
 }
 
+/* too fast creating namespaces => retrying */
+#define TST_CHECK_ENOSPC(x) ((x) >= 0 || !(errno == ENOSPC || errno == EUSERS))
+
 pid_t safe_clone(const char *file, const int lineno,
 		 const struct tst_clone_args *args)
 {
@@ -444,7 +447,7 @@ pid_t safe_clone(const char *file, const int lineno,
 	if (!tst_test->forks_child)
 		tst_brk(TBROK, "test.forks_child must be set!");
 
-	pid = tst_clone(args);
+	pid = TST_RETRY_FN_EXP_BACKOFF(tst_clone(args), TST_CHECK_ENOSPC, 0.1);
 
 	switch (pid) {
 	case -1:
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
