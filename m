Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CBACD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BCF83E48B9
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:46:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2020A3E483B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:46:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB78520090F
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:46:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0278C6BB7F;
 Mon,  1 Jun 2026 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780296371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vM+YEr0LAcmaWZkhWXDx6WEgs0YSH5u9TAQSE6oBj6E=;
 b=ZyOr6bu/mkjD0mZv5MTDMmc9Zqiu1CPdV+6GovLeki7fuklPP1N5r7C5zmMya+JY+alaEB
 +SI5yGQgaDuHS5xJT2dUH36U/qLnt59Ai+LoFE5DDr6C+S7KoQclnkizhWD2i/fDupxLma
 h3/qWhBeY2g+CJt6UfltggGf8UaU+3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780296371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vM+YEr0LAcmaWZkhWXDx6WEgs0YSH5u9TAQSE6oBj6E=;
 b=sdLmtWixQN5NlkP7lhcrX7ItKB5hdysFGMMNdnEs6SkRMabdB1UNPK96VKKKmMAJCvy0Gy
 3Q3A0K7H4a28bfCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZyOr6bu/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sdLmtWix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780296371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vM+YEr0LAcmaWZkhWXDx6WEgs0YSH5u9TAQSE6oBj6E=;
 b=ZyOr6bu/mkjD0mZv5MTDMmc9Zqiu1CPdV+6GovLeki7fuklPP1N5r7C5zmMya+JY+alaEB
 +SI5yGQgaDuHS5xJT2dUH36U/qLnt59Ai+LoFE5DDr6C+S7KoQclnkizhWD2i/fDupxLma
 h3/qWhBeY2g+CJt6UfltggGf8UaU+3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780296371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vM+YEr0LAcmaWZkhWXDx6WEgs0YSH5u9TAQSE6oBj6E=;
 b=sdLmtWixQN5NlkP7lhcrX7ItKB5hdysFGMMNdnEs6SkRMabdB1UNPK96VKKKmMAJCvy0Gy
 3Q3A0K7H4a28bfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D68DF779A7;
 Mon,  1 Jun 2026 06:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t5sHMrIqHWpTKwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 06:46:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 08:46:10 +0200
MIME-Version: 1.0
Message-Id: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
X-B4-Tracking: v=1; b=H4sIALEqHWoC/33NQQ7CIBCF4asY1mKABoquvIcxTQtTOomWBpBom
 t5d2o0ujMv/JfPNTCIEhEhOu5kEyBjRjyWq/Y6YoR0dULSliWBCMVkx6jChG32A5pampnUwJsp
 MbXhVd4pLRcrlFKDH56ZerqUHjMmH1/Yk83X972VOOQWtubDagjbyHB8RDsbfycpl8SEU478JU
 YgeZNsdtYLO6i9iWZY3vXw/LfgAAAA=
X-Change-ID: 20260530-gitignore_ltp_agent-0c7c137b6156
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780296370; l=1671;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=/in3U8bO8CY4kkvvG6gICAN7WVnRNbedGvlL7ES25IQ=;
 b=gZXCZXnKA7qG7xJrZ6jzPr8KqeIjJRuSZqknd2crNrKRJFlOHGopWFpW7jwSFV91OFClUt4LN
 kDVX8mtv6iTDDTn68tTTufOdjLj8wdVegpfhKM0yXo8wGADoFLV3/3s
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0278C6BB7F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] gitignore: ignore ltp-agent setup files
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

The ltp-agent tool injects a number of files and symlinks into the LTP
working directory at runtime (AGENTS.md, GEMINI.md, .agents, .claude,
and the agents/, linter/ and skills/ symlinks pointing at the agent
data). These are local helpers used by the agent and must never be
tracked or committed.

Directory entries for the injected symlinks are anchored to the
repository root (leading '/') and have no trailing slash, so they match
the ltp-agent symlinks without shadowing any unrelated subdirectory of
the same name.

Also ignore a few local agent working files: the /.pi/ session
directory and review-inline.txt scratch files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- add .pi and review file
- Link to v2: https://lore.kernel.org/r/20260601-gitignore_ltp_agent-v2-1-fe5ab986ebd8@suse.com

Changes in v2:
- fix files shadowing
- Link to v1: https://lore.kernel.org/r/20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com
---
 .gitignore | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.gitignore b/.gitignore
index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..891ffb7b77325a83daa99e6f04bdc51f95490655 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,3 +63,16 @@ compile_commands.json
 
 # added by scripts/checkpatch.pl
 .checkpatch-camelcase.*
+
+# ltp-agent setup
+AGENTS.md
+GEMINI.md
+.agents
+.claude
+/agents
+/linter
+/skills
+
+# agents files
+/.pi/
+review-inline.txt

---
base-commit: 5ccf816f5d0e6c0ec3d808be456dd9ffa2a7736d
change-id: 20260530-gitignore_ltp_agent-0c7c137b6156

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
