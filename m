Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968DC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 14:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E6DA3C8D9F
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 15:43:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96FA3C8BC0
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 15:43:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 21BC91A0044B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 15:43:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CC011F380;
 Tue, 14 Dec 2021 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639492993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSqKyLQhu03G5+I5IylTUrkHJElY9+STx8siHZQjhzc=;
 b=aSvX3Pe2SC6+YI3+XUSrEYa8Uje03n8GKCRLq+sou01FtSsvRiWQzq59LFsqm5B4wSaZW0
 /H+nGuUSRnqadDd+NXByWUefXjepKqBTg1mrCv8Mr6Ux8oRU6d0/6PqtyVpQFNz8tXqonD
 jfJBcTYSpC1KkaY88Jszt2XYeV3f+5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639492993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSqKyLQhu03G5+I5IylTUrkHJElY9+STx8siHZQjhzc=;
 b=c/1ved2IOXzABFCxas27ELY8fm3R6ugfaVQ1KF1a26RATr4X2uc3m3fsO5uRW1MGl8L8jB
 ZjmDJ4fnvJeGE7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B87113EA2;
 Tue, 14 Dec 2021 14:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2HS8FIGtuGEkTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 14:43:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 15:43:08 +0100
Message-Id: <20211214144309.6704-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214144309.6704-1-pvorel@suse.cz>
References: <20211214144309.6704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
new in v2

 lib/tst_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 265df6543b..f92ff858e9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -475,6 +475,19 @@ static void print_help(void)
 {
 	unsigned int i;
 
+	/* see doc/user-guide.txt, which lists also shell API variables */
+	fprintf(stderr, "Environment Variables\n");
+	fprintf(stderr, "---------------------\n");
+	fprintf(stderr, "KCONFIG_PATH         Specify kernel config file\n");
+	fprintf(stderr, "LTPROOT              Prefix for installed LTP, the default is /opt/ltp\n");
+	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
+	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
+	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");
+	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm\n");
+	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
+	fprintf(stderr, "\n");
+
 	fprintf(stderr, "Options\n");
 	fprintf(stderr, "-------\n");
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
