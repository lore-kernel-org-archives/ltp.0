Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC12C5DF9D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:23:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 016B03D0EEC
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:23:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88F13C0E10
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4C456002E6
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E0FC1F837;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsLgK6o1LLYqWyDnEsXKAh9p9bYomHGEta2cRNMZ+uc=;
 b=JfAoCow7xblQaAD8ZsWg3fzuehRxbhrpSzxrSI47zhEX+k6cowE/iTNtC4jySF4SqlEEoE
 uFEMpgKZpHnZMt2uO2Xbu1xLB+FkgwGIMmmqe5UTykHgrdas2beBVrMCrzENZgYWPYoJF3
 wJerSGw+6CMW5LKkqUyusspj1OrTevM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsLgK6o1LLYqWyDnEsXKAh9p9bYomHGEta2cRNMZ+uc=;
 b=ja4U5SKo5z4cIWXvaPjXtY9TUBmHjtjifXy5Micmi+rjKKMBi2ufS/u2m6z+iJmDurYxZd
 MP+/GkYLh/U2AnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787818954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsLgK6o1LLYqWyDnEsXKAh9p9bYomHGEta2cRNMZ+uc=;
 b=uhwLW2gfBhYcfCFuzTFaS+vBAcGld/TWttgzmyYVT82V0GZMI+LaYQKTspclbLOx46M+Bj
 T7QevBjcW3c+P2WooiESXgWWQXxiMGZTcY8yoq6FpjGxuSmDo4b2Aj3gjqhlIOlh1zN+GO
 +E+IDYORAIMprt1PNQ2fAqt5sGFGrxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787818954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VsLgK6o1LLYqWyDnEsXKAh9p9bYomHGEta2cRNMZ+uc=;
 b=v6DfkYZMAFm0MD45GwVQWAGOTDnTAJfIwVFBBxB7xoWFW9xcLm6E6IXSWcbTXpbJTAQKg+
 mtXh9JvGeck8mkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4206B1352C;
 Thu, 27 Aug 2026 08:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XktdDsrzj2oQNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 08:22:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 10:22:32 +0200
Message-Id: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMjzj2oC/4XP3WoCMRAF4FeRXDcymfytXvkepcgmO6kBu5FkD
 Yrsuxu96SLYXp6B+c7MjRXKkQrbrm4sU40lprEF/bFi/tCP38Tj0DJDQAMWgfs0VsrTPvTHY/L
 9RPtyjhPxDkEKDC5IjaxtnzKFeHnKn18tH2KZUr4+i6p4TP83q+DANfTUaa+NB7kr50Jrn37Yg
 6z4y3Rg3zPYGGmNCNZZ5UR4YeSCQfOekY0R2BkaCNRGDi+MWjJ/XKMa451Qxm1IG1w+Nc/zHXI
 fw7iSAQAA
X-Change-ID: 20260720-convert_fallocate_suite-820312fbf352
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787818954; l=1607;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=BORvsoDDZPZ+21Ds5naZBScvr694CXJ68SZfPx3SfAY=;
 b=BPjGd1yBTIHBKXyRDce35IBBvs+Ef/hs5UGAixa9mMp4yomGmVWv+jITv3evU2hnFsQY3aHOq
 o8q3rRRT1sBBxvFCmjU1eaH2HAzDq75pGY1m8GH23XdSOLP8Ckl47oM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linux.it:email,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Convert fallocate testing suite
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

Testing a new multi-agent converter that does a deep analysis on the
code, evaluate if it needs to be converted line by line or it only needs
a complete rewrite, then it spawn an agent for writing the test, one for
reviewing and it iterates until test is out of issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- fallocate01: handle ENOSYS in setup()
- Link to v4: https://lore.kernel.org/20260827-convert_fallocate_suite-v4-0-cb146b9e5623@suse.com

Changes in v4:
- fallocate01: make sure we handle ENOTSUPP
- Link to v3: https://lore.kernel.org/20260826-convert_fallocate_suite-v3-0-1286ede0493d@suse.com

Changes in v3:
- fallocate01: all filesystems, check for ENOSYS/ENOTSUPP, use TST_EXP_*
- fallocate02: check for ENOSYS/ENOTSUPP
- Link to v2: https://lore.kernel.org/20260807-convert_fallocate_suite-v2-0-3761f7b74b1f@suse.com

Changes in v2:
- fix fname size
- simplify commit messages
- Link to v1: https://lore.kernel.org/20260720-convert_fallocate_suite-v1-0-50ae85c56c03@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      fallocate01: Convert to new API
      fallocate02: Convert to new API

 testcases/kernel/syscalls/fallocate/fallocate01.c | 344 +++++++---------------
 testcases/kernel/syscalls/fallocate/fallocate02.c | 192 ++++--------
 2 files changed, 162 insertions(+), 374 deletions(-)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260720-convert_fallocate_suite-820312fbf352

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
