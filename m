Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AABEB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 10:03:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4A23CE908
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 12:03:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE7823C949E
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 12:03:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2903E1A0238D
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 12:03:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF8261FD92;
 Fri, 21 Jul 2023 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689933813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e92SMc2WrQxEohKvLAgcnY2UFy6+Ht6H/m3ySXg3wwI=;
 b=KqGHyrgeuGKLBNAkb0BGfIYSmWVLfsWRSiSLY9LwIUAL0RtnshZYwAu3CfCln1kXWJ/I57
 LtdM5VcGC05m15+0OWkgVfDj+feBfQJpYtJO/DPrhiwWbX6Pj6HQKUmHII++oZ5cOXFiwH
 hYOwgnwK3gLK/zvZjrbVbBqiIFOXwjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689933813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=e92SMc2WrQxEohKvLAgcnY2UFy6+Ht6H/m3ySXg3wwI=;
 b=fP/o5ayY0cGJBefzu7tGk+ty9sU17M3q/RErJbPmI/gv1mTdM5bBiSVcGvNcvbpwGznTsa
 RP1pngAkwzg3AzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C25D3134BA;
 Fri, 21 Jul 2023 10:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9XaFLfVXumQ4BAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 10:03:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 12:03:30 +0200
Message-Id: <20230721100330.1366932-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] write05: Simplify test using TST_ macros
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/write/write05.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index c1e48f1df..1e85cce6d 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -59,26 +59,12 @@ static void verify_write(unsigned int i)
 
 	sigpipe_cnt = 0;
 
-	TEST(write(*tc->fd, *tc->buf, tc->size));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "write() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != tc->exp_errno) {
-		tst_res(TFAIL | TTERRNO,
-			"write() failed unexpectedly, expected %s",
-			tst_strerrno(tc->exp_errno));
+	TST_EXP_FAIL(write(*tc->fd, *tc->buf, tc->size), tc->exp_errno);
+	if (TST_RET != -1)
 		return;
-	}
 
-	if (tc->exp_errno == EPIPE && sigpipe_cnt != 1) {
+	if (tc->exp_errno == EPIPE && sigpipe_cnt != 1)
 		tst_res(TFAIL, "sigpipe_cnt = %i", sigpipe_cnt);
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "write() failed expectedly");
 }
 
 static void setup(void)
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
