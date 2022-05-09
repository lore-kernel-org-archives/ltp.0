Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E321AC433F5
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 09:43:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D6A03CA93E
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 11:43:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A403E3CA90D
 for <ltp@lists.linux.it>; Mon,  9 May 2022 11:43:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19AA91A006FC
 for <ltp@lists.linux.it>; Mon,  9 May 2022 11:43:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 086E321BD9;
 Mon,  9 May 2022 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652089406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cKZCfVewFmRTeUoXBReiV+zvPbXCI6EZC8cr0JHIzEg=;
 b=fUfnjBY4rwcAsAYHJ9UJRmSag4aZ9W9W0hYklNlt9UWNqqMCw+awQC8X5w4ucW/Owfo6sp
 noHLncN/XMvIYZjlQPwZWfeLObxP87Wq80EhU/o9Zn1tCMtBfJdFez/PxVJznn56OQMc5Z
 q/fNRx8hwB5kxOVN8oEqox+pRNet1tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652089406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cKZCfVewFmRTeUoXBReiV+zvPbXCI6EZC8cr0JHIzEg=;
 b=cG3FV/PWvPiVRkLPSGxZfNnkKJ85zdbQIJu4mU4ouqclNlLqgBvbwp9/FmJDzeJ0O70vhM
 nBxnm9c/6T/a68BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C330613AA5;
 Mon,  9 May 2022 09:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZlIOLj3ieGIuaAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 09 May 2022 09:43:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 May 2022 11:43:22 +0200
Message-Id: <20220509094322.10959-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Fix using functions
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

Functions can be used after loading shell library, otherwise:
/opt/ltp/testcases/bin/if-mtu-change.sh: 14: tst_net_use_netns: not found
/opt/ltp/testcases/bin/if-mtu-change.sh: 19: tst_is_int: not found

Thus move timeout setup to setup function (which requires to call
tst_set_timeout() as TST_TIMEOUT is read before setup is run.
Also move setup and cleanup function up, to make variables more visible.

It could be also fixed by moving variables after sourcing if-lib.sh,
but that'd hide part of the setup to the end.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sorry for introducing a regression.

Kind regards,
Petr

 .../network/stress/interface/if-mtu-change.sh | 58 ++++++++++---------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index 1fb667c19..cabc5d4cf 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -9,16 +9,6 @@ IF_CMD='ifconfig'
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
 
-# CHANGE_INTERVAL: The interval of the mtu change
-TST_TIMEOUT=1
-if tst_net_use_netns; then
-    CHANGE_INTERVAL=${CHANGE_INTERVAL:-100ms}
-else
-    CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
-fi
-tst_is_int $CHANGE_INTERVAL && TST_TIMEOUT=$CHANGE_INTERVAL
-TST_TIMEOUT=$(((TST_TIMEOUT + 30) * MTU_CHANGE_TIMES))
-
 # The array of the value which MTU is changed into sequentially
 # 552 - net.ipv4.route.min_pmtu
 CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
@@ -27,6 +17,36 @@ saved_mtu=
 
 MAX_PACKET_SIZE=65507
 
+do_setup()
+{
+	# CHANGE_INTERVAL: The interval of the mtu change
+	if tst_net_use_netns; then
+		CHANGE_INTERVAL=${CHANGE_INTERVAL:-100ms}
+	else
+		CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
+	fi
+
+	local timeout=1
+	tst_is_int $CHANGE_INTERVAL && timeout=$CHANGE_INTERVAL
+	tst_set_timeout $(((timeout + 30) * MTU_CHANGE_TIMES))
+
+	[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
+
+	if_setup
+	saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
+	[ "$TST_IPV6" ] || find_ipv4_max_packet_size
+}
+
+do_cleanup()
+{
+	if_cleanup_restore
+
+	if [ "$saved_mtu" ]; then
+		ip link set $(tst_iface) mtu $saved_mtu
+		tst_rhost_run -c "ip link set $(tst_iface rhost) mtu $saved_mtu"
+	fi
+}
+
 set_mtu()
 {
 	local mtu="$1"
@@ -67,24 +87,6 @@ find_ipv4_max_packet_size()
 	tst_brk TBROK "failed to find max MTU"
 }
 
-do_setup()
-{
-
-	[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
-	if_setup
-	saved_mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
-	[ "$TST_IPV6" ] || find_ipv4_max_packet_size
-}
-
-do_cleanup()
-{
-	if_cleanup_restore
-	if [ "$saved_mtu" ]; then
-		ip link set $(tst_iface) mtu $saved_mtu
-		tst_rhost_run -c "ip link set $(tst_iface rhost) mtu $saved_mtu"
-	fi
-}
-
 test_body()
 {
 	local cmd="$CMD"
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
