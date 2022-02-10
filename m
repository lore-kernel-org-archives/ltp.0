Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55124C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:28:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9F613C9EAD
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:28:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E6E3C9C2E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7917B200AE9
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0441F3A8;
 Thu, 10 Feb 2022 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXQwt9uZqpCBFx9yRjDbzvtPF88B2Zblo/Ph0CZQHng=;
 b=w6T6bbpNax/qz5juYeNtTh9tc8ZZVc5MHFCDE83oOQtbgaAP9l36fn6wPwZLWyGMkpSL1f
 K9A/h0K4yiGG9AgdTmHXheLlm26zbMvrIZicWJr11axsnID1Y43Kqg/zqWUUyUgLoMS+oU
 G1+NA6R/nxV6kI08SEk6NZKHLgmkChw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXQwt9uZqpCBFx9yRjDbzvtPF88B2Zblo/Ph0CZQHng=;
 b=rldi61j3Ifed+71lGnttmPMWjMtDY7escESeZFmyQGq3ZSjnQYjDXchSHqQ0iu8po0PNwD
 Ik50bxdy8YO3rNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D959B13BC1;
 Thu, 10 Feb 2022 16:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UF5BMwA9BWJAMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:27:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:27:38 +0100
Message-Id: <20220210162739.30159-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210162739.30159-1-pvorel@suse.cz>
References: <20220210162739.30159-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] shell: Add test for TST_FORMAT_DEVICE=1
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

Unfortunately GitHub Actions don't have loop devices, thus cannot be run
in CI:

tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
/__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Same as in v1

 lib/newlib_tests/shell/tst_format_device.sh | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_format_device.sh

diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
new file mode 100755
index 0000000000..b02f8b122b
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_FORMAT_DEVICE=1
+TST_TESTFUNC=test
+TST_CNT=2
+TST_DEV_FS_OPTS="-b 1024 -O quota"
+TST_DEV_EXTRA_OPTS="5m"
+TST_NEEDS_CMDS="df lsblk"
+. tst_test.sh
+
+test1()
+{
+	tst_res TPASS "device formatted"
+}
+
+test2()
+{
+	tst_check_cmds df || return
+	EXPECT_PASS "df $TST_DEVICE | grep -q /dev"
+}
+
+tst_run
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
