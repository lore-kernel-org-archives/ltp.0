Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1E0C79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096CF3E72F1
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:05:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F8D3E733C
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:05:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63116200D10
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:04:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D970E21AAB;
 Wed,  9 Sep 2026 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XX7PkAdkrA/U1D5RKzp2AlC2d4soNRdoN8y9T9Sj2N4=;
 b=Os6rEWxY51KHsdd8BFCMhDzx8REnj4co4GM/083DRWp1Rn1jVrmzXdaeqSxtBuJkyOXKVu
 WG0IpHbB4rYdr04CS+ae7wbxQsmmrxvmlukx0LWMMFakRV8A4Lz15q9MQl+ysJhu1n1erI
 B7WUTmlZJrkeQi7MYdTfCn96tccMvHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XX7PkAdkrA/U1D5RKzp2AlC2d4soNRdoN8y9T9Sj2N4=;
 b=Gf2D4wQJ5W/AGju9x68/+4CFvr6nPCtkzMMvlqBcoJy3irdGXOxrE2BQhxFOVGZi+1aSiW
 XgMR2VS50KzjAwAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qomnyvok;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GRH1tnsv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788948289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XX7PkAdkrA/U1D5RKzp2AlC2d4soNRdoN8y9T9Sj2N4=;
 b=QomnyvokQk/OaMvzZmrmw6v9zbW22wK9b1XmThCODO5xdYKh3p14ohgSJpNyXVYzJCdMHj
 HOayIhra+ZCNfOsUNNhzTl8+avb8gkXAjndfxmtqt+CftVObFhLmWLmQWYDc4cHbWS0eQQ
 5WtgZW4MRByC6+gaxgGgdKA02LKSJCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788948289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XX7PkAdkrA/U1D5RKzp2AlC2d4soNRdoN8y9T9Sj2N4=;
 b=GRH1tnsvm9AmacMsqQff7Ypia3MFTO0nLfsBnOPDHd4zjW8R2dCdiid8UWbIqTpGs78CLw
 pOJf8eOlP/huP4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39D471352C;
 Wed,  9 Sep 2026 10:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +yNqDEEvoWpSFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Sep 2026 10:04:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Sep 2026 12:04:47 +0200
Message-Id: <20260909-coredump-v9-0-6b0ee752f57e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD8voWoC/3XPTU7DMBAF4KtUXmPkGf+z4h6IhTMZ0yC1qeImA
 lW5O05ZYEV0+aT3PY9vovA0cBEvh5uYeBnKMJ5riE8HQcd0/mA59DULVOhUQCVpnLifTxeJmMl
 r6HpWQdT6ZeI8fN2n3t5/c5m7T6br5rfGcSjXcfq+v7XA1vtndgEJ0hNbcEoT5+61zIWfaTyJb
 XXB1pnGYXUGDYZE2SK4ndOPnK7OGYx9ct54CDtn/lxU2DhTnc4WgBNQdGnnbOt042x1yCm4nDC
 C8jvnWtfe6aSSXWAdjSdyZv8//8j56pLGzlOCRLy/M7QuNC5UZyPk6JQy1ujGrev6A9NslJc5A
 gAA
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788948289; l=3447;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XB1sG/vwjy1J1nf13aRcqPzHcjdz1edXyqnf6kJf0eo=;
 b=e2AUGb+a303rnjjZ1wyFtNxNRGSpNlvnBepVpr/XIxas70NqRVHuIGpy2dX8Ms253IGp/t1Tp
 TTumt8Fm6d8BO7ktXWj8qHehU2fB/1jwV6DO/XQ/VCvvcSfxHRBoo50
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: D970E21AAB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,linux.it:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/3] coredump testing suite
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

Add a simple coredump01 test that simulate a coredump and verify that it
actually works. This is a small coverage that is missing inside LTP
testing suite.

Add a coredump02 test that verifies ELF data after a coredump.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v9:
- add SAFE_FILE_VPRINTF() helper in the test library
- factor out shared test logic into coredump_common.h
- use SAFE_FILE_VPRINTF() in set_pattern() to avoid intermediate buffers
- use struct tcase array for test case dispatch in coredump01
- return early in coredump01 if core file is missing before parsing ELF
- document root requirement in coredump02 description
- assert exactly one PT_NOTE segment in coredump02
- validate file bounds for PT_LOAD segments in coredump02
- use TST_EXP_EQ_STRN() to compare executable name in coredump02
- copy unaligned note descriptors to local stack structs to ensure 8-byte alignment
- Link to v8: https://lore.kernel.org/20260908-coredump-v8-0-591f96004543@suse.com

Changes in v8:
- check PT_LOAD data
- Link to v7: https://lore.kernel.org/20260904-coredump-v7-0-a32b7ca1acea@suse.com

Changes in v7:
- define a common header for the testing suite
- update commit message for coredump02
- Link to v6: https://lore.kernel.org/20260904-coredump-v6-0-b8e3947cc646@suse.com

Changes in v6:
- coredump01 check Elf
- add coredump02 test for Elf validation
- Link to v5: https://lore.kernel.org/20260903-coredump-v5-1-2ea86fa29107@suse.com

Changes in v5:
- resolve path from root for helper
- Link to v4: https://lore.kernel.org/20260902-coredump-v4-1-3f511ea1c96a@suse.com

Changes in v4:
- read back core_pattern after writing and abort with TBROK on mismatch
- read CONFIG_STATIC_USERMODEHELPER once in setup() and cache the result
- remove namespace visibility scaffolding and skip logic from verify_pipe_pattern()
- resolve helper path with tst_get_path() instead of /proc/self/exe readlink
- Link to v3: https://lore.kernel.org/20260824-coredump-v3-1-6429da674718@suse.com

Changes in v3:
- check for CONFIG_COREDUMP=y
- Link to v2: https://lore.kernel.org/20260824-coredump-v2-1-42428acf5216@suse.com

Changes in v2:
- fix CI agent spotted errors
- Link to v1: https://lore.kernel.org/20260820-coredump-v1-1-7ce51603cefb@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (3):
      lib: Add SAFE_FILE_VPRINTF()
      coredump01: New core_pattern specifiers test
      coredump02: Verify ELF structure and notes

 include/safe_file_ops_fn.h                    |   6 +
 include/tst_safe_file_ops.h                   |   4 +
 lib/safe_file_ops.c                           |   2 +-
 runtest/kernel_misc                           |   2 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   3 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 162 +++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++
 testcases/kernel/coredump/coredump02.c        | 196 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  52 +++++++
 11 files changed, 507 insertions(+), 1 deletion(-)
---
base-commit: 043bdc49af410f55ece6f61abcdaba7d9580f86a
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
