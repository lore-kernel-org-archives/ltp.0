Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE039C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 19:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 073223E5DE1
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 21:12:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9734A3E4A34
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 21:12:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBD6E10006D2
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 21:12:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E99275B7E;
 Mon,  6 Jul 2026 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783365138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OkwCfb+hYFU74vFZwJKvsdye6PXDrClxk+A8cX223Xs=;
 b=o0CRezkkBFnjy+ygmhMHYSs46+jcsO+dImnWXRK1QuC2Jzt7GOZOQbDf805yXxw7ywxp5v
 QNsHklB/OSQeEjpdG0QbfQ05pfYOCMyV2U3ADY1Uni52rmraTeMUXt7TmMcwEGfw4GOPhM
 LZ6bvy64AMpxoEhZ8EdRkaRC7P9hEVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783365138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OkwCfb+hYFU74vFZwJKvsdye6PXDrClxk+A8cX223Xs=;
 b=9WG1EoAe2iD6FEHZj1phGTdwCXqmENZl1CpjzvuxASl6uTdvI6VOG0Jor3P17CyL71wxHK
 0KrZShnV8eapvGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783365138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OkwCfb+hYFU74vFZwJKvsdye6PXDrClxk+A8cX223Xs=;
 b=o0CRezkkBFnjy+ygmhMHYSs46+jcsO+dImnWXRK1QuC2Jzt7GOZOQbDf805yXxw7ywxp5v
 QNsHklB/OSQeEjpdG0QbfQ05pfYOCMyV2U3ADY1Uni52rmraTeMUXt7TmMcwEGfw4GOPhM
 LZ6bvy64AMpxoEhZ8EdRkaRC7P9hEVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783365138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OkwCfb+hYFU74vFZwJKvsdye6PXDrClxk+A8cX223Xs=;
 b=9WG1EoAe2iD6FEHZj1phGTdwCXqmENZl1CpjzvuxASl6uTdvI6VOG0Jor3P17CyL71wxHK
 0KrZShnV8eapvGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF8B779AA;
 Mon,  6 Jul 2026 19:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IrQ5CBL+S2poEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jul 2026 19:12:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jul 2026 21:12:14 +0200
Message-Id: <20260706-cve-2026-46331-v2-0-d5e47a113a84@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA7+S2oC/3XMyw7CIBCF4VdpZu0YGC6mrnwP04WBwbKwGFCia
 Xh3afcuv5Ocf4XCOXKB87BC5hpLTEsHHQZw8225M0bfDSTIipOw6CrjBtRWKYla6TCOLpCzEvr
 pmTnEzx68Tt1zLK+Uv3u/ym39m6oSBTpjvDZBEHl5Ke/CR5ceMLXWfs6KrtCrAAAA
X-Change-ID: 20260706-cve-2026-46331-434f99cf2c61
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783365138; l=1709;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+XCpXN17HwrXVYwYs2P2zJ0pF27EfrLNqtikqOQjk60=;
 b=HOX6iBMi65mgZsh0YcUCzz8SuJtX2mzG9ZYgI404Madg9YBfGhWOKbcaeppZ/6ASKdwBVJFcD
 l5Wxq3nd0aOBZDjLIGcItxudtBxCYX5NROknBidNZ04zfVwIYXh9nlG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Reproducer for cve-2026-46331
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

tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_cveTzmFu2 as tmpdir (overlayfs filesystem)
tst_test.c:2047: TINFO: LTP version: 20260529-80-g0b891ea23
tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc5-virtme #9 SMP PREEMPT_DYNAMIC Mon Jul  6 14:50:05 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
cve-2026-46331.c:221: TFAIL: Page cache corrupted via act_pedit partial COW bypass

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- remove sleep()
- Link to v1: https://lore.kernel.org/20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com

---
Andrea Cervesato (2):
      lapi: Add pkt_sched.h and pkt_cls.h fallbacks
      cve: Add act_pedit page-cache corruption test

 include/lapi/pkt_cls.h         |  19 +++
 include/lapi/pkt_sched.h       |  19 +++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 272 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 312 insertions(+)
---
base-commit: 0b891ea23ed7315afa12df92fe12f1218a420bde
change-id: 20260706-cve-2026-46331-434f99cf2c61

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
