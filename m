Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71988C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:03:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB003D0412
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:03:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C3B33D0718
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD4332000E9
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2118480E27;
 Mon, 10 Aug 2026 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VU/KzThU3Sa5V0+LPVwXhsibMan6tAsGhPAHxIr9S1A=;
 b=yAIR1F1fvBfVVRq3YOMwBPyf4mrpOHchFnMun6FZKeQqhLhHsuhGTmTmRXRtvRabLd3gb2
 cmGXsj+zO8n5LJNFow7vZedcmsWKAT3DmqbBpbmK+LafLJWJtfFwkfhjKNMXg1IyTwm/Xw
 L8Yv5gD3Oqj/N8qm3CwvV/ywiS23vMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VU/KzThU3Sa5V0+LPVwXhsibMan6tAsGhPAHxIr9S1A=;
 b=0T9MLFRII0bnQxMBy33rDo2mK0/3I1ZBkNFlnIOL/V9vuk/VzDbBQSjlpW5CAhGKAqeW1A
 NDm1sn4bUWnv1EDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VU/KzThU3Sa5V0+LPVwXhsibMan6tAsGhPAHxIr9S1A=;
 b=aZJJPI3Fo6kY15Jy4xOchwJuoYA/TkytSFQrT6hy1yZnlnj0Jehn5KqSZS1aQMrs2Gs3PT
 iCmh0i4CpgZQShf1KgHpay/bHZH8o3Qip9eLp+c7xu1W1I4KG5cAVZ/FARJfdMjQ+Upy9L
 bX/oqy2DA/erMnGxA+l3CLzt2ECcTWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VU/KzThU3Sa5V0+LPVwXhsibMan6tAsGhPAHxIr9S1A=;
 b=29e492Fw9O0o6pSVnpicXEsZxBQth9bZK3KV8AkzKufrvsR/OdyXKFowfGdCq1xeuiAEde
 3rUqRSSGtPwZ3TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B393A779C5;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AA+3KrP1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:47 +0200
Message-ID: <20260810160048.1040517-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 6/7] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

The test that these flag combinations are allowed:
                FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
			   FAN_REPORT_DFID_NAME),

Because the above flag combinations are already "tested" by the tests
that use them and we don't have any tests that >= 5.10 has support for
FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

Reported-by: AnonymeMeow <anonymemeow@gmail.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v4.

 testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa3..db4a5ba63b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -15,6 +15,9 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ *
+ * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
+ * the test.
  */
 
 #define _GNU_SOURCE
@@ -75,6 +78,7 @@ static void do_cleanup(void)
 
 static struct tst_test test = {
 	.setup = do_setup,
+	.max_kver = "7.1",
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.cleanup = do_cleanup,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
