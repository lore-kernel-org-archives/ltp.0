Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE47CA0ED1
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 08:13:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 487F73CA46D
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 10:13:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5683B3C2CC6
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:13:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70D89600700
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 10:13:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57D76218E4;
 Fri, 15 Aug 2025 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755245591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AdSVygGftFhqevF6rhL401O9gqH7TRJO6rMtFt2j+AA=;
 b=UL+rMqLLTgYsuzKXjFuK6WQkVOHcrGXIBtjQzdAlav+YHCGCJDfjVCR4621BsW7f2p5BXv
 X2jT2CC30qyNSy9vK3+i4wm3YVponJTP5Li2FZ0klIQnPIb3ViBS1Cxzbqd3mwUC6DDjye
 SD8tNSBrz5F5QegAmfI0KtEerFHscCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755245591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AdSVygGftFhqevF6rhL401O9gqH7TRJO6rMtFt2j+AA=;
 b=StKDPMUBHA0jXQ4SlwIHL9+H3ORchDQx/p4w4pKHBYSxDVFT8eh3RV/xtfg2dUe17MExpw
 G1eKVcqNEBoDqMCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UL+rMqLL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=StKDPMUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755245591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AdSVygGftFhqevF6rhL401O9gqH7TRJO6rMtFt2j+AA=;
 b=UL+rMqLLTgYsuzKXjFuK6WQkVOHcrGXIBtjQzdAlav+YHCGCJDfjVCR4621BsW7f2p5BXv
 X2jT2CC30qyNSy9vK3+i4wm3YVponJTP5Li2FZ0klIQnPIb3ViBS1Cxzbqd3mwUC6DDjye
 SD8tNSBrz5F5QegAmfI0KtEerFHscCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755245591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AdSVygGftFhqevF6rhL401O9gqH7TRJO6rMtFt2j+AA=;
 b=StKDPMUBHA0jXQ4SlwIHL9+H3ORchDQx/p4w4pKHBYSxDVFT8eh3RV/xtfg2dUe17MExpw
 G1eKVcqNEBoDqMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1635713876;
 Fri, 15 Aug 2025 08:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GfBNBBfsnmgrFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Aug 2025 08:13:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Aug 2025 10:13:07 +0200
Message-ID: <20250815081307.583308-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 57D76218E4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] ltx: Update to 1.2
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

Changes in 1.2 and 1.1:
https://github.com/linux-test-project/ltx/releases/tag/v1.2
https://github.com/linux-test-project/ltx/releases/tag/v1.1

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

just FYI.

Thanks for fixing ltx.

Kind regards,
Petr

 tools/ltx/ltx-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/ltx/ltx-src b/tools/ltx/ltx-src
index d6d1509479..580e1f336f 160000
--- a/tools/ltx/ltx-src
+++ b/tools/ltx/ltx-src
@@ -1 +1 @@
-Subproject commit d6d1509479537f4fdfa9b5adcb67eb6312714999
+Subproject commit 580e1f336f992de96443ea3d3ffcded202cf89c9
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
