Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C3CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EC673C2B2D
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:44:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C91AA3E6CA5
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5680A20075F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D316475960;
 Thu, 11 Jun 2026 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KMb0fhTSdYxQd9FIVkb6t6KzgJS0UX/ts3iOxFPMm3E=;
 b=VbKl4dteTv+gDo5jJ5dvbQWT7vVscflmmAVZGRQ3MDPlP2OpQKh54aKqKGl7M0Gje0LvPB
 12U1sJApnA4XzcCbKIwmainAsszJ1rzw4fep3PHfiSIwW14WAzEF1SKTznCcuy4Hz6ov5P
 ovE3R7bDCJbK8+ZHjuIfbgzr65SMOws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KMb0fhTSdYxQd9FIVkb6t6KzgJS0UX/ts3iOxFPMm3E=;
 b=wT5tIkgOLHt+j4dwGF/F4szGsWR4HI3TKXLRJ0uGcNw21I0Zetc6t6MPl/3nSGonvlhDeG
 hZMgd38Sx70WxUDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KMb0fhTSdYxQd9FIVkb6t6KzgJS0UX/ts3iOxFPMm3E=;
 b=VbKl4dteTv+gDo5jJ5dvbQWT7vVscflmmAVZGRQ3MDPlP2OpQKh54aKqKGl7M0Gje0LvPB
 12U1sJApnA4XzcCbKIwmainAsszJ1rzw4fep3PHfiSIwW14WAzEF1SKTznCcuy4Hz6ov5P
 ovE3R7bDCJbK8+ZHjuIfbgzr65SMOws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KMb0fhTSdYxQd9FIVkb6t6KzgJS0UX/ts3iOxFPMm3E=;
 b=wT5tIkgOLHt+j4dwGF/F4szGsWR4HI3TKXLRJ0uGcNw21I0Zetc6t6MPl/3nSGonvlhDeG
 hZMgd38Sx70WxUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E83779A7;
 Thu, 11 Jun 2026 13:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LhmkK7e7KmqcJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 13:44:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 15:44:18 +0200
Message-Id: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALK7KmoC/3XMQQrCMBCF4atI1kYmk6SmrryHiEybiQbUSqNVk
 d7dKKJS6PIN8/0PkbiNnMRi8hAtdzHF5phHMZ2IekfHLcvo8xYIWEABpQzXzb4hL9E5BOcqrh2
 L/H1qOcTbu7Ra572L6dy093e4U6/rp6Hg2+iUBOlD6bXTyrJ2y3RJPKubg3glOhxhmFmoqQhEq
 OdUDZgeYToz5qCRfWDn7YCZf6Z+zGSmoCQIFk3FZsDsCLOZzRmVN0BsDf2xvu+fGU1mUnkBAAA
 =
X-Change-ID: 20260609-fw_load-2882088bec8e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781185463; l=2670;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xqrYQfuCB2kiRd7RZryXjjQRlxXN7MkpOBL9rrQZus4=;
 b=0ezQ6HgMana+wTzouorR2SnkSyyTclzxVg/rYTCudXNo4wymlSm3sv3DCgdQK2WE8tuoh+OqM
 t77/0OgUAWtAx9PRnQ2lyW9EpH1eop4OCj49txo4iXA80A22fzi85XF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] Rewrite fw_load test using new API
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

Support immutable distribution by splitting test in two:

- fw_load01 triggers request_firmware on /lib/firmware (read-only on
  immutable distributions) and it doesn't support read-only filesystems
- fw_load02 triggers request_firmware on custom path (always supported
  by any distribution)

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v6:
- add commit for `git mv` mergin both test and kernel module into
  fw_load folder
- fix fw_load02 fw_path setup
- Link to v5: https://lore.kernel.org/r/20260611-fw_load-v5-0-7e21d40ae54a@suse.com

Changes in v5:
- rebase since apply is failing
- Link to v4: https://lore.kernel.org/r/20260611-fw_load-v4-0-109a0f524be4@suse.com

Changes in v4:
- verify /lib/firmware/update was created by our test
- fix algorithm op order in fw_load02
- Link to v3: https://lore.kernel.org/r/20260610-fw_load-v3-0-eef32edfe8d5@suse.com

Changes in v3:
- fix bisecting
- fix algorithm op order
- Link to v2: https://lore.kernel.org/r/20260610-fw_load-v2-0-fca6faa237ab@suse.com

Changes in v2:
- fix fw_load.h define
- fix Makefile copyright position
- fix year in the firmware file
- Link to v1: https://lore.kernel.org/r/20260610-fw_load-v1-0-df9d38315e38@suse.com

---
Andrea Cervesato (4):
      fw_load: Modernize ltp_fw_load kernel module
      fw_load: rewrite test using new LTP API
      fw_load: merge module and test into fw_load folder
      fw_load: add fw_load02 for custom firmware path

 runtest/kernel_misc                                |   3 +-
 .../{fw_load_kernel => fw_load}/.gitignore         |   2 +
 testcases/kernel/firmware/fw_load/Makefile         |  25 +++
 testcases/kernel/firmware/fw_load/fw_load.h        |  18 ++
 testcases/kernel/firmware/fw_load/fw_load01.c      | 165 ++++++++++++++++
 testcases/kernel/firmware/fw_load/fw_load02.c      | 138 +++++++++++++
 testcases/kernel/firmware/fw_load/ltp_fw_load.c    | 178 +++++++++++++++++
 testcases/kernel/firmware/fw_load_kernel/Makefile  |  35 ----
 testcases/kernel/firmware/fw_load_kernel/README    |  16 --
 .../kernel/firmware/fw_load_kernel/ltp_fw_load.c   | 164 ----------------
 testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
 testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
 testcases/kernel/firmware/fw_load_user/README      |  11 --
 testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
 14 files changed, 528 insertions(+), 461 deletions(-)
---
base-commit: c685f1b774fab694c42dfb7522bc42d999904373
change-id: 20260609-fw_load-2882088bec8e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
