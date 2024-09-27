Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6807ACEBF8E
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 10:19:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCE653C4FA7
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 12:19:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F3F53C4F7F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:19:17 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40949200D17
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 12:19:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 557A621959
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727432356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JYTMcuE/PJ3kyawov7bjUoc48kkc5x76MPyJWQRpACE=;
 b=0PLdMuCf+UTsCVi5Zq+IxqBcjHjlcIcO0JRt+MCaNGQVpZJ9a8W37VLhgLGux0hLfha2JA
 bH4ONQkB7jRKF6kGiqwLk6UJ6aZbYkI2OvJ3p5RoCoioLJh5NpraafXspKfZORb0sN+/ER
 qgkhEJWuc09ETDs1MHaISZ4Tk/HCKTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727432356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JYTMcuE/PJ3kyawov7bjUoc48kkc5x76MPyJWQRpACE=;
 b=GSWeLaDr4VItvduH2cWdrVNxcYeM0vfZ6Ec7hBVhmIEhHJwb4K388tyEvsCczO5W5kCbLQ
 OF7NTPAuKYtJKnBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0PLdMuCf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GSWeLaDr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727432356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JYTMcuE/PJ3kyawov7bjUoc48kkc5x76MPyJWQRpACE=;
 b=0PLdMuCf+UTsCVi5Zq+IxqBcjHjlcIcO0JRt+MCaNGQVpZJ9a8W37VLhgLGux0hLfha2JA
 bH4ONQkB7jRKF6kGiqwLk6UJ6aZbYkI2OvJ3p5RoCoioLJh5NpraafXspKfZORb0sN+/ER
 qgkhEJWuc09ETDs1MHaISZ4Tk/HCKTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727432356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JYTMcuE/PJ3kyawov7bjUoc48kkc5x76MPyJWQRpACE=;
 b=GSWeLaDr4VItvduH2cWdrVNxcYeM0vfZ6Ec7hBVhmIEhHJwb4K388tyEvsCczO5W5kCbLQ
 OF7NTPAuKYtJKnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427B113A73
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vyd6D6SG9mYSVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 10:19:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Sep 2024 12:18:13 +0200
Message-ID: <20240927101813.12643-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 557A621959
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include: Better documentation for TFAIL and TBROK\
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

Fixes: #1162

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_res_flags.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 806940e0d..a79428fa2 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -9,11 +9,26 @@
 /**
  * enum tst_res_flags - Test result reporting flags.
  *
- * @TPASS: Reports a single success.
- * @TFAIL: Reports a single failure.
- * @TBROK: Reports a single breakage.
+ * @TPASS: Reports a single success. Successes increment passed counter and
+ *         show up in the test results.
+ *
+ * @TFAIL: Reports a single failure. Failures increment failure counter and
+ *         show up in the test results. A failure occurs when test assertion
+ *         is broken.
+ *
+ * @TBROK: Reports a single breakage. Breakages increment breakage counter and
+ *         show up in the test results. Breakages are reported in cases where a
+ *         test couldn't be executed due to an unexpected failure when we were
+ *         setting the test environment. The TBROK status is mostly used
+ *         with tst_brk() which exit the test immediatelly. The difference
+ *         between TBROK and TCONF is that TCONF is used in cases where
+ *         optional functionality is missing while TBROK is used in cases where
+ *         something that is supposed to work is broken unexpectedly.
+ *
  * @TWARN: Reports a single warning. Warnings increment a warning counter and
- *         show up in test results.
+ *         show up in test results. Warnings are somewhere in the middle between
+ *         TBROK and TCONF. Warnings usually appear when something that is
+ *         supposed to be working is broken but the test can somehow continue.
  *
  * @TDEBUG: Prints additional debugging messages, it does not change the test result counters and
  *          the message is not displayed unless debugging is enabled with -D
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
