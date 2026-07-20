Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C37C4452A
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:32:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79C883E76A5
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF84D3E57AE
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:31:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F32DA1A005E9
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:31:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FBED3E23;
 Mon, 20 Jul 2026 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fLxHSYjLR3z/UQdKaOL1l6c0Xe/Fe+Ra9xKUe/3hWV4=;
 b=E0oCPCBQertSccITQV/CdxPl7J33bwsr5ChpZebSJ84n44bRKno/LiRGmYLoiWg+tqf3PA
 97KUCvuzVRVOCdCGOU4/9ylsM8u+S8T5XB4g5Mo1h7hiyFrXYKJrhlu0syp7AEr18/+smK
 pfK5vZlUW4qNOVCoEtdD/Pj4I71thhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fLxHSYjLR3z/UQdKaOL1l6c0Xe/Fe+Ra9xKUe/3hWV4=;
 b=O7kn/MwFNnxoSbVX4Cc97TkHgHKj0kz+okpnKeGNXxXTsww3yh0Ib4JqgckjssgSGFggIe
 OfRkmSOGmKU9+CAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E0oCPCBQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="O7kn/MwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fLxHSYjLR3z/UQdKaOL1l6c0Xe/Fe+Ra9xKUe/3hWV4=;
 b=E0oCPCBQertSccITQV/CdxPl7J33bwsr5ChpZebSJ84n44bRKno/LiRGmYLoiWg+tqf3PA
 97KUCvuzVRVOCdCGOU4/9ylsM8u+S8T5XB4g5Mo1h7hiyFrXYKJrhlu0syp7AEr18/+smK
 pfK5vZlUW4qNOVCoEtdD/Pj4I71thhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fLxHSYjLR3z/UQdKaOL1l6c0Xe/Fe+Ra9xKUe/3hWV4=;
 b=O7kn/MwFNnxoSbVX4Cc97TkHgHKj0kz+okpnKeGNXxXTsww3yh0Ib4JqgckjssgSGFggIe
 OfRkmSOGmKU9+CAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49508779AA;
 Mon, 20 Jul 2026 14:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ddEpDVgxXmrEUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Jul 2026 14:31:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 16:31:50 +0200
Message-Id: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFYxXmoC/43NQQ7CIBAF0Ks0rMWUAQq48h7GNNhOLQvBQCWap
 neXdtWVcfl/5r+ZScLoMJFTNZOI2SUXfAn8UJFutP6O1PUlE6ihqRVTdHDvtstI14KKhnPWog/
 oJ2puBqTorVQaSdk/I5bjzb5cSx5dmkL8bK8yW9t/1Mwoo1oKkKjZMCh7Tq+Exy48yIpm2EFQ/
 4KgQNxIzQwqYZTeQcuyfAHZzwdNCgEAAA==
X-Change-ID: 20260717-fix_cve-2026-46331_enoent-9b9254da578e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784557912; l=1486;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=4Eoq08e5JwfMOG2KJXWiuIqjQgyT5qZJhdKipz1q3Bo=;
 b=t2l29Bd5OkxnIbIZW70PH4s9rMz8r7ex6sjP4uVPD1FHXrj/BWPvHtMYUnYjCOxOMctdJZ1Zz
 aYjyeQNCgZxAckwi5wbCfd2g2bM+KcKWF7hfGTSQuKTzn08mngQtm39
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6FBED3E23
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Fix cve-2026-46331 producing ENOENT
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

tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1872: TINFO: Overall timeout per run is 0h 02m 00s
cve-2026-46331.c:200: TBROK: Failed to modify traffic filter: ENOENT

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- commit adding modules to tst_kconfig
- Link to v2: https://lore.kernel.org/20260720-fix_cve-2026-46331_enoent-v2-1-395819e74978@suse.com

Changes in v2:
- explain why we use root
- use tst_modprobe()
- add more CONFIG_* requirements
- Link to v1: https://lore.kernel.org/20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com

---
Andrea Cervesato (2):
      tst_kconfig: add module mappings for ingress/matchall/pedit
      cve-2026-46331: fix intermittent ENOENT failure

 lib/tst_kconfig.c              |  3 +++
 testcases/cve/cve-2026-46331.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)
---
base-commit: 51a74d8821a9712d122d2d435581a9bbc277708a
change-id: 20260717-fix_cve-2026-46331_enoent-9b9254da578e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
