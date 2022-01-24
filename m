Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78375C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 06:59:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FFCD3C8870
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 07:59:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A7063C130C
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 07:59:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76EF61A0090A
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 07:59:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F78C1F380;
 Mon, 24 Jan 2022 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643007582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ihrHjLtmlodSYYe9Y67yv+uA8KDsYBjN3tu4rOLpOjs=;
 b=mRBe+JaoGRtQa3n/pHqTCONfVNd5xUmfsz7bPzYVbv3ziPlBiATPQa7cIvPT/eoDBWRMMS
 vUT1O43i43313llBDLpKooTsSO04hd+oZnVDBDoYk8Mb3J39oR9APKsubzBrEfTY5OIIJn
 eQ6sROqnAQ7kM/YHwh2RwlPAjBIIvgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643007582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ihrHjLtmlodSYYe9Y67yv+uA8KDsYBjN3tu4rOLpOjs=;
 b=nI3/SUsJJ2FQWBudSDH7VKwXgKtolvqPfMhlTVGa9XroLL/D6ck7V0tC5e/Rqx2jir6m2T
 RgN/zCg7BzT0gYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AC361331A;
 Mon, 24 Jan 2022 06:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1CXVA15O7mHIfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 06:59:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Jan 2022 07:59:37 +0100
Message-Id: <20220124065937.17383-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] rpc_lib.sh: Check for running RPC
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
Cc: NeilBrown <neilb@suse.de>,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

instead of just rpcbind/portmap was running.

This should fix problem for some containers where rpcbind has not been
started and calling rpcinfo should do the socket activation.

Reported-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

Nikita, does it really fix your case? Or there needs to be 2 rpcinfo -p
calls with sleep in between?

Kind regards,
Petr

 .../network/rpc/basic_tests/rpc01/rpc01.sh    |  2 +-
 testcases/network/rpc/basic_tests/rpc_lib.sh  | 22 ++++++++++++-------
 .../rpc/basic_tests/rpcinfo/rpcinfo01.sh      |  2 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh   |  2 +-
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
index 9ca5daae62..a4989b98f2 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
@@ -19,7 +19,7 @@ do_cleanup()
 
 do_setup()
 {
-	check_portmap_rpcbind
+	check_rpc
 
 	tst_res TINFO "start rpc_server"
 	ROD rpc_server
diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
index c7c868709b..477408bcef 100644
--- a/testcases/network/rpc/basic_tests/rpc_lib.sh
+++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
@@ -1,15 +1,21 @@
 #!/bin/sh
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
 
+TST_NEEDS_CMDS="rpcinfo $TST_NEEDS_CMDS"
 . tst_net.sh
 
-check_portmap_rpcbind()
+check_rpc()
 {
-	if pgrep portmap > /dev/null; then
-		PORTMAPPER="portmap"
-	else
-		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
-			tst_brk TCONF "portmap or rpcbind is not running"
+	local services
+
+	tst_res TINFO "check registered RPC with rpcinfo"
+
+	services=$(rpcinfo -p)
+
+	if [ $? -ne 0 ] || ! echo "$services" | grep -q '[0-9]'; then
+		tst_brk TCONF "no RPC services, is rpcbind/portmap running?"
 	fi
-	tst_res TINFO "using $PORTMAPPER"
+
+	tst_res TINFO "registered RPC"
+	echo "$x"
 }
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
index 811f79ef76..ade9711223 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
@@ -11,7 +11,7 @@ TST_NEEDS_CMDS="rpcinfo wc"
 
 do_setup()
 {
-	check_portmap_rpcbind
+	check_rpc
 
 	# Create file with 1 tcp and 1 udp line. Use for variable assignments.
 	rpcinfo -p $(tst_ipaddr) | grep tcp | sed -n 2p > rpc_out
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 54a689649c..e1d952da81 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -45,7 +45,7 @@ rpc_parse_args()
 
 setup()
 {
-	check_portmap_rpcbind
+	check_rpc
 
 	if [ -n "$SERVER" ]; then
 		CLEANER="rpc_cleaner"
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
