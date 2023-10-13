Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62D0CDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:48:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69D93CD3A4
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:48:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC45E3C8767
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C05C1A0237F
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08A07219B3;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697183289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q17GhFVieFWg1wBEVZOTURESZnAlA7z73tONCbkfgAI=;
 b=YIoX5nWdslcfDGAOzbt9bOmpnUtn9t9iZRpJIB0t9Hx4EFwIw1Aa7Euk5KHG/okfcdocUE
 mQRFv9VEmWMRs4j/q61mQdtcljJjZalk78GwhSUToeO6ftGBXsATOVkiwRqP2L163DKo2D
 wRweRS/9fSNJTozuXQreCyoo0z8dCKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697183289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q17GhFVieFWg1wBEVZOTURESZnAlA7z73tONCbkfgAI=;
 b=LVktR8GrcXPsPB8r6HnrHbk8Xg8dQphyDn7yPFZBg+deHhLrsqT8sLrjsm3b3w4p7AvGUY
 25vrvriTdDwMbqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3861139ED;
 Fri, 13 Oct 2023 07:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GDmRNjj2KGVqXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 07:48:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 09:47:44 +0200
Message-ID: <20231013074748.702214-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013074748.702214-1-pvorel@suse.cz>
References: <20231013074748.702214-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] tst_kernel: Add safe_check_driver()
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

And use it in tst_test.c. It will be more reused in the next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_kernel.h | 9 +++++++++
 lib/tst_kernel.c     | 6 ++++++
 lib/tst_test.c       | 3 +--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 9d3a8d315..8caf3f733 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -30,4 +30,13 @@ int tst_check_builtin_driver(const char *driver);
  */
 int tst_check_driver(const char *driver);
 
+/*
+ * Checks support for the kernel module (both built-in and loadable)
+ * and exit with TCONF if driver not available.
+ *
+ * @param driver The name of the driver.
+ * On Android it *always* passes (always expect the driver is available).
+ */
+void safe_check_driver(const char *driver);
+
 #endif	/* TST_KERNEL_H__ */
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 4b75ceadb..de4c28308 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -198,3 +198,9 @@ int tst_check_driver(const char *driver)
 
 	return -1;
 }
+
+void safe_check_driver(const char *driver)
+{
+	if (tst_check_driver(driver))
+		tst_brkm(TCONF, NULL, "%s driver not available", driver);
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c2f8f503f..087c62a16 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1191,8 +1191,7 @@ static void do_setup(int argc, char *argv[])
 		int i;
 
 		for (i = 0; (name = tst_test->needs_drivers[i]); ++i)
-			if (tst_check_driver(name))
-				tst_brk(TCONF, "%s driver not available", name);
+			safe_check_driver(name);
 	}
 
 	if (tst_test->mount_device)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
