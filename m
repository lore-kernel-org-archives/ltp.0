Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA0CC48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69BE73CDEAB
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:00:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D5213CC4AD
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6CA6711F6454
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A184C22393;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QITzb9SqfWSC13RYFXcsCSPagD2U0xIOctHBkxOWJag=;
 b=yslu13hbjwwSI4v5ib62aVlwbfZ4Y6dJgIWbc2bq/dDHjjBrlNRb1fApXJAjYSQPfEv4Re
 Geg1XzGo87a8iA9850KVvBtdUq846ct1+lUmMib6PxN9SCYKSmA9o8hSj+yvKXoq74akJQ
 ceN0RsyT94t+n+KIpFuHCWlaycQ5mF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QITzb9SqfWSC13RYFXcsCSPagD2U0xIOctHBkxOWJag=;
 b=oBfRPWmCu3GHK6MnHU/K+haJ9gx8BgDcHIPjj+1WXR751l99WsBe1JJFFIEjky/ht/i867
 5sM4cN8g3nwn2/CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QITzb9SqfWSC13RYFXcsCSPagD2U0xIOctHBkxOWJag=;
 b=yslu13hbjwwSI4v5ib62aVlwbfZ4Y6dJgIWbc2bq/dDHjjBrlNRb1fApXJAjYSQPfEv4Re
 Geg1XzGo87a8iA9850KVvBtdUq846ct1+lUmMib6PxN9SCYKSmA9o8hSj+yvKXoq74akJQ
 ceN0RsyT94t+n+KIpFuHCWlaycQ5mF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QITzb9SqfWSC13RYFXcsCSPagD2U0xIOctHBkxOWJag=;
 b=oBfRPWmCu3GHK6MnHU/K+haJ9gx8BgDcHIPjj+1WXR751l99WsBe1JJFFIEjky/ht/i867
 5sM4cN8g3nwn2/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5870D13984;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CB12FPqXxGUoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:59:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 09:59:30 +0100
Message-ID: <20240208085932.182167-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208085932.182167-1-pvorel@suse.cz>
References: <20240208085932.182167-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.86 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.04)[-0.186]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[15.85%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] network: Remove clockdiff01.sh test
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

clockdiff is not much relevant nowadays, thus remove it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                          |  1 -
 testcases/network/tcp_cmds/clockdiff/Makefile | 10 -------
 .../network/tcp_cmds/clockdiff/clockdiff01.sh | 30 -------------------
 3 files changed, 41 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/clockdiff/Makefile
 delete mode 100755 testcases/network/tcp_cmds/clockdiff/clockdiff01.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index d6ba49e07..248c7371d 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -5,7 +5,6 @@
 ipneigh01_arp ipneigh01.sh -c arp
 ipneigh01_ip ipneigh01.sh -c ip
 arping01 arping01.sh
-clockdiff01 clockdiff01.sh
 ftp ftp01.sh
 netstat netstat01.sh
 ping01 ping01.sh
diff --git a/testcases/network/tcp_cmds/clockdiff/Makefile b/testcases/network/tcp_cmds/clockdiff/Makefile
deleted file mode 100644
index d2e72519a..000000000
--- a/testcases/network/tcp_cmds/clockdiff/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= clockdiff01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
deleted file mode 100755
index 4058fbe11..000000000
--- a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2016-2019 Oracle and/or its affiliates. All Rights Reserved.
-# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-
-TST_TESTFUNC="do_test"
-TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="cut clockdiff"
-
-
-do_test()
-{
-	tst_res TINFO "check time delta for $(tst_ipaddr)"
-
-	local output=$(clockdiff $(tst_ipaddr))
-
-	if [ $? -ne 0 ]; then
-		tst_res TFAIL "clockdiff failed to get delta"
-	else
-		delta=$(echo "$output" | cut -d' ' -f2,3)
-		if [ "$delta" = "0 0" ]; then
-			tst_res TPASS "delta is 0 as expected"
-		else
-			tst_res TFAIL "not expected data received: '$output'"
-		fi
-	fi
-}
-
-. tst_net.sh
-tst_run
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
