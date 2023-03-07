Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E1C6FD1B
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 14:56:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3A313CB889
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 15:56:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFBC63C2461
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 15:55:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 75E6060007C
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 15:55:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7491621A24;
 Tue,  7 Mar 2023 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678200926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3N+S/ehkkgBD6OFSSL466a+u6F5b2UtIaX5+es4ezg8=;
 b=ThBCJzAJ8+2BuXRF0IcbI+Mq7WGWdXnDbpNtiJqtFMeZNlHY3+zRXRv35yXeYgtoTkRhRY
 StRO+Xup50ZjpCWDrsWONGga4u2p6U/XJ4JBK7vbR9nGLXTaI6BOY6EOyn21hIgv4vovaP
 iAoiJRQZB3IJ/OJ98Y2MfwIvzzZvx0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678200926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3N+S/ehkkgBD6OFSSL466a+u6F5b2UtIaX5+es4ezg8=;
 b=oXgKqcRvKzAE7vcrOO9SETBrWKJIjQRICB/pBWLEihDwCkLlVuEP+aYRnoMhoi+epZmdVv
 7sQd3rxbPT5WpaAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D54251341F;
 Tue,  7 Mar 2023 14:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ILaNMl1QB2Q0DwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Mar 2023 14:55:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Mar 2023 15:55:17 +0100
Message-Id: <20230307145517.1359-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307145517.1359-1-pvorel@suse.cz>
References: <20230307145517.1359-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] df01.sh: Use tst_fsfreeze for XFS on kernel >=
 5.19
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
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

XFS since kernel 5.19 postpone certain operation.  Use LTP fsfreeze
implementation to force all the background garbage collection to run
to completion.

Link: https://lore.kernel.org/linux-block/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
Suggested-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/df/df01.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index ae0449c3c..699d1538f 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Fujitsu Ltd.
-# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
 # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
 #
 # Test df command with some basic options.
@@ -46,6 +46,11 @@ df_test()
 
 	ROD_SILENT rm -rf $TST_MNTPOINT/testimg
 
+	# force all the background garbage collection to run to completion
+	if [ "$TST_FS_TYPE" = "xfs" ] && tst_kvcmp -ge "5.19"; then
+		tst_fsfreeze $TST_MNTPOINT
+	fi
+
 	# flush file system buffers, then we can get the actual sizes.
 	sync
 }
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
