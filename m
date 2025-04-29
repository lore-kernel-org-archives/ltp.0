Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB76C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 13:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94FCE3CBC33
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:55:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8E393CBBFF
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 15:55:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0BEB114002AB
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 15:55:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8BDB1F391
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745934909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bj/WdykjXLsGKK7sqAlyv9P1+Z26sOCO4nJp1EH74Sw=;
 b=JOSAgmfEcapIAOIr83MaEoMTrlYuu0tJ3Go9rRoFGr1TZ2TjB6Aiu2/thStKRfJbSsiXZk
 dMN/MTQ0b+mSVlbAB5u4FNRQaeqZ3CPmz7XduD/2KNNAbpv4EjB0fVCYl9ldKOo2NWd4zX
 5YQNSSMkI1MUcwqdWY6+UAiVAEDy960=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745934909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bj/WdykjXLsGKK7sqAlyv9P1+Z26sOCO4nJp1EH74Sw=;
 b=iVSshI+6SC2pWipzyBYc34xCY+5aoOdU6whnZQX2PPCEepkvpsFplPK+sURhtUIUl132wa
 m7A5lseg7H/C4xAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vWoiypKP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CGFdsl9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745934908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bj/WdykjXLsGKK7sqAlyv9P1+Z26sOCO4nJp1EH74Sw=;
 b=vWoiypKPwb0QyTTILw4FGryFNQS8Luc58tjutpVy4wFfGXZvfCy+SJmEcdu9GlIpDitQYq
 PXcgRO1DdB4A5xgcVJPJTNYdjb6lRxIesTtjTnYxR6fRJSkZOPlfpha5d63KI21C7t+P1G
 xysyctrXs7Zd9lJVaTsMdXRtN2ADpc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745934908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bj/WdykjXLsGKK7sqAlyv9P1+Z26sOCO4nJp1EH74Sw=;
 b=CGFdsl9V4D2nwyEO88YMAOL+DgUN4cEV0HCqYWNQH2SXzwba1tyRzfk5EVAYaJH+txLkpR
 EHEoIXI1H+9L1MAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C66461340C
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 13:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7xgnMDzaEGh4cgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 13:55:08 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 29 Apr 2025 15:55:42 +0200
Message-ID: <20250429135542.19680-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: D8BDB1F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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

This commit moves the check for supported architecture before the check
for test function existence. This allows us do ifdef out the run
function pointer initialization and properly TCONF on unsupported
platform.

Example usage:

 #include "tst_test.h"

 #ifdef __x86_64__
 static void run(void)
 {
	...
 }
 #endif

 struct tst_test test = {
 #ifdef __x86_64__
	.run = run,
 #endif
	.supported_archs = {"x86_64", NULL},
 }

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 694861d95..c47ddd86a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1273,6 +1273,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
+	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
+		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
+
 	assert_test_fn();
 
 	TCID = tid = get_tid(argv);
@@ -1301,9 +1304,6 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver(tst_test->min_kver, 1);
 
-	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
-		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
-
 	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
