Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C3CA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C9423E564D
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:33:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC1CD3E55DE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ED8D600075
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:32:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29F161F8B4;
 Wed, 30 Sep 2026 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wwn8DEZJWH3od0E0WA46JMgWfwly7olXbx0xs3P83o=;
 b=VbEW3kxxm/D4mqAGw7NFlaPDJnaopCXFVmMojYEUJy2eimHK69m88iUX1G+nNHd1WN+M5w
 jrLgUi598NQUgYntgVp+L3yWuBZ+sYJe/SWaHxEChKvcaBl9IL8JQ0dLv8OkTs5bJi4m1f
 UJaa+87cSVsM/BM2CzyzGAIbI1kqdJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wwn8DEZJWH3od0E0WA46JMgWfwly7olXbx0xs3P83o=;
 b=BMg97dQod+LCXQPkkuJGPY2cAbCEW2mHtD3fQilseAT4xO019JGZHM3Gev5BAAE4e3Q4NP
 CO+4GCwu6e1sdQDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790757157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wwn8DEZJWH3od0E0WA46JMgWfwly7olXbx0xs3P83o=;
 b=TBiwXTAUXUeoCVcBX9fOy+MTwDqvUrPYutNx9vDA9iirslqwlH9SG9+Csfl0rmojnRMC6f
 l4HsnMYtZ/wALyimi+ztVDMbVms4mMXfSxlBnfC4X8aruYMx7Dh7PO5iO1UT7UPqHEIxIK
 AJjZGxPvH8zBtUHtwkPpoiHEyRAxhzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790757157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wwn8DEZJWH3od0E0WA46JMgWfwly7olXbx0xs3P83o=;
 b=OWuyQbiEy2q3nvGplQ4tB378hNincPHRzax4goDUbebU7jFfeI7tJ26wdxzJWH4zXO+tII
 clU6Aoq62sFzVWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E297613722;
 Wed, 30 Sep 2026 08:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 409TLSTJvGpCfQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 08:32:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 10:32:33 +0200
Message-Id: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACHJvGoC/yXMUQrCMBCE4auUfTaQphAbryJS1ji2KyVKtkpL6
 d0b9fGDmX8lRRYonaqVMj6i8kwF9aGiOHDqYeRWTM46b0NjzV3mrkdC5gmdLhp5HNU0Pjj2bd3
 yMVD5vjLK8Nc9X/7W9/WBOH1jtG07c6IPpHkAAAA=
X-Change-ID: 20260930-fix_generate_syscalls-3692a6818a79
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790757156; l=2549;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Mwy+PPf8ndMQF8RzNGqLxEPGzprymSVIXCI967WADPc=;
 b=evbvnEltF9C4a1xJnqF6cvO5X8vQQ5in2bwEN3bj9gbeP4fyMuOQGnO9pI3gaTrDxAx19/inA
 D8X7ribRxVyBW+GCcyXsY/wzKWJnau9kbv2tzo38BgYpbYe3eZyEZke
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix generate_arch.sh and update syscalls to
 v7.3-rc5
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

This series addresses the regressions observed when regenerating syscall
tables for Linux v7.3-rc5 [1].

The previous attempt to update syscall tables dropped legacy syscalls
such as _sysctl and timerfd, and overwrote 31-bit s390 definitions with
64-bit s390x values due to kernel changes introduced in v6.19.

Patch 1 fixes generate_arch.sh:
- Includes table entries marked sys_ni_syscall and seeds names from
  generic headers and existing tables to retain legacy definitions
  like _sysctl and timerfd.
- Detects whether the 31-bit ABI is actually exposed by s390 headers
  instead of blindly overwriting s390.in with 64-bit definitions.
- Avoids compiler flag leaks across architectures.
- Fails immediately if compilation fails for any supported architecture.

Patch 2 updates the architecture input tables to Linux v7.3-rc5 using the
fixed generator. This provides clone3 on SPARC (resolving tst_clone
failures reported by Anders [2]), uprobe on x86_64, and new generic
syscalls (listns, rseq_slice_yield, fchroot) while preserving existing
legacy entries.

[1] https://lore.kernel.org/ltp/20260929141659.2513510-1-pvorel@suse.cz/
[2] https://lore.kernel.org/ltp/20260929084253.3093742-1-anders.roxell@linaro.org/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      generate_arch.sh: Fix syscall extraction bugs
      syscalls: Update numbers to Linux v7.3-rc5

 include/lapi/syscalls/arc.in           |  3 ++
 include/lapi/syscalls/arm.in           |  4 ++
 include/lapi/syscalls/arm64.in         |  3 ++
 include/lapi/syscalls/generate_arch.sh | 99 +++++++++++++++++-----------------
 include/lapi/syscalls/i386.in          |  6 +++
 include/lapi/syscalls/loongarch64.in   |  3 ++
 include/lapi/syscalls/mips64.in        |  3 ++
 include/lapi/syscalls/mips64n32.in     |  3 ++
 include/lapi/syscalls/mipso32.in       |  7 ++-
 include/lapi/syscalls/parisc.in        |  4 ++
 include/lapi/syscalls/powerpc.in       |  7 +++
 include/lapi/syscalls/powerpc64.in     |  7 +++
 include/lapi/syscalls/s390x.in         |  4 ++
 include/lapi/syscalls/sh.in            |  4 ++
 include/lapi/syscalls/sparc.in         |  5 ++
 include/lapi/syscalls/sparc64.in       |  5 ++
 include/lapi/syscalls/x86_64.in        |  4 ++
 17 files changed, 119 insertions(+), 52 deletions(-)
---
base-commit: 1cbe713ca9d55bed7e4d52c6f2216ba3e2089346
change-id: 20260930-fix_generate_syscalls-3692a6818a79

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
