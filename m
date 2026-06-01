Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D9CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441A93E5262
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:42:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C367E3E4831
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:42:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA70F1400BFE
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:42:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E79E76B42C;
 Mon,  1 Jun 2026 06:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780296123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EKv7+jKpE6w7LC1xBivhsGE8bTHK/lSv5RIyeOXRi8Q=;
 b=x2b8mW7hSt39hsjQcPq6d2N6ypVSM2eBjM90KZgAb44REWvGEJ/RDYr4nFPmTzOTrPuRHn
 ef67iMNyZO44neMhrjQL36w+ZCBgbO8VOhjnr2U7zkK0VomRpzNAsjVVzkqj49qMKFxqll
 RzHtvwpk220K1ZHM8qSlD2gWkEqHHaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780296123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EKv7+jKpE6w7LC1xBivhsGE8bTHK/lSv5RIyeOXRi8Q=;
 b=GuDzjEHycg2RNHrBF/rcsHcx38Msc/5vkRu6PTwPE5f7HNEdmhNvnkGX7DmUwcxTR3mJlH
 QYCZIVTi5GcvSlBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TrrS/G9f";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qXKZuqzC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780296121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EKv7+jKpE6w7LC1xBivhsGE8bTHK/lSv5RIyeOXRi8Q=;
 b=TrrS/G9fL+sh1lusCgZpwKyF433+sDpEGBfOr0WguZVAofJbux3UkJVph4ryM7YzJms7u7
 a3x84KuZKzpvn91STpTr/ql1Y2GCFGntXY9zI4SVIHD/qeHfoItAhH28PRSkkle+5V8+Ne
 1gE8qJrQeCZpSPRHMGucMl4ae78LZFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780296121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EKv7+jKpE6w7LC1xBivhsGE8bTHK/lSv5RIyeOXRi8Q=;
 b=qXKZuqzC83fxlLb7EjbEe+DrSvVsf575JBIUv/WilZCC5mtIQdeoC4ohvOv0Td0UYBuqzU
 W3g3kV/75Vy998AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5400779A7;
 Mon,  1 Jun 2026 06:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jDWXLbkpHWoeJwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 06:42:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 08:42:01 +0200
MIME-Version: 1.0
Message-Id: <20260601-gitignore_ltp_agent-v2-1-fe5ab986ebd8@suse.com>
X-B4-Tracking: v=1; b=H4sIALgpHWoC/32NQQrDIBBFrxJmXYsaTKSr3iOEkJqpGWg1qJWW4
 N1rc4Au34P//g4RA2GES7NDwEyRvKsgTw2YdXYWGS2VQXLZcdVyZimRdT7g9EjbNFt0iXHTG9H
 2t06oDupyC3in91EdxsorxeTD5zjJ4mf/97JggqHWQi56QW3UNb4ino1/wlhK+QLbpBqHtQAAA
 A==
X-Change-ID: 20260530-gitignore_ltp_agent-0c7c137b6156
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780296121; l=1349;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=VkZ4iZSBgaDpCDW8U6gsbwVtgUQuRwHpea7R27Kf15k=;
 b=mmHv20HQOUi90HE43n4oYi4mo8fYx+ap0O+NKzJRfpimIZMKEj3sDc2rx+3qqufjhS4wdTzFU
 PeWmcr+hI3dCfhfWVtfpq1oKlg0SXUre7CDhzre8uOVD/HgkHi/MaOm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E79E76B42C
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] gitignore: ignore ltp-agent setup files
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

Directory entries are anchored to the repository root (leading '/') so
they only match the ltp-agent-injected paths and cannot accidentally
shadow any unrelated subdirectory with the same name in the future.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- fix files shadowing
- Link to v1: https://lore.kernel.org/r/20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com
---
 .gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitignore b/.gitignore
index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..d68769451103e22c3e3a4d6c80f824e2412f0ae4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,3 +63,12 @@ compile_commands.json
 
 # added by scripts/checkpatch.pl
 .checkpatch-camelcase.*
+
+# ltp-agent setup
+AGENTS.md
+GEMINI.md
+.agents
+.claude
+/agents/
+/linter/
+/skills/

---
base-commit: 5ccf816f5d0e6c0ec3d808be456dd9ffa2a7736d
change-id: 20260530-gitignore_ltp_agent-0c7c137b6156

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
