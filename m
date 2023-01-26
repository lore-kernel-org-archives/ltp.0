Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A63C54EAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:55:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6AD33CD36B
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:55:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 226B53CD34F
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F4E714010FD
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FD191F8A8;
 Thu, 26 Jan 2023 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MboRKtqf6AKC+lmYv+Xo4yQJWonfND0l9rTA5wy749Y=;
 b=Vf7J6g6bDCkOOIu0b3SV8LJFmq897gPwGNLsoFgpD9kB/J4NPkRdD42iICJ1mzOpUv9/KT
 pHTrEr3Z3j1EI0oLmS4OJVwyBRzt7WEP4RaTLtmHpz/BEsHDoun6w/2YnaC25CCVZcpBhW
 kDyon63z75ra5xtzROwf6kTf1oty/0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MboRKtqf6AKC+lmYv+Xo4yQJWonfND0l9rTA5wy749Y=;
 b=pkClLSsL6FQG0hwutL4yVd7QK5v7jQDRyvco7rRVV+evKziNSIIM+UD2nyJ1JNEsSTZI65
 nrvZXRiN2uyt/yBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBFAC139B3;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kNEtNID20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:54:01 +0100
Message-Id: <20230126215401.29101-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] tst_net.sh: Move net setup into separate function
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

Having network setup in separate function helps readability.
Test environment variables are for readability kept outside.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 118 ++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 57 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7ee8594a54..490909907a 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1006,6 +1006,64 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
+# Setup LTP network.
+# Used tools:
+# * tst_net_ip_prefix
+# Strip prefix from IP address and save both If no prefix found sets
+# default prefix.
+#
+# * tst_net_iface_prefix reads prefix and interface from rtnetlink.
+# If nothing found sets default prefix value.
+#
+# * tst_net_vars exports environment variables related to test links and
+# networks that aren't reachable through the test links.
+#
+# For full list of exported environment variables see:
+# tst_net_ip_prefix -h
+# tst_net_iface_prefix -h
+# tst_net_vars -h
+tst_net_setup_network()
+{
+	tst_require_cmds tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
+
+	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
+	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
+
+	[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6_cmdline rhost
+
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
+		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
+	fi
+
+	tst_net_use_netns && init_ltp_netspace
+	tst_net_check_ifaces_ipv6
+
+	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
+	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
+		|| echo "exit $?")
+	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
+		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
+
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
+		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
+			|| echo "exit $?")
+		eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
+			$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
+	fi
+
+	tst_res_ TINFO "Network config (local -- remote):"
+	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
+	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
+	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+
+	if [ -n "$TST_USE_LEGACY_API" ]; then
+		tst_net_remote_tmpdir
+		[ "$TST_IPVER" = 6 ] && tst_net_require_ipv6
+	fi
+}
+
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
 # detect IPv6 support on lhost for tests which don't use test links
@@ -1028,56 +1086,10 @@ IPV4_RHOST="${IPV4_RHOST:-10.0.0.1/24}"
 IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2/64}"
 IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 
-# tst_net_ip_prefix
-# Strip prefix from IP address and save both If no prefix found sets
-# default prefix.
-#
-# tst_net_iface_prefix reads prefix and interface from rtnetlink.
-# If nothing found sets default prefix value.
-#
-# tst_net_vars exports environment variables related to test links and
-# networks that aren't reachable through the test links.
-#
-# For full list of exported environment variables see:
-# tst_net_ip_prefix -h
-# tst_net_iface_prefix -h
-# tst_net_vars -h
-tst_require_cmds tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
-eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
-eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
-
-[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6_cmdline rhost
-
-if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
-fi
-
-tst_net_use_netns && init_ltp_netspace
-tst_net_check_ifaces_ipv6
-
-eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
-eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
-	|| echo "exit $?")
-
-if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
-		|| echo "exit $?")
-fi
-
-eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
-	$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
-
-if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
-		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
-fi
+tst_net_setup_network
 
-tst_res_ TINFO "Network config (local -- remote):"
-tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
-tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
-tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+# More information about network parameters can be found
+# in the following document: testcases/network/stress/README
 
 export TST_NET_DATAROOT="$LTPROOT/testcases/bin/datafiles"
 
@@ -1123,14 +1135,6 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 export NS_ICMPV4_SENDER_DATA_MAXSIZE=1472
 export NS_ICMPV6_SENDER_DATA_MAXSIZE=1452
 
-# More information about network parameters can be found
-# in the following document: testcases/network/stress/README
-
-if [ -n "$TST_USE_LEGACY_API" ]; then
-	[ "$TST_IPVER" = 6 ] && tst_net_require_ipv6
-	tst_net_remote_tmpdir
-fi
-
 if [ -z "$TST_USE_LEGACY_API" ] && ! tst_cmd_available ping6; then
 	ping6()
 	{
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
