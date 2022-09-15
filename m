Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E18ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:37:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131CE3CAC38
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:37:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2823CABA8
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A2B56002DF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:47 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6C6A33732;
 Thu, 15 Sep 2022 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663234606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n2H7HYmzQGtnAso7xfCgXg/k0Qv5joQmtd/TP2Yknw=;
 b=kFeHK83ujM8cXXlV99tC2TE3SUlLgmiefzZfoEtAbF5wCL4mfGzTFai7MKSNIGaiNfB3Qi
 mEr/HD0AI0SCNCCdXVPexJOKAqbJsMT9xRThGXtulgXLvCrEBXZIVpg+F72bMGNfZFaU3h
 Egl80xUmviEuwu3HisziTarON/XVhiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663234606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n2H7HYmzQGtnAso7xfCgXg/k0Qv5joQmtd/TP2Yknw=;
 b=xiplRtwoA7WPQj0W1aMqTANEisF5O+KIpFoLHhhRtnyLqikpdh8tduM8wlG8YAHtG/NWno
 qSEa1WxHrVS35AAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5243A13310;
 Thu, 15 Sep 2022 09:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id qG59ES7yImPGIgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 09:36:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:36:34 +0200
Message-Id: <20220915093639.2261-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915093639.2261-1-pvorel@suse.cz>
References: <20220915093639.2261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/8] tst_supported_fs: Support skip list when query
 single fs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

And use this feature in zram01.sh.

Also print TINFO if test it supported by the test, quit with TCONF
otherwise (code from do_test_setup() tst_test.c).

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_supported_fs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 2b42d5bb3..e2261244d 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -80,14 +80,19 @@ int main(int argc, char *argv[])
 		return 2;
 	}
 
-	if (optind < argc)
-		return !tst_fs_is_supported(argv[optind]);
+	if (optind < argc) {
+		if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
+			tst_brk(TCONF, "%s is not supported by the test", argv[optind]);
 
+		tst_res(TINFO, "%s is supported by the test", argv[optind]);
+
+		return 0;
+	}
 
 	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
 	if (!filesystems[0])
-		tst_brk(TCONF, "There are no supported filesystems");
+		tst_brk(TCONF, "There are no supported filesystems or all skipped");
 
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
