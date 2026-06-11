Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE22CD98C7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA65D3E2AA4
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:37:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4E773CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:37:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D1ECB1000643
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:37:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A84975A61;
 Thu, 11 Jun 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781170641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6i3421mjxeChTjMXow1V/01sEtAxgVvLOgOTFnc+HCQ=;
 b=LzeuIgV1zbvAKqNcZZWBLZzaQH3xV6iwGRB+RXx+icsZ5nq34EPY0jq+JiLY6sZQxF35gO
 RI3I/jiyQ6hhMm/7KWWKci8g+YVW4uJwX61JBZ0+dzxnoEChWNQg2rvrZIIWwL7DW4Sazx
 mirQw85Y5diW+KYGZjASpdrzMmekY/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781170641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6i3421mjxeChTjMXow1V/01sEtAxgVvLOgOTFnc+HCQ=;
 b=JZXnPOxvxqxh4EmAs5D9PFM+UUEihSIGg4reVFTvhUo6a1Bcfo2rn0JJ9wromMb0O0KGRi
 HyHUniG1/UmA1SCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LzeuIgV1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JZXnPOxv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781170641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6i3421mjxeChTjMXow1V/01sEtAxgVvLOgOTFnc+HCQ=;
 b=LzeuIgV1zbvAKqNcZZWBLZzaQH3xV6iwGRB+RXx+icsZ5nq34EPY0jq+JiLY6sZQxF35gO
 RI3I/jiyQ6hhMm/7KWWKci8g+YVW4uJwX61JBZ0+dzxnoEChWNQg2rvrZIIWwL7DW4Sazx
 mirQw85Y5diW+KYGZjASpdrzMmekY/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781170641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6i3421mjxeChTjMXow1V/01sEtAxgVvLOgOTFnc+HCQ=;
 b=JZXnPOxvxqxh4EmAs5D9PFM+UUEihSIGg4reVFTvhUo6a1Bcfo2rn0JJ9wromMb0O0KGRi
 HyHUniG1/UmA1SCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81777779A7;
 Thu, 11 Jun 2026 09:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EdkHHtGBKmqALQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 09:37:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 11:37:21 +0200
MIME-Version: 1.0
Message-Id: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
X-B4-Tracking: v=1; b=H4sIANCBKmoC/x2MQQqAIBAAvyJ7TtCiqL4SIaVr7cEUjQjEvycdB
 2YmQ8JImGBmGSI+lMhfFWTDQJ/bdSAnUxla0Q5ikJJbetVro1Pau7DdynmDXPSis9JO+z4aqGm
 IWL1/u6ylfIPT1jVmAAAA
X-Change-ID: 20260611-fix_xfrm_compat_mode-0503f1f9bb8d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781170641; l=2735;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rc+8IRDVwUkihQsjg20iZ8Anfl/u4fDPHmOLyYFIuQ8=;
 b=A3Z66m+0wsPBYqSFjvGdfVbtkzgj0VW2aMzOtgp6XzmG/JcYmJyu5ijOdYgBOaQmD5kUqc7Rk
 LGIytEzbB6EAHaZ+SLCt94p4uOn+DHoHGsT3t3o8KNlkQ+PGdjwOhMa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A84975A61
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] xfrm: Skip on EOPNOTSUPP in compat mode
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

A 32-bit binary running on a 64-bit kernel uses the XFRM netlink compat
layer, which is only available when CONFIG_XFRM_USER_COMPAT is enabled
(and its module loaded). Without it the kernel returns EOPNOTSUPP for
any XFRM netlink message, which is a configuration limitation rather
than a test failure.

Report TCONF instead of TBROK in that case for xfrm01, xfrm02 and
xfrm03.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/network/sockets/xfrm01.c | 3 +++
 testcases/network/sockets/xfrm02.c | 3 +++
 testcases/network/sockets/xfrm03.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
index 5490d6b8a9f7fde79478ae0484e6ea8156d07cf3..22244032a521a42331b0c1411ae33f75622e64ce 100644
--- a/testcases/network/sockets/xfrm01.c
+++ b/testcases/network/sockets/xfrm01.c
@@ -126,6 +126,9 @@ static void setup(void)
 		if (TST_ERR == EPROTONOSUPPORT)
 			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
 
+		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
+
 		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
 	}
 }
diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
index 43edb77d43c8c99e9883fc9922031d559ef31c40..376f6ebe551dd81fbc6a982503eacd68da636f93 100644
--- a/testcases/network/sockets/xfrm02.c
+++ b/testcases/network/sockets/xfrm02.c
@@ -126,6 +126,9 @@ static void setup(void)
 		if (TST_ERR == EPROTONOSUPPORT)
 			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
 
+		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
+
 		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
 	}
 
diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
index 02ab95c6b7a87f8f206b30a39bb6feb097117998..fa5df9c285d540d5cad0e890a73d43ad9aeba1c2 100644
--- a/testcases/network/sockets/xfrm03.c
+++ b/testcases/network/sockets/xfrm03.c
@@ -202,6 +202,9 @@ static void setup(void)
 		if (TST_ERR == EPROTONOSUPPORT)
 			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
 
+		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
+			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
+
 		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
 	}
 

---
base-commit: c685f1b774fab694c42dfb7522bc42d999904373
change-id: 20260611-fix_xfrm_compat_mode-0503f1f9bb8d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
