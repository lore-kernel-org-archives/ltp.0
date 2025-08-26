Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915BCA0EFA
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 13:21:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4BEA3CB22B
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 15:21:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ECB13CB79A
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76B50600805
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 710E71F788;
 Tue, 26 Aug 2025 13:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h4Yld2knOMtRHCprHboWHD/TWGJKlzmSa+sc/gtf6Q=;
 b=tXhTdgiSoGYfmVCzpi0/VL5DUGn/vEc4yHyooxp+wJuGxdiXiVjNjdfgvLOLjeyDTjUQ54
 SX2ePivpw0HSOl0xZ8heA5StMH22t5XYKeKSVV94YvauIzF6m2z8Qf2JgLrCaWm/onQxN/
 pKlJqO5H2uA/byy1K/dWXlBS8/Mo8MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h4Yld2knOMtRHCprHboWHD/TWGJKlzmSa+sc/gtf6Q=;
 b=dE602LvARgV5N/vdE3DKOnIxGfnZVu2BE5NZTyaFEIEAiIio/a70QlXwP0dL98LILxOkI6
 +L6+7wml2IIxR9BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tXhTdgiS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dE602LvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h4Yld2knOMtRHCprHboWHD/TWGJKlzmSa+sc/gtf6Q=;
 b=tXhTdgiSoGYfmVCzpi0/VL5DUGn/vEc4yHyooxp+wJuGxdiXiVjNjdfgvLOLjeyDTjUQ54
 SX2ePivpw0HSOl0xZ8heA5StMH22t5XYKeKSVV94YvauIzF6m2z8Qf2JgLrCaWm/onQxN/
 pKlJqO5H2uA/byy1K/dWXlBS8/Mo8MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h4Yld2knOMtRHCprHboWHD/TWGJKlzmSa+sc/gtf6Q=;
 b=dE602LvARgV5N/vdE3DKOnIxGfnZVu2BE5NZTyaFEIEAiIio/a70QlXwP0dL98LILxOkI6
 +L6+7wml2IIxR9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07BC113A51;
 Tue, 26 Aug 2025 13:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4D1pN6m0rWhMLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 26 Aug 2025 13:20:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 26 Aug 2025 15:20:39 +0200
MIME-Version: 1.0
Message-Id: <20250826-upgrade_tools-v1-2-1e9d8d4c5e2f@suse.com>
References: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
In-Reply-To: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756214440; l=492;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=GwBSvay706iS4tlwOCduCtJUYkqrsPRklOFs5I1NheM=;
 b=p0XNSsILKVUoU40ClnWxcZCAeiqiuTKbfdmmo0kVFgFgshiVwFnJKZZzd3uRNtIXuarOUAR9Q
 CCAzRrfLJ7aCa/VV7/opDQV8am3VCMW4sBlbACiuuajuQP+taD0iL6o
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 710E71F788
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ltx: version 1.3
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/ltx/ltx-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/ltx/ltx-src b/tools/ltx/ltx-src
index 580e1f336f992de96443ea3d3ffcded202cf89c9..ce7203b7153c8a4eb0cbcaaf9ab4eb9e6e78d3a9 160000
--- a/tools/ltx/ltx-src
+++ b/tools/ltx/ltx-src
@@ -1 +1 @@
-Subproject commit 580e1f336f992de96443ea3d3ffcded202cf89c9
+Subproject commit ce7203b7153c8a4eb0cbcaaf9ab4eb9e6e78d3a9

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
