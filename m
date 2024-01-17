Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB8C47422
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 17:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AAF73CE316
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 18:30:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C3E23C1D32
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 18:30:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C70A201164
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 18:30:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D542921F69
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705512608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f8VKvmY0efqC4MA+GYdTU45Hpt1QklMrj/VEhQ/8tPY=;
 b=2bLkta3okYkol5Kg3SurB13P642ct/p/GSwkS5LYW096YuyCb6wGehgCOOn1QtHwUaIPRx
 6HFL/UyT6F9EdVJ7nCyQRzRmIOD9VEz65E31uz+Jcval6jVvf2v9LJQEbkbKaBWuNBW2gE
 lVMcR2VWYaeElaPN0U2LjuqRX0Qny10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705512608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f8VKvmY0efqC4MA+GYdTU45Hpt1QklMrj/VEhQ/8tPY=;
 b=Xv4dswOhGJyHPXBmTRHGfqptX0vI2F8LJiLvVX95eISkV4ui+4fD4dw+dcteQvKXlzzDAJ
 NrfX4h5TneGpEDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705512607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f8VKvmY0efqC4MA+GYdTU45Hpt1QklMrj/VEhQ/8tPY=;
 b=cIq44p3VkJwvM01qRdtcaceDsYcA1uk4uR4DSqjWAuUqfsj0FC6ZqBerUVg67UjmDasfpI
 S/a/q2f4Hkafk5DnSLShbm5yDcpF5xtJFTsBQnlQGff/k670aZJQOC8HyLEBXEuP6hoB+8
 yXyreiC+5hQD2Ag1vHTXO+G7GHUDCCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705512607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f8VKvmY0efqC4MA+GYdTU45Hpt1QklMrj/VEhQ/8tPY=;
 b=fYoqMLD+fOzQ+iWAuh0yvUlbmgtBxHVDeJ9Ae1DdNXW7GAG8GaruJMqoJCK2l4hI1FrqMF
 YKyVRTVhbU/enEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9A2F13800
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DaLPMJ8OqGVTQAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:30:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 18:30:03 +0100
Message-ID: <20240117173006.31521-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cIq44p3V;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fYoqMLD+
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.79)[99.07%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D542921F69
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add tst_is_compat_mode() helper function
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

New helper function to simplify checks whether the test process runs
in e.g. 32bit compat mode on 64bit kernel.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_kernel.h | 5 +++++
 lib/tst_kernel.c     | 6 ++++++
 lib/tst_test.c       | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 9d3a8d315..89de79928 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -10,6 +10,11 @@
  */
 int tst_kernel_bits(void);
 
+/*
+ * Returns non-zero if the test process is running in compat mode.
+ */
+int tst_is_compat_mode(void);
+
 /*
  * Checks if the kernel module is built-in.
  *
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 51e4daa09..7fd1af871 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -23,6 +23,7 @@
 #include "test.h"
 #include "tst_kernel.h"
 #include "old_safe_stdio.h"
+#include "lapi/abisize.h"
 
 static int get_kernel_bits_from_uname(struct utsname *buf)
 {
@@ -90,6 +91,11 @@ int tst_kernel_bits(void)
 	return kernel_bits;
 }
 
+int tst_is_compat_mode(void)
+{
+	return TST_ABI != tst_kernel_bits();
+}
+
 static int tst_search_driver_(const char *driver, const char *file)
 {
 	struct stat st;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index bcf2c4555..187358936 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1194,7 +1194,7 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->skip_in_secureboot && tst_secureboot_enabled() > 0)
 		tst_brk(TCONF, "SecureBoot enabled, skipping test");
 
-	if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())
+	if (tst_test->skip_in_compat && tst_is_compat_mode())
 		tst_brk(TCONF, "Not supported in 32-bit compat mode");
 
 	if (tst_test->needs_cmds) {
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
