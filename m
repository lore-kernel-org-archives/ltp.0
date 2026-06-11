Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95575CD98CF
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:45:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D200D3CAEDE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:45:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA57A3E6DD9
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DC1B600434
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 413066AF84;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC4VPnMPGJ1tUjloNxnUJEEbg8F64xIi4S1RalQEy4s=;
 b=qKcYZO4Uqz1j0tFmzlQQVyeGCbpaYdCqw4sqO4gjq4ppH4+BHhioH3dyRLP1llaC2iSbf/
 FDr7CM0QTLSyZxJHdAeVfUNPieNLkeBUgdz41TF8mlYz3dnReqV6EIXjCp53JcG+boW/cp
 94x2nzI9ZpxVAaU1HrvadzGyRrmkR+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC4VPnMPGJ1tUjloNxnUJEEbg8F64xIi4S1RalQEy4s=;
 b=NapsA9GQ4Sj5xljyP9dXdNPd2ezmeJWjcqjh3Z9gxcQEWoTIs+RYiO33cdJGR/VmfglR5h
 P7fZDRNZlzxz5MAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC4VPnMPGJ1tUjloNxnUJEEbg8F64xIi4S1RalQEy4s=;
 b=qKcYZO4Uqz1j0tFmzlQQVyeGCbpaYdCqw4sqO4gjq4ppH4+BHhioH3dyRLP1llaC2iSbf/
 FDr7CM0QTLSyZxJHdAeVfUNPieNLkeBUgdz41TF8mlYz3dnReqV6EIXjCp53JcG+boW/cp
 94x2nzI9ZpxVAaU1HrvadzGyRrmkR+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UC4VPnMPGJ1tUjloNxnUJEEbg8F64xIi4S1RalQEy4s=;
 b=NapsA9GQ4Sj5xljyP9dXdNPd2ezmeJWjcqjh3Z9gxcQEWoTIs+RYiO33cdJGR/VmfglR5h
 P7fZDRNZlzxz5MAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27F9F779AA;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4KY5CLi7KmqcJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 13:44:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 15:44:21 +0200
MIME-Version: 1.0
Message-Id: <20260611-fw_load-v6-3-c2aec79a7ed7@suse.com>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
In-Reply-To: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781185463; l=4580;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IxP7/CsbFHq/3uFA2DpJapHnJFQdo9pBLCocVCEQNjk=;
 b=ZM3WBptTr8siNg2Z+okoC/FmwOOg10Iico9+BaHNtGN1Rr6vXDFNWDbh7uElHA9oZKRJ4I+jr
 dE0/rUrEK6yByRQl+ftuWiixBwRIAencauVSPPTi0etJ+a6HLWzPsBF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] fw_load: merge module and test into fw_load
 folder
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Rename fw_load test into fw_load01 and move it into the fw_load folder
within ltp_fw_load.ko module.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                                               | 2 +-
 testcases/kernel/firmware/{fw_load_kernel => fw_load}/.gitignore  | 1 +
 testcases/kernel/firmware/{fw_load_kernel => fw_load}/Makefile    | 8 +++++---
 testcases/kernel/firmware/{fw_load_user => fw_load}/fw_load.h     | 0
 .../firmware/{fw_load_user/fw_load.c => fw_load/fw_load01.c}      | 0
 .../kernel/firmware/{fw_load_kernel => fw_load}/ltp_fw_load.c     | 0
 testcases/kernel/firmware/fw_load_user/.gitignore                 | 1 -
 testcases/kernel/firmware/fw_load_user/Makefile                   | 8 --------
 8 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 78f00d305fea10367fb4fd2845f25dd151a833ea..19caee1d81da9cf0503088138ecfda13436b96cf 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -1,6 +1,6 @@
 cn_pec_sh cn_pec.sh
 kmsg01 kmsg01
-fw_load fw_load
+fw_load01 fw_load01
 rtc01 rtc01
 rtc02 rtc02
 block_dev block_dev
diff --git a/testcases/kernel/firmware/fw_load_kernel/.gitignore b/testcases/kernel/firmware/fw_load/.gitignore
similarity index 91%
rename from testcases/kernel/firmware/fw_load_kernel/.gitignore
rename to testcases/kernel/firmware/fw_load/.gitignore
index 6fc82952c7f5406c04195e1064375d0c2bd53909..57eca444c161e6ba642561664cc7de3a8f134841 100644
--- a/testcases/kernel/firmware/fw_load_kernel/.gitignore
+++ b/testcases/kernel/firmware/fw_load/.gitignore
@@ -5,3 +5,4 @@
 /ltp_fw_load.mod.c
 /.tmp_versions/
 modules.livepatch
+fw_load01
diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile b/testcases/kernel/firmware/fw_load/Makefile
similarity index 82%
rename from testcases/kernel/firmware/fw_load_kernel/Makefile
rename to testcases/kernel/firmware/fw_load/Makefile
index e81b300faaa6b4056d4b5f3d1417c381a000256d..91e8d8d153b43c459a899aff2124db612ec9e960 100644
--- a/testcases/kernel/firmware/fw_load_kernel/Makefile
+++ b/testcases/kernel/firmware/fw_load/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) Linux Test Project, 2026
-# SPDX-License-Identifier: GPL-2.0-or-later
 
 ifneq ($(KERNELRELEASE),)
 
@@ -11,11 +11,13 @@ endif
 else
 
 top_srcdir	?= ../../../..
-include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/testcases.mk
 
 REQ_VERSION_MAJOR   := 3
 REQ_VERSION_PATCH   := 7
-MAKE_TARGETS	:= ltp_fw_load.ko
+
+MAKE_TARGETS	:= fw_load01 ltp_fw_load.ko
 
 include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.h b/testcases/kernel/firmware/fw_load/fw_load.h
similarity index 100%
rename from testcases/kernel/firmware/fw_load_user/fw_load.h
rename to testcases/kernel/firmware/fw_load/fw_load.h
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load/fw_load01.c
similarity index 100%
rename from testcases/kernel/firmware/fw_load_user/fw_load.c
rename to testcases/kernel/firmware/fw_load/fw_load01.c
diff --git a/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c b/testcases/kernel/firmware/fw_load/ltp_fw_load.c
similarity index 100%
rename from testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
rename to testcases/kernel/firmware/fw_load/ltp_fw_load.c
diff --git a/testcases/kernel/firmware/fw_load_user/.gitignore b/testcases/kernel/firmware/fw_load_user/.gitignore
deleted file mode 100644
index 1d0814980660f34b64bd49ba16c25dc1d99e9d07..0000000000000000000000000000000000000000
--- a/testcases/kernel/firmware/fw_load_user/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/fw_load
diff --git a/testcases/kernel/firmware/fw_load_user/Makefile b/testcases/kernel/firmware/fw_load_user/Makefile
deleted file mode 100644
index 5b031e2eb81597689ff5eab70246fb20ad02e77d..0000000000000000000000000000000000000000
--- a/testcases/kernel/firmware/fw_load_user/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) Linux Test Project, 2026
-
-top_srcdir	?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
