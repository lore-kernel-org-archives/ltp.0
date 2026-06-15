Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22184CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:13:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5A33E5C70
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:13:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08E453E5578
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:12:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B4D8600908
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:12:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 506676AD79;
 Mon, 15 Jun 2026 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781525572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIhRxYRA644Ns2btw42Tp2rM4nHu+SKjogPCHM5v7Sc=;
 b=pplKBUik3EcMo79SzfPElpZcO4fGW9jRVhsiYXE1kfJmUyZk/TyvrU7E5UlmgsQd3H6ptQ
 fsZXLjU+Fgegp/OTc4W0mNfInzR47m40q1fjsPa1cnadLYVkgl4GK8O9Hsd1s4lld+9hIg
 /GGgUtxoQ+9FVTUClG717xR8zFE+hJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781525572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIhRxYRA644Ns2btw42Tp2rM4nHu+SKjogPCHM5v7Sc=;
 b=vwxDXH/SHb7KC75K2WhPYJIoRuO9psgk7n2N6GA3xzB6wPGaH2zlsQpg9eibDMSNcUaW4l
 tVKQ/7Bp3Nbod5BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pplKBUik;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vwxDXH/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781525572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIhRxYRA644Ns2btw42Tp2rM4nHu+SKjogPCHM5v7Sc=;
 b=pplKBUik3EcMo79SzfPElpZcO4fGW9jRVhsiYXE1kfJmUyZk/TyvrU7E5UlmgsQd3H6ptQ
 fsZXLjU+Fgegp/OTc4W0mNfInzR47m40q1fjsPa1cnadLYVkgl4GK8O9Hsd1s4lld+9hIg
 /GGgUtxoQ+9FVTUClG717xR8zFE+hJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781525572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIhRxYRA644Ns2btw42Tp2rM4nHu+SKjogPCHM5v7Sc=;
 b=vwxDXH/SHb7KC75K2WhPYJIoRuO9psgk7n2N6GA3xzB6wPGaH2zlsQpg9eibDMSNcUaW4l
 tVKQ/7Bp3Nbod5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 356DC779A7;
 Mon, 15 Jun 2026 12:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jSx9C0TsL2pRZAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jun 2026 12:12:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 14:12:44 +0200
Message-Id: <20260615-fw_load-v7-0-d51e607f16bd@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADzsL2oC/3XMTWrDMBCG4asEraswGv26q94jhDKWRo2gjYvVO
 C3Bd68SQhsMXn7DPO9FVB4LV/G8uYiRp1LLcGzDP21EPNDxjWVJbQsEdOCgk/n8+j5QkhgCQgg
 9x8CifX+OnMv3rbTbt30o9WsYf27hSV2v94aCv8akJMiUu6SDVpZ1eKmnyts4fIhrYsIVho3lS
 C4TofbUL5heYbox5qyRU+aQ7IKZR6b+mWlMQUeQLZqezYLZFWYb84wqGSC2hhbMrTDXWETi6Dv
 ynPwDm+f5F0zmYJuwAQAA
X-Change-ID: 20260609-fw_load-2882088bec8e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781525572; l=2867;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3r2gJNunKTwjno+WDMFo1r4tW5l2tQpYWPTy1BsRINc=;
 b=zF2geTQIFo/8iwdEVZIf1tn8AI+Jv9YacFZ6Hv7OztHqLe1AoPkw+IFIwUdib0oHaXGHGD615
 Q0w/T1V5CGNB1qDxXjZeXbyv/mJjUCt3if/MAPyfbAt7T0q+TlK8HrX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 506676AD79
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] Rewrite fw_load test using new API
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
Changes in v7:
- simplify test result logic
- fw_load01 and fw_load02 are now sharing the same test function
- Link to v6: https://lore.kernel.org/r/20260611-fw_load-v6-0-c2aec79a7ed7@suse.com

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
 testcases/kernel/firmware/fw_load/fw_load.h        |  87 +++++++++
 testcases/kernel/firmware/fw_load/fw_load01.c      | 111 +++++++++++
 testcases/kernel/firmware/fw_load/fw_load02.c      |  93 +++++++++
 testcases/kernel/firmware/fw_load/ltp_fw_load.c    | 178 +++++++++++++++++
 testcases/kernel/firmware/fw_load_kernel/Makefile  |  35 ----
 testcases/kernel/firmware/fw_load_kernel/README    |  16 --
 .../kernel/firmware/fw_load_kernel/ltp_fw_load.c   | 164 ----------------
 testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
 testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
 testcases/kernel/firmware/fw_load_user/README      |  11 --
 testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
 14 files changed, 498 insertions(+), 461 deletions(-)
---
base-commit: 548a05c01137580d621d56a02ce00e33dc44e859
change-id: 20260609-fw_load-2882088bec8e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
