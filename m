Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C6C369D7
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 09:51:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E393CB314
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 11:51:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19F63C7B97
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 11:51:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD4DE600739
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 11:51:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FF6321164;
 Thu, 24 Apr 2025 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745488292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kd+qxM1+SZ+p/e9tvLK8b7cSzNFah6+5X3shwrXrjXI=;
 b=XT57yLKic2TPxTcoCfagkB6cYRjYKj4HCB0oMJiNCORlu+/O/G7DpOm31VgjDdHmoNfStc
 0MjKD0Q+KC8G4pXhQTwIxwNk/qOwQDTtcj74u97PLWVXVWlizTLZV0wK1gvrbkuX3GM7Mn
 bFntWuhYEAVcZB46DORXLrCkSVwNzEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745488292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kd+qxM1+SZ+p/e9tvLK8b7cSzNFah6+5X3shwrXrjXI=;
 b=nUnEY8sfaYQPUzwCRj3yyoEogNCPQSk95MMk7kjkxnttveNfZ0q4ffsuuQBM+K4C1CtrdD
 /wKifeXBDIkLQEAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XT57yLKi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nUnEY8sf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745488292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kd+qxM1+SZ+p/e9tvLK8b7cSzNFah6+5X3shwrXrjXI=;
 b=XT57yLKic2TPxTcoCfagkB6cYRjYKj4HCB0oMJiNCORlu+/O/G7DpOm31VgjDdHmoNfStc
 0MjKD0Q+KC8G4pXhQTwIxwNk/qOwQDTtcj74u97PLWVXVWlizTLZV0wK1gvrbkuX3GM7Mn
 bFntWuhYEAVcZB46DORXLrCkSVwNzEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745488292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kd+qxM1+SZ+p/e9tvLK8b7cSzNFah6+5X3shwrXrjXI=;
 b=nUnEY8sfaYQPUzwCRj3yyoEogNCPQSk95MMk7kjkxnttveNfZ0q4ffsuuQBM+K4C1CtrdD
 /wKifeXBDIkLQEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7525D1393C;
 Thu, 24 Apr 2025 09:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TbnGqQJCmhRIAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 24 Apr 2025 09:51:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 24 Apr 2025 11:50:51 +0200
MIME-Version: 1.0
Message-Id: <20250424-fix_ci_results_pipeline-v1-1-f880fe011b89@suse.com>
X-B4-Tracking: v=1; b=H4sIAHoJCmgC/x2M4QpAMBRGX0X3txWLJa8irWUfbmnWLlLy7pafp
 845DwkSQ6gvHkq4WHgPGeqyoGl1YYFin5l0pduq0Y2a+bYT2wQ5t0Ns5IiNA1Rn4E09+9bAUa5
 jQlb/8zC+7wekOg0NaQAAAA==
X-Change-ID: 20250424-fix_ci_results_pipeline-86ed61fd56ea
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745488292; l=997;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=+au1LkCtqXfw25DDn63aDe4bSjbh+AZWjUGBgApm+js=;
 b=FGN41b71XE/VGXi1DhVtGlS+A/B8Mx0Tc8Stj5QfqUorgPbtUOLgbuV0pA7UP4GPjx6DwrBOw
 O5VyOPVOIjuD0pOouDTDAscxGMC8PboM8IH+oTJy0CtAD412VAPb6GP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8FF6321164
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: fix results being sent while patchwork.sh exit 1
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

Fix a logic issue related to 'patchwork.sh check' command, that is
setting a exit code to 1 when curl command success, causing GitHub CI to
recognize the build as failed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/tools/patchwork.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index 25d65a2a77d193d5150ba6537b0c6e90e54b7fb5..83ef0bb2206277c36bb38845e356625c67ac7d97 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -158,7 +158,7 @@ send_results() {
                         -F "description=$result" \
                         "$PATCHWORK_URL/api/patches/$patch_id/checks/"
 
-                [ $? -eq 0 ] && exit 1
+                [ $? -eq 0 ] || exit 1
         done
 }
 

---
base-commit: 80fd2d673bc0fd8514190a061219c24933b6f03f
change-id: 20250424-fix_ci_results_pipeline-86ed61fd56ea

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
