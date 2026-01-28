Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F5D35693
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 10:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 438D43CAFBB
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 11:49:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 173143CAE57
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 11:49:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84089200744
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 11:49:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C1285BCDF;
 Wed, 28 Jan 2026 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769597360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WWk80qBmqXHBwBhN1DgLCKZuiuVsnE3fO4NmSRI3AXE=;
 b=e1GhvEqBJYnKWapKH9Dx1kxKiW6/QnOUwG/PHFvfGXJ1CgPVaR/MDwpvTGYsEI4sq/+uA2
 qakRN4U8C5wMLB9/zs0u4qe4WDT56soj3ZqMP5VesXumauxUIlsNxx/oqog4hzMIpQpzKF
 9tKgY0CAB18YP88Jleo9RUrQwRsLEuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769597360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WWk80qBmqXHBwBhN1DgLCKZuiuVsnE3fO4NmSRI3AXE=;
 b=PSO0ccs5lLf0Nrq+U1LGaSB6+FX4W4icpjd5+ppTX6+G3rHtQGERlSKg4vYsl4XjeP1QjI
 CDQNPFUimpWWOgBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769597359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WWk80qBmqXHBwBhN1DgLCKZuiuVsnE3fO4NmSRI3AXE=;
 b=vMH4nkidUsyd8/nm5QuBob4IDZONmlR5cYF3h6dO4AXJu7trWt3GMfEu9c7duxsuzShf3t
 5wPeGEZFDFbqxA65e/5yYdRiAJSS9K/19JZCN8JOKSsTjyk7oM3rvOdPVAypoYObfnb6Wb
 EFAZ4X43JtVU8o1EUNihNKjjd0K7yiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769597359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WWk80qBmqXHBwBhN1DgLCKZuiuVsnE3fO4NmSRI3AXE=;
 b=jRl9QcdScbJfO82sH5UXs4MAMuaza8D9/zI2fTB8Vo5k62bME/3gLlpaJowrFsY84T0bez
 7qN5UYg3XPiB/9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E90313EA61;
 Wed, 28 Jan 2026 10:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NkspN67peWmhJQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 28 Jan 2026 10:49:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 28 Jan 2026 11:49:18 +0100
MIME-Version: 1.0
Message-Id: <20260128-kirk_v3-2-1-v1-1-9364f4bf919c@suse.com>
X-B4-Tracking: v=1; b=H4sIAK3peWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyML3ezMouz4MmNdI11D3USjlNTEtBSTNHMjQyWgjoKi1LTMCrBp0bG
 1tQD51ar0XQAAAA==
X-Change-ID: 20260128-kirk_v3-2-1-a2deafd4f721
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769597358; l=778;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=RyAKKGs/gZOTc63JEQxLIjeEljGITlwbDnc2d4VOEW8=;
 b=ccwXAqMsJ68sHmS1DatnCZJDINsNPDIwNAgXN+KHmJP/0pu7kUJP+2sk8WRm5X7+51H9Rsa6Q
 Pd3RKEE/NnJCPbx/jIZQNylHSsz7dah/VgQrpSlldG/BaJclOkBxxhB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: Update to v3.2.1
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

https://github.com/linux-test-project/kirk/releases/tag/v3.2.1
* ltp: correctly fetch LTPROOT by @acerv in #88

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index 2eff923cb5dd97184c21ae47bd9778eab3f184e8..6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit 2eff923cb5dd97184c21ae47bd9778eab3f184e8
+Subproject commit 6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929

---
base-commit: 3e8f1bec5503c6e0aa2a153fe106a31cbdbd275b
change-id: 20260128-kirk_v3-2-1-a2deafd4f721

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
