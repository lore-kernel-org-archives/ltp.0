Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36DD109C02F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:38:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A71903E525E
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:37:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB2B73E2FF2
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:37:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53A00200B7A
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:37:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CB205BCF0;
 Wed, 25 Mar 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774453060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uk+LAg9rNoNbacn2WKJnAV0ZMRoGQz7w5/wlIPX/+24=;
 b=LfVuYNSedXnUmTsmskIC2xhXfuBi+XqTKEYW1Y/cDQCOgwqPAkAhrEe9eYTWTcQ/cAi4OT
 fKPN55de5z4B3sV6HfGS0emwlk+ktqwzpI9QjWzv3ksoBZ2Hci9fagPZ09S0EJNyXa+UxV
 UOdcS53fanqNEE3WxhaOGsj2jGIOKNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774453060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uk+LAg9rNoNbacn2WKJnAV0ZMRoGQz7w5/wlIPX/+24=;
 b=LCh2W/YlKBQr+yZJXPRFZ4qhJOrO1ObmUs5HiPxwyxuJdlB6bRAXYLMZkh1D9YoMWLVKNJ
 Nt5WUKYpsEPs9nBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LfVuYNSe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="LCh2W/Yl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774453060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uk+LAg9rNoNbacn2WKJnAV0ZMRoGQz7w5/wlIPX/+24=;
 b=LfVuYNSedXnUmTsmskIC2xhXfuBi+XqTKEYW1Y/cDQCOgwqPAkAhrEe9eYTWTcQ/cAi4OT
 fKPN55de5z4B3sV6HfGS0emwlk+ktqwzpI9QjWzv3ksoBZ2Hci9fagPZ09S0EJNyXa+UxV
 UOdcS53fanqNEE3WxhaOGsj2jGIOKNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774453060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uk+LAg9rNoNbacn2WKJnAV0ZMRoGQz7w5/wlIPX/+24=;
 b=LCh2W/YlKBQr+yZJXPRFZ4qhJOrO1ObmUs5HiPxwyxuJdlB6bRAXYLMZkh1D9YoMWLVKNJ
 Nt5WUKYpsEPs9nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 518654448C;
 Wed, 25 Mar 2026 15:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tWk3EkQBxGm7EQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 15:37:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 16:37:39 +0100
MIME-Version: 1.0
Message-Id: <20260325-compile_flags_gitignore-v3-1-2ad84b58ea47@suse.com>
X-B4-Tracking: v=1; b=H4sIAEIBxGkC/43NSw6CMBCA4auQrq2hJZTGlfcwhvQxLZMgJS02G
 sLdLazc6fKfzHyzkgQRIZFLtZIIGROGqURzqogZ1OSBoi1NeM1F3fCWmvCYcYTejcqn3uOCfgo
 RqGHcSidacNyScj1HcPg65Nu99IBpCfF9PMpsn/42M6OM6tpC0wEoY+Q1PROcyzrZycz/ZHhhZ
 Keltkpb0YkvZtu2D/BcUf8EAQAA
X-Change-ID: 20260325-compile_flags_gitignore-c12d8f65ef2d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774453060; l=1222;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=5yjIEiej+eJSgtFPjKNm8qtDGRcV2Jin62UEoSxIUyk=;
 b=qO10dnkZ0AgW5ZLBFSKT3sW9QMc4MI2Ys0r6c+V+vo+KiocCMYvn9YXDKYFZCizp8q3/DqVhz
 lTCdZyrcobnBr5SM3LjCrcMVewvtKGV3iHn9gD6SZfmFzLJAXrSerkv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6CB205BCF0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add clangd specific files to gitignore
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

Add rule to ignore clangd LSP configuration from local repository.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Clangd is extensively used by IDEs and generic LSP wrappers to setup
clangd configuration. This patch removes it from gitignore so we can
safely avoid it gets into the patch-set when it's sent.
---
Changes in v3:
- make compile_commands.json and compile_flags.txt ignored everywhere
- Link to v2: https://lore.kernel.org/r/20260325-compile_flags_gitignore-v2-1-87b8bdabd676@suse.com

Changes in v2:
- add compile_commands.json
- Link to v1: https://lore.kernel.org/r/20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 24f4a4ea834e0b919e640e879fe5e5b5d7aec466..3fdfeaba0333990c607e7847e4f997192d710394 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,3 +60,6 @@ patches/
 logfile.*
 
 /utils/benchmark/ebizzy-0.3/ebizzy
+
+compile_flags.txt
+compile_commands.json

---
base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
change-id: 20260325-compile_flags_gitignore-c12d8f65ef2d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
