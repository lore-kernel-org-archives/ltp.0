Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDD1C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B20EC3CA68B
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:50:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CCB23C0677
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E583B1400BC8
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8484C210FC;
 Wed, 27 Apr 2022 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651063807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ3lVmDbSrLkBfvo7lX/KXAJ1YTdDpX0JdEBxcSR0o4=;
 b=1oRx5tIyMgxY6vZk/eVd8dZQqpobRGoE9nsmOdLAtywe352GJga1JYIi0qzB8wzhjC3xRH
 rzMd6s7agDZoRGXKz6ABrwUFacsewAOOrdHn3jRwzl6BWkolo1aS83AAGyjt83bok+Vl3x
 vW1ZQ9AU40I/JzxTpC6r9fY0slnhY/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651063807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ3lVmDbSrLkBfvo7lX/KXAJ1YTdDpX0JdEBxcSR0o4=;
 b=vuFHOPSjitlamx7WDvbczZqujMHcBi9+zMlATNSG/8+hPXX95HxW0ybkN1/TQOsJCLb3WM
 AtzbnalRDfo2+iCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44B6C1323E;
 Wed, 27 Apr 2022 12:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KLr1Dv87aWK5RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 12:50:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Apr 2022 14:50:00 +0200
Message-Id: <20220427125003.20815-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427125003.20815-1-pvorel@suse.cz>
References: <20220427125003.20815-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] shell: Use conditional expansion for library
 setup/cleanup
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

To avoid surprises when test specific setup/cleanup function is
redefined by shell library.

Although there is not an optimal general solution because usually test
which have specific setup/cleanup also needs to call library setup/cleanup,
but it's better not to require TST_{SETUP,CLEANUP} to be on specific place.

Added to all shell libraries, regardless it's required or not.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* remove copyright only changes
* busy_poll_lib.sh: revert conditional expansion (note that
  setup/cleanup defined by test was added in previous commit)

 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 4 ++--
 testcases/kernel/device-drivers/zram/zram_lib.sh           | 6 +++---
 testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh         | 4 ++--
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh                 | 4 ++--
 testcases/network/dhcp/dhcp_lib.sh                         | 6 +++---
 testcases/network/stress/interface/if-lib.sh               | 7 +++++--
 testcases/network/virt/macsec_lib.sh                       | 6 +++---
 7 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 1b76b6597..db010acc7 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -10,8 +10,8 @@ TST_NEEDS_CHECKPOINTS=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="killall find kill"
-TST_CLEANUP=memcg_cleanup
-TST_SETUP=memcg_setup
+TST_SETUP="${TST_SETUP:-memcg_setup}"
+TST_CLEANUP="${TST_CLEANUP:-memcg_cleanup}"
 TST_TESTFUNC=memcg_testfunc
 
 MEMCG_SHMMAX=${MEMCG_SHMMAX:-0}
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index a420fb672..803fd9825 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 dev_makeswap=-1
@@ -12,8 +12,8 @@ sys_control=-1
 
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_SETUP="zram_load"
-TST_CLEANUP="zram_cleanup"
+TST_SETUP="${TST_SETUP:-zram_load}"
+TST_CLEANUP="${TST_CLEANUP:-zram_cleanup}"
 TST_NEEDS_DRIVERS="zram"
 . tst_test.sh
 
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
index 497682531..ff862db43 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
@@ -4,8 +4,8 @@
 # Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 
-TST_SETUP=binfmt_misc_setup
-TST_CLEANUP=binfmt_misc_cleanup
+TST_SETUP="${TST_SETUP:-binfmt_misc_setup}"
+TST_CLEANUP="${TST_CLEANUP:-binfmt_misc_cleanup}"
 TST_NEEDS_DRIVERS="binfmt_misc"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
index a5356fa36..6676d1021 100644
--- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
+++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
@@ -7,8 +7,8 @@
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_MIN_KVER=2.6.15
-TST_SETUP=fs_bind_setup
-TST_CLEANUP=fs_bind_cleanup
+TST_SETUP="${TST_SETUP:-fs_bind_setup}"
+TST_CLEANUP="${TST_CLEANUP:-fs_bind_cleanup}"
 TST_TESTFUNC=fs_bind_test
 TST_NEEDS_CMDS="mount umount awk sed"
 
diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 5537112c8..ebee0c2e9 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -1,11 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2018 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Author:       Alexey Kodanev alexey.kodanev@oracle.com
 
-TST_SETUP="dhcp_lib_setup"
-TST_CLEANUP="dhcp_lib_cleanup"
+TST_SETUP="${TST_SETUP:-dhcp_lib_setup}"
+TST_CLEANUP="${TST_CLEANUP:-dhcp_lib_cleanup}"
 TST_TESTFUNC="test01"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index b398be1ad..2b1db6e00 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -5,7 +5,11 @@
 
 CMD="${CMD:-ip}"
 
-TST_SETUP="${TST_SETUP:-if_setup}"
+if [ -z "$TST_SETUP" ]; then
+	TST_SETUP="if_setup"
+	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
+fi
+
 TST_TESTFUNC="test_body"
 TST_PARSE_ARGS="if_parse_args"
 TST_USAGE="if_usage"
@@ -32,7 +36,6 @@ if_setup()
 
 	tst_require_cmds "$CMD"
 	netstress_setup
-	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
 }
 
 if_cleanup_restore()
diff --git a/testcases/network/virt/macsec_lib.sh b/testcases/network/virt/macsec_lib.sh
index c2573c572..ac77f0976 100755
--- a/testcases/network/virt/macsec_lib.sh
+++ b/testcases/network/virt/macsec_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -10,8 +10,8 @@ IPSEC_MODE="transport"
 
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=virt_netperf_msg_sizes
-TST_SETUP=macsec_lib_setup
-TST_CLEANUP=macsec_lib_cleanup
+TST_SETUP="${TST_SETUP:-macsec_lib_setup}"
+TST_CLEANUP="${TST_CLEANUP:-macsec_lib_cleanup}"
 TST_NEEDS_DRIVERS="macsec"
 . ipsec_lib.sh
 . virt_lib.sh
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
