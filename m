Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190FCA5FC5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:00:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD9C53C84FD
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 19:00:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3208C3C99FC
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 18:59:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A1D2600737
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 18:59:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76EF421A2D;
 Wed, 30 Sep 2026 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790787576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pRGgwKyIaB3iSFHlRx0pTzQdcJE398zkorOpKoF+2QQ=;
 b=ju1yq6Zb1wzsRcLcvs3vltt9WjqzRhE8GEw8UdOnH30jqO04AWQYOiuPSACcjEDjTxZLSP
 9FAeXZxXAYCfdem3gE+fUdSp0UIWK3qiSPNKLLAnec2DDMl+JJfesKd1iUJRM6kYHJ5wx7
 HQOFFAGRxke6rG6SHo+DSovGsOn3two=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790787576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pRGgwKyIaB3iSFHlRx0pTzQdcJE398zkorOpKoF+2QQ=;
 b=RL4f++UwZo4TDRTxLq5IhutpH6Qh+NyZTloaJdqdf04iCVYRPfDQqT82NhhuwZs0wt63eV
 KCrrGmJuPeepjBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790787572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pRGgwKyIaB3iSFHlRx0pTzQdcJE398zkorOpKoF+2QQ=;
 b=qTUpadWQj9uNcmGErzY0VM4hmV95kUq5rCzajW1qnd9hSN/c/RhE4J2aKuY3zkRahfT+mQ
 /kqnt7s1KSYe0jAhzfX8Ch8ZVfXR+Ecu13VrZ9X3+TgYTQIBps+r9GmdC+LYLJcVZKpX1T
 kH05dm6IS6iCYVCbuUm8pWQCEPwhMTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790787572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pRGgwKyIaB3iSFHlRx0pTzQdcJE398zkorOpKoF+2QQ=;
 b=07g6tXfsJYh4PQoo7XFT5DIHSr5sWBmxl7z5Z9bDrRV4nhl3Eut2F15c8BwrpDwEXUTO/d
 iWq+1xVU/174/8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1605913AED;
 Wed, 30 Sep 2026 16:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Il4+OfM/vWo0GwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 16:59:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 18:59:30 +0200
Message-Id: <20260930-fix_generate_syscalls-v2-0-93c069622bcb@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPI/vWoC/4WNXQ6CMBCEr0L22RpaDD8+cQ9DyFoXqEFqutBIS
 O9uwQP4+GW+mdmAyRliuCYbOPKGjZ0iqFMCesCpJ2EekUGlKk+rLBWd+bQ9TeRwppZX1jiOLLK
 8UpiXssSigth9O4risXtrfszL/Ul63sd2YzA8W7cex17u3r8PL0WMtEbqLlnRoax5YTpr+4Imh
 PAFD58tWcsAAAA=
X-Change-ID: 20260930-fix_generate_syscalls-3692a6818a79
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790787571; l=2759;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+YoCXwAyx6zlLfLZ1x/HxFrmayRllUiJp97Z29yhHs8=;
 b=EGvEHiZezfQ43Evh90+FP38TJb2yzT90xIiVNAEJJEncT8MwhK+Z6pwR9mhauQ4UVmurRpwfh
 Clgi1641NrkCCUIzHXXl8XMGHTxWx1ILEO6y4Zd+iWrLn/QffJ+oEZ2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, s390.in:url, linux.it:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Fix generate_arch.sh and update syscalls to
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
Changes in v2:
- fixed as per Petr suggestions
- Link to v1: https://lore.kernel.org/20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      generate_arch.sh: Fix syscall extraction bugs
      syscalls: Update numbers to Linux v7.3-rc5

 include/lapi/syscalls/arc.in           |   3 +
 include/lapi/syscalls/arm.in           |   4 ++
 include/lapi/syscalls/arm64.in         |   3 +
 include/lapi/syscalls/generate_arch.sh | 103 +++++++++++++++++----------------
 include/lapi/syscalls/i386.in          |   6 ++
 include/lapi/syscalls/loongarch64.in   |   3 +
 include/lapi/syscalls/mips64.in        |   3 +
 include/lapi/syscalls/mips64n32.in     |   3 +
 include/lapi/syscalls/mipso32.in       |   7 ++-
 include/lapi/syscalls/parisc.in        |   4 ++
 include/lapi/syscalls/powerpc.in       |   7 +++
 include/lapi/syscalls/powerpc64.in     |   7 +++
 include/lapi/syscalls/s390x.in         |   4 ++
 include/lapi/syscalls/sh.in            |   4 ++
 include/lapi/syscalls/sparc.in         |   5 ++
 include/lapi/syscalls/sparc64.in       |   5 ++
 include/lapi/syscalls/x86_64.in        |   4 ++
 17 files changed, 123 insertions(+), 52 deletions(-)
---
base-commit: 95c8cf4fcb90df48e8096cb8da02046ec2ebc49b
change-id: 20260930-fix_generate_syscalls-3692a6818a79

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
