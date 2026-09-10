Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE62C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C123E72CF
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:27:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1373C18A4
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:27:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1C0DC600F1C
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:27:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC8B321C75;
 Thu, 10 Sep 2026 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789046839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHlQxMfJcqiq6Yh0NyVDKnQtIl3qkcBJIwiKGErcKXw=;
 b=QeIRkH1DeZEFBlA2EaFje0VLpupMxUWHxB+sc62Fi5elQESIy54r2c2kXlTzzEP+heQcDP
 AfudB7jbnXaC99SsxhAvLZGFqfd4lxyOEJSDvWNPRSAVrQL/2U651NFBxVTxN9Jcq39J+S
 klM5xzcfGlSrNpKEQeqPnesUcqwdpx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789046839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHlQxMfJcqiq6Yh0NyVDKnQtIl3qkcBJIwiKGErcKXw=;
 b=6+OOffQbN74apoGC78zrSwudfBBzuz2cwbMdfzuFBYwfTYQaN4Xioa9oVHCbkTMP4p86US
 KiIjwIeXVfckgMBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789046835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHlQxMfJcqiq6Yh0NyVDKnQtIl3qkcBJIwiKGErcKXw=;
 b=0eETCWP28DQZ3IdFbFM93Lr21nVTnUUdidAuwNKJAOioLRn1JlpuCydqERKnl/K+VsMFbl
 meLiPBIl4Z4SkUTYhZSaRaEtZ35WAv8BvhL+2/TvIXUqs4mzUn+WMCn8AkOjAFiX+Xo2hB
 IMrhp896ic6SUO1KQvpUG6H/v0ol8pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789046835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHlQxMfJcqiq6Yh0NyVDKnQtIl3qkcBJIwiKGErcKXw=;
 b=J8z9b7bwvQYfLXqCkdO2LC+e6tv/x80IXOzdLUL2NDL2vGdvlPrt7HpzWUxAihiuIeUeV0
 SyPVr7Bq9MCZiTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 604B41326D;
 Thu, 10 Sep 2026 13:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id miBIFjOwompBDwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 13:27:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 15:27:10 +0200
Message-Id: <20260910-coredump-v11-0-e87e2100dbe3@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC6womoC/3XQTU7DMBAF4KtUXmPkGf+z4h6IhTMZ0yC1qeI2A
 lW9O05ZYFl0Odb7nse+isLLxEW87K5i4XUq03ysA8DTTtA+HT9YTmM9EKjQqYBK0rzweDmcJGI
 mr2EYWQVR46eF8/R173p7/53LZfhkOm9+S+yncp6X7/tlK2y5f2pXkCA9sQWnNHEeXsul8DPNB
 7G1rtg60ziszqDBkChbBNc5/cjp6pzBOCbnjYfQOfPnosLGmep0tgCcgKJLnbOt042z1SGn4HL
 CCMp3zrWu3dNJJYfAOhpP5Ez/Pv/I+eqSxsFTgkTc7xlaFxoXqrMRcnRKGWt052LrYuNidW5Qz
 N5itp47B+oRBFWlSmi9Q0rk25+53W4/mV9thKwCAAA=
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789046835; l=3871;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Z+PZULWeMCASiBxYqsvVmi1xP7mHwuDEjv8NV0PVHq4=;
 b=97ZgQ+b6D4CaP1rEzSMRqjVtcF2bhOriaplc1fIb1woXovPDiBVhv9QbxfIKTYUpa1zRD47RP
 9G9T8SbifZxBmgT/QpDYcslQoZJLzl8YvkzZCF5gsVLvryyyEeoSRvI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/3] coredump testing suite
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
Changes in v11:
- cast ELF description
- Link to v10: https://lore.kernel.org/20260909-coredump-v10-0-0a25762cac77@suse.com

Changes in v10:
- add kernel-doc documentation for SAFE_FILE_VPRINTF()
- fix checkpatch formatting warnings in SAFE_FILE_VPRINTF() headers
- use TST_EXP_EQ_STR() to compare executable name in coredump02
- Link to v9: https://lore.kernel.org/20260909-coredump-v9-0-6b0ee752f57e@suse.com

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
 include/tst_safe_file_ops.h                   |  14 ++
 lib/safe_file_ops.c                           |   2 +-
 runtest/kernel_misc                           |   2 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   3 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 162 ++++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++
 testcases/kernel/coredump/coredump02.c        | 191 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  52 +++++++
 11 files changed, 512 insertions(+), 1 deletion(-)
---
base-commit: 352f9134942933efcfa608b87ae814db603b3228
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
