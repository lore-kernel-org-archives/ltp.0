Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5C0C19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D76A43C93F2
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:22:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EA983C9427
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:21:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBAB310000EE
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:21:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A440350C3;
 Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Otj02OSlPlm2Sk5asG7DkaYHqCcce0okZQHBkG2haBc=;
 b=naBnuGbVrn0TqNZRlg4GzltpFq9UFrnCIwtKQLDaNQddKjLWjs/Z6wB08eG6TltK1qJ1E5
 OFIC3v+YEJSe1vrr5EitEtM9ZIovNX55rKmHFu5yiH+Wo7QttJUY+gb/rRDk0LIVAhsAjo
 Gib5Hx6/t52DIXVuv+WqTnNs7Yeb+R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Otj02OSlPlm2Sk5asG7DkaYHqCcce0okZQHBkG2haBc=;
 b=GpMfSCC5G0MtsR+GlR5/o75VJgjHHGRWsFgA5NtmtK4jHjC/BW9mJkl0MwzaJ2Cao/z5Js
 ioPya0N+BGZPcdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D59113A94;
 Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yPUeAGy562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:45 +0200
Message-Id: <20220804121946.19564-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 09/10] shell: Add test for TST_ALL_FILESYSTEMS=1
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Unfortunately GitHub Actions don't have loop devices, thus cannot be run
in CI:

tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
/__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/tst_all_filesystems.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh

diff --git a/lib/newlib_tests/shell/tst_all_filesystems.sh b/lib/newlib_tests/shell/tst_all_filesystems.sh
new file mode 100755
index 000000000..8509a7481
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_all_filesystems.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_ALL_FILESYSTEMS=1
+TST_TESTFUNC=test
+TST_CNT=2
+
+test1()
+{
+	tst_res TPASS "device using filesystem"
+}
+
+test2()
+{
+	local pattern
+
+
+	if [ "$TST_FS_TYPE" = "exfat" -o "$TST_FS_TYPE" = "ntfs" ]; then
+		pattern="|fuseblk"
+	fi
+
+	EXPECT_PASS "grep -E '$TST_MNTPOINT ($TST_FS_TYPE${pattern})' /proc/mounts"
+}
+
+. tst_test.sh
+tst_run
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
