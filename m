Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541B8C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 19:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAC713CA9D5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 21:46:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26CE63CA9BD
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FAF914010EC
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF3FA21AF7;
 Thu, 12 May 2022 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652384764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6X+Ah97AYZsD7c1e+7GZHoSb+EQp2ynPrbxExNjekE=;
 b=DGCLkKQFOHI4XZK1gABenbIQSMrBaU5pwyeVv8ceT0dnALg4KJxGkOl1ZFoJNm9a1g0tSl
 qNoA6FvmCruRJhQTBC7EXVrz76Qv8RnA/yGgYsEui1SINy2RYmku8FjeVTY/v8G+DVcXQh
 InGockCKMVHO2C1eXdeMYbXJleM6zkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652384764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6X+Ah97AYZsD7c1e+7GZHoSb+EQp2ynPrbxExNjekE=;
 b=+C1CnYGwRWUjCwPku/N+LtoZMa84CjC53aiICs6hOSLLPOgiB5QNC5lyOMgA/By2Md+ueA
 QUe4ETxBQH0guOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A3D313ABE;
 Thu, 12 May 2022 19:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IEnZF/xjfWIkVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 19:46:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 21:45:51 +0200
Message-Id: <20220512194557.30911-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220512194557.30911-1-pvorel@suse.cz>
References: <20220512194557.30911-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] df01.sh: Use TST_MOUNT_DEVICE=1
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/df/df01.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index f74032c96..976e205bf 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -1,19 +1,19 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Fujitsu Ltd.
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
 #
 # Test df command with some basic options.
 
 TST_CNT=12
 TST_SETUP=setup
-TST_CLEANUP=tst_umount
 TST_TESTFUNC=test
 TST_OPTS="f:"
 TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
 TST_NEEDS_ROOT=1
-TST_FORMAT_DEVICE=1
+TST_MOUNT_DEVICE=1
 
 usage()
 {
@@ -34,7 +34,6 @@ parse_args()
 
 setup()
 {
-	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk 'NR==1{print $5}')
 }
 
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
