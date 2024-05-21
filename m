Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F79C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:55:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C19CC3D0001
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:55:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6843D3D006A
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD4DE200C0B
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CF6021EFF;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tya/DSqDMmN5eC0X3ZKXefnx7ufrA+dpsxRxpRsNf6o=;
 b=adnUCv+OU0JaLTXdqUqoQzeC+iAnOJL7kPF9vXNYdOBXXGRqSEdZDtwqvEsOLvHoj7rkW4
 PKhukz6Qju4GzwYYGpkG7BSwuhD04ofbtxrYqzFoy5tlUGHwMZ0znptcN5rFvPNjckSuQt
 nw+gsSi9UaUJlZq+ybU7Mm6ZZzrvt2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tya/DSqDMmN5eC0X3ZKXefnx7ufrA+dpsxRxpRsNf6o=;
 b=U6KNyiiasebke+7XojUE+IeNTsFcQycViq+TjKKS7edTd4FfFxqT6ebw+PgeAOvV4mpW17
 9FnWwiUQ07BAE6Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IVKaoASg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lmZOS2IQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tya/DSqDMmN5eC0X3ZKXefnx7ufrA+dpsxRxpRsNf6o=;
 b=IVKaoASgWNyWl++r5RgBCFbDXnsfolwwVoYaeaZyqBfmo/w/9mAV7jSw5XUXj+U4BjoeOE
 +gVgwnwmG+YvBwYqWlFCxhiHIG9mKpYLEQRSQeYIheYgOJ7w2JjJnyB9MRqaebPoKcKg+H
 zUdyMB0rRhrxKbY54HWhhiLedEtrGwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tya/DSqDMmN5eC0X3ZKXefnx7ufrA+dpsxRxpRsNf6o=;
 b=lmZOS2IQAdKKelw2uaY7Q4s7rpR48652RBF8LyrBRuNDI16FY86tew6iMwoMypPXngdots
 Vp5G2TYI+fyzCcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32C7613A75;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AecCz99TGYMPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 10:53:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 12:53:44 +0200
Message-ID: <20240521105348.126316-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521105348.126316-1-pvorel@suse.cz>
References: <20240521105348.126316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5CF6021EFF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] tst_kernel.h: Convert docs to sphinx
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
The same as in v1

 doc/developers/api_c_tests.rst |  2 ++
 include/tst_kernel.h           | 43 +++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index ec53ab33c..2a9f3e7b9 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (c) Linux Test Project, 2024
 
 .. Include headers in this file with:
 .. .. kernel-doc:: ../../include/tst_test.h
@@ -11,6 +12,7 @@ Core LTP API
 
 .. kernel-doc:: ../../include/tst_res_flags.h
 .. kernel-doc:: ../../include/tst_test.h
+.. kernel-doc:: ../../include/tst_kernel.h
 
 Option parsing
 --------------
diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 89de79928..e0ce7ce46 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -5,33 +5,44 @@
 #ifndef TST_KERNEL_H__
 #define TST_KERNEL_H__
 
-/*
- * Returns 32 if we are running on 32bit kernel and 64 if on 64bit kernel.
+/**
+ * tst_kernel_bits() - Detect if running on 32bit or 64bit kernel.
+ *
+ * Return: 32 if the test process is running on 32bit kernel and 64 if on 64bit
+ * kernel.
  */
 int tst_kernel_bits(void);
 
-/*
- * Returns non-zero if the test process is running in compat mode.
+/**
+ * tst_is_compat_mode() - Detect if running in compat mode.
+ *
+ * Detect if the test is 32bit binary executed on a 64bit kernel,
+ * i.e. we are testing the kernel compat layer.
+ *
+ * Return: non-zero if the test process is running in compat mode.
  */
 int tst_is_compat_mode(void);
 
-/*
- * Checks if the kernel module is built-in.
+/**
+ * tst_check_builtin_driver() - Check if the kernel module is built-in.
  *
- * @param driver The name of the driver.
- * @return Returns 0 if builtin driver
- * -1 when driver is missing or config file not available.
- * On Android *always* 0 (always expect the driver is available).
+ * @driver: the name of the driver.
+ *
+ * Return: 0 if builtin driver or -1 when driver is missing or config file not
+ * available. On Android *always* 0 (always expect the driver is available).
  */
 int tst_check_builtin_driver(const char *driver);
 
-/*
- * Checks support for the kernel module (both built-in and loadable).
+/**
+ * tst_check_driver() - Check support for the kernel module.
+ *
+ * Check support for the kernel module (both built-in and loadable).
+ *
+ * @driver: the name of the driver.
  *
- * @param driver The name of the driver.
- * @return Returns 0 if the kernel has the driver,
- * -1 when driver is missing or config file not available.
- * On Android *always* 0 (always expect the driver is available).
+ * Return: 0 if the kernel has the driver, -1 when driver is missing or config
+ * file not available. On Android *always* 0 (always expect the driver is
+ * available).
  */
 int tst_check_driver(const char *driver);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
