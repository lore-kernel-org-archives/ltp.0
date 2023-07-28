Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4256BC001E0
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 13:22:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6D13CE65C
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 15:22:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 066E93CE657
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E65A01400E4A
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 398371F8AF;
 Fri, 28 Jul 2023 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690550484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OusCX+1LcdXdto1/2S+lb+/xP7eLdxapw9ZryzT/oVU=;
 b=Ajj2yaKTeHDvjkZHKQRDMXv+NrQkiUMOIVD7qflV1UVzH4xPyNsLZWmSehKleNSxWWX35O
 pu7gCjOYnehWhLMeMVp/lF4aW5DgV5Mbe4qKnF0AX/tvCXfwlKoPGCqPL+6GaHePD9f91g
 P+6qwRmE3AP+vnLoAK8ozLKDO2yfh8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690550484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OusCX+1LcdXdto1/2S+lb+/xP7eLdxapw9ZryzT/oVU=;
 b=qscLp82EAUmkzOwiAHo89jSxm9WL3ILCw2bGq1SRbVL28STianqwAag+d/LypftladWipC
 tiqBeu+YUOudxVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ECF8139BD;
 Fri, 28 Jul 2023 13:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aNaCAtTAw2RKBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 13:21:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jul 2023 15:21:16 +0200
Message-ID: <20230728132120.17322-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728132120.17322-1-pvorel@suse.cz>
References: <20230728132120.17322-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] insmod01.sh: Skip test on lockdown and secure boot
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

Lockdown patchset and secure boot does not allow to install LTP kernel module:

insmod: ERROR: could not insert module ltp_insmod01.ko: Operation not permitted
insmod01 1 TFAIL: insmod failed

Therefore skip the test on them (similar to C tests in 56660bd61).

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1208920
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/insmod/insmod01.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
index 1881ba389..992b4a05a 100755
--- a/testcases/commands/insmod/insmod01.sh
+++ b/testcases/commands/insmod/insmod01.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Fujitsu Ltd.
+# Copyright (c) Linux Test Project, 2016-2023
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
 # Test basic functionality of insmod command.
@@ -10,6 +11,8 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="rmmod insmod"
 TST_NEEDS_MODULE="ltp_insmod01.ko"
+TST_SKIP_IN_LOCKDOWN=1
+TST_SKIP_IN_SECUREBOOT=1
 
 inserted=0
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
