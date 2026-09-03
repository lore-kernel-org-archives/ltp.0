Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA588C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:04:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D41603EAD96
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:04:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AE673EAD42
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F66A1A0107B
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E9C51FE40;
 Thu,  3 Sep 2026 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C87ZIZnM2WRt9ALhzDkICCc4+AXtkZJF2pAb/DJMX7Y=;
 b=ISXlzdswXXzuVcbk7uunQgB7q7wQemRoi6yi8ywksPYck87qYOzHXEPfKdzbJUDRlujUcd
 tghqAR2rvwEFfCEXwFuWZt+hnRPyUr42oUBlOyPGVR646337In4IU9BnBzyZ9g1UAy8tTd
 Hpb0Lqlv/vuy/4Bau12hBC7nwRAmV6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C87ZIZnM2WRt9ALhzDkICCc4+AXtkZJF2pAb/DJMX7Y=;
 b=3h0ZWxBYMWJ6nvr5onFCk5MJr4aDDQvLIYqkRrUTrbot+4Mop4/QOAuTfnqGpO+Am5eIL1
 LWMRZ8yAFaCVJoCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dhXhatKx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H8EWk3B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C87ZIZnM2WRt9ALhzDkICCc4+AXtkZJF2pAb/DJMX7Y=;
 b=dhXhatKxicd20D7/5wPN/dOVkhD5Kec9uRhYBMC7CkUOD2YhKbGKmaNHyd4cYsHTYN6WuP
 VInlq83b7HJ9D4saPor2gTOGw5mS5B4Knz6Xx40YkG+UfNq43h10CIn/JnGCT9Su0ejrxf
 jTr4orL1HrfRgterrLLhrv6TDoOVlis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C87ZIZnM2WRt9ALhzDkICCc4+AXtkZJF2pAb/DJMX7Y=;
 b=H8EWk3B9MC5WhdDNpafakbSulqQoECeSVCv5Iw15bFo2XhlDf7tAdcGx9DN+lrBIZ+PeiE
 cML8DM4hoz0uFPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36CC5136E6;
 Thu,  3 Sep 2026 13:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMHFCkxwmWojPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 13:04:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 15:04:10 +0200
Message-Id: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEpwmWoC/43NQQrCMBQE0KtI1lb6kzaNrryHSEmTr0awKfkal
 dK7m9ZNEUSXAzNvekYYHBLbLHoWMDpyvk2hWC6YOen2iJmzKTOec5krXmV0151va+vI6GBr4yM
 GnWqiUBKsFAdTliytu4AH95jk3f6d6dac0VxHbmycHF19eE7XEcbe75cIWZ5JIRrTABhQsKUb4
 cr4CxtPIp8z6jvDE4NlqZW02lZ8/cGIPxmRGBByzQsNuhL5jBmG4QWjnzhkXQEAAA==
X-Change-ID: 20260827-swapon_discard_coverage-34861d63fc55
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788440652; l=2106;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nATGxlbka6hh9dsesV/NS6C/OxoIkkaClc7U2LGPgz8=;
 b=jveIkAZbtcA/2FchZZfSFvrjY9YGdELmtPRohpK5rj3EStC1axabEGAwjT0mV2QFYCAO8Bgj3
 GYYgtT4jGSkAlY6PFIjJmeb533APsuPlWIWdTPQpPv1QryK/+JThDDC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 7E9C51FE40
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,linux.it:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] Increase coverage for swapon syscall
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

Complete the EINVAL coverage on invalid input data and create a new test
to verify discarding pages functionalities.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- replaced the manual /proc/swaps check with .needs_kconfigs = "CONFIG_SWAP=y"
- added .needs_cmds = "mkswap" to make sure that the binary exists
- switched from raw tst_syscall to standard swapon() and swapoff()
- used TST_EXP_PASS() to check the swapon() call
- truncated the backing file before checking FALLOC_FL_PUNCH_HOLE support
- added SAFE_FSYNC() before mkswap to flush data to disk
- changed TTERRNO to TERRNO for swapoff() errors
- removed redundant static flag resets in cleanup()
- added .skip_filesystems to skip filesystems that do not support punch hole
- Link to v3: https://lore.kernel.org/20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com

Changes in v3:
- better description for fallbacks
- swapon02: make sure we swapoff() if swapon() accidentally pass
- Link to v2: https://lore.kernel.org/20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com

Changes in v2:
- ensure buffer is flushed after discard using fsync()
- add messages to show what test cases we are running
- Link to v1: https://lore.kernel.org/20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (3):
      tse_swap: Add fallback definitions for swapon
      swapon04: Add test for discard flags
      swapon02: Add test cases for invalid swapflags

 include/tse_swap.h                          |  16 +++
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/swapon/.gitignore |   1 +
 testcases/kernel/syscalls/swapon/swapon02.c |  59 ++++++--
 testcases/kernel/syscalls/swapon/swapon04.c | 208 ++++++++++++++++++++++++++++
 5 files changed, 270 insertions(+), 15 deletions(-)
---
base-commit: 12724413534a6d4160ff9694ba6f09daa4ccb6bd
change-id: 20260827-swapon_discard_coverage-34861d63fc55

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
