Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCECD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 12:52:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0C843E2B11
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 14:52:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 958843CE0FA
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 14:51:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1EF351400262
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 14:51:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C63B16AAA6;
 Wed, 10 Jun 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781095916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHucoMRTXwUTxVUN2pXk+nr6k8+UkMiMMBjzXLGrxQc=;
 b=e+R7jL9N+oyGDiLY+T6hAYJqnHZkatW6E3OUDUMzU243pUcn5YV9GXpXQ/ubuwGs11aaMi
 /AH9aYhWb9VY4euAfVhp++kKg1BpQCh/ShdZYLK8pP/pbQtXTjtLWtjGJ+nSvwdKfWjnEl
 meJvG94d07ft2SIFhLlmvDzKO4fkh1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781095916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHucoMRTXwUTxVUN2pXk+nr6k8+UkMiMMBjzXLGrxQc=;
 b=UeGs10gMv6DIDwAilQIlP4QYQoTl5N4iqgHglfdVTgD81ItWn19u+V9BO/NnECh6UbpXU3
 HcjuZwSnIE05nHDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e+R7jL9N;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UeGs10gM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781095916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHucoMRTXwUTxVUN2pXk+nr6k8+UkMiMMBjzXLGrxQc=;
 b=e+R7jL9N+oyGDiLY+T6hAYJqnHZkatW6E3OUDUMzU243pUcn5YV9GXpXQ/ubuwGs11aaMi
 /AH9aYhWb9VY4euAfVhp++kKg1BpQCh/ShdZYLK8pP/pbQtXTjtLWtjGJ+nSvwdKfWjnEl
 meJvG94d07ft2SIFhLlmvDzKO4fkh1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781095916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHucoMRTXwUTxVUN2pXk+nr6k8+UkMiMMBjzXLGrxQc=;
 b=UeGs10gMv6DIDwAilQIlP4QYQoTl5N4iqgHglfdVTgD81ItWn19u+V9BO/NnECh6UbpXU3
 HcjuZwSnIE05nHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADBD6779A7;
 Wed, 10 Jun 2026 12:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IiMLKexdKWrQBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jun 2026 12:51:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 14:51:54 +0200
Message-Id: <20260610-fw_load-v1-0-df9d38315e38@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOpdKWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3bTy+Jz8xBRdIwsLIwMLi6TUZItUJaDqgqLUtMwKsEnRsbW1AOA
 zTwJZAAAA
X-Change-ID: 20260609-fw_load-2882088bec8e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781095916; l=1750;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pCVzHBYvk/TWXNKnv90z4WQCOqHIW7UbhlQ4wYbKlFo=;
 b=Hzc8vkUF/Qj1tStn0TclxCFYl4sUnBcr/FtcdG7omDbRBADAiGDasSp0b4gs47RDqz2Z+Ez/3
 q/33/jVGfr4BEl3R73XHcg2XhV7LcwMCUp3yGVImWT+k9/0YL1sTiQ/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.com:email, suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C63B16AAA6
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Rewrite fw_load test using new API
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
Andrea Cervesato (3):
      fw_load: Modernize ltp_fw_load kernel module
      firmware/fw_load: rewrite firmware loading test using new LTP API
      firmware/fw_load: add fw_load02 for custom firmware path

 runtest/kernel_misc                                |   3 +-
 .../{fw_load_kernel => fw_load}/.gitignore         |   2 +
 testcases/kernel/firmware/fw_load/Makefile         |  25 +++
 testcases/kernel/firmware/fw_load/fw_load.h        |  17 ++
 testcases/kernel/firmware/fw_load/fw_load01.c      | 162 ++++++++++++++++
 testcases/kernel/firmware/fw_load/fw_load02.c      | 144 ++++++++++++++
 testcases/kernel/firmware/fw_load/ltp_fw_load.c    | 178 +++++++++++++++++
 testcases/kernel/firmware/fw_load_kernel/Makefile  |  35 ----
 testcases/kernel/firmware/fw_load_kernel/README    |  16 --
 .../kernel/firmware/fw_load_kernel/ltp_fw_load.c   | 164 ----------------
 testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
 testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
 testcases/kernel/firmware/fw_load_user/README      |  11 --
 testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
 14 files changed, 530 insertions(+), 461 deletions(-)
---
base-commit: c1b71bf7ebb6a58507e4998faf5c74154f595f96
change-id: 20260609-fw_load-2882088bec8e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
