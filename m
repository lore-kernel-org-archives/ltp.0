Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D13C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:16:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2613E2C43
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 10:16:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35FB3E2643
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:15:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C0B560091D
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 10:15:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2E5B804ED;
 Fri,  7 Aug 2026 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786090540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W3Y/r7Gfwt9hPUBcXVcpPUQMB2XA0mIfI+uEDBs7UA0=;
 b=I2e+0bzZgCGdWHU9fvUKWYay82bAs5rY4EeTwUBlSBxfaMVZXTIXAPVYyZ8VdutpbJiomP
 aPT4HtxBPNgLdB04Gn/886n6P6ZXgDZuUqNsw+Qw9BnhG7A8GkAzw1QocZtPkfSVX3+g6i
 f1E+OqyKM7/I4P4Jbw2kZ5cSQ4L63CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786090540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W3Y/r7Gfwt9hPUBcXVcpPUQMB2XA0mIfI+uEDBs7UA0=;
 b=h6KiI6O8citCGThp7oL5Z24aqtFfVPlVKB//B/ILcneZyWuaDudUsVMAvpiU7vjLRBXAUn
 kjtH0a6SzE+1y8DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786090536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W3Y/r7Gfwt9hPUBcXVcpPUQMB2XA0mIfI+uEDBs7UA0=;
 b=ijcZ2zDaCp6hym17rShc6y1O1Ut+g8jag3zKn99YEU1+ehzh/q7GPsGou4XJ83sXK1R10F
 RfHqW6l9sGM7P5zL4LvgUiWPxNlv+6pdNKwKoRLrjqVW4VP1Z3iRmAjZtdfW8wZJncVa1Q
 N0iaeu3uV8UaBB3cqbY7RI183AIxPQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786090536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W3Y/r7Gfwt9hPUBcXVcpPUQMB2XA0mIfI+uEDBs7UA0=;
 b=rbzwoUCT1kMvmENn4A3KZ4GxqucNNFTX9eBP7wvW/2Js5VHjxivzqAd1o5dp394T1rT8Mr
 b/UIucquGPGU2dCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FC3A779B6;
 Fri,  7 Aug 2026 08:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 54OhIyiUdWrpPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 08:15:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 10:15:34 +0200
Message-Id: <20260807-convert_fallocate_suite-v2-0-3761f7b74b1f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACaUdWoC/4WNQQrCMBBFr1JmbWQ6JbW48h5SSowTG6iNZNKgl
 N7d2Au4fA/++ysIR88C52qFyNmLD3MBOlRgRzM/WPl7YSCkFk+EyoY5c0yDM9MUrEk8yOITq46
 wqcndXKMJyvoV2fn3Xr72hUcvKcTPfpTrn/3fzLVCpdFwp61uLTYXWYSPNjyh37btC/jEjD29A
 AAA
X-Change-ID: 20260720-convert_fallocate_suite-820312fbf352
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786090536; l=1008;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=5I3LT6gtfHuNcswTNDQRWanaq72gs5Ea/qUUiP8Oen8=;
 b=v0jS/os9QShRPyp1ZEDZ3aV0cwshUkhj2jAgFMfFAZePdEmbITqRQuNso/DWYqMzXYGunPIn8
 vneLGktKarhDz8QxWtcNm9AheyLUGRcaeqWXAkDIyaM+KIEp2+VWAUq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Convert fallocate testing suite
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
Changes in v2:
- fix fname size
- simplify commit messages
- Link to v1: https://lore.kernel.org/20260720-convert_fallocate_suite-v1-0-50ae85c56c03@suse.com

---
Andrea Cervesato (2):
      fallocate01: Convert to new API
      fallocate02: Convert to new API

 testcases/kernel/syscalls/fallocate/fallocate01.c | 337 ++++++----------------
 testcases/kernel/syscalls/fallocate/fallocate02.c | 193 ++++---------
 2 files changed, 157 insertions(+), 373 deletions(-)
---
base-commit: 12fcadf63a99fc4bec76f9b4715cda626256562f
change-id: 20260720-convert_fallocate_suite-820312fbf352

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
