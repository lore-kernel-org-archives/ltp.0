Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96673C4332F
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 06:51:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC4DF3CA957
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 08:51:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19E7C3CA80D
 for <ltp@lists.linux.it>; Tue, 10 May 2022 08:51:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 16EAA10007FB
 for <ltp@lists.linux.it>; Tue, 10 May 2022 08:51:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 713791F8FB;
 Tue, 10 May 2022 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652165473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRHeqI3k8J2ooVkR7KflA6OFxHYYVkgNRyQFj7FBy9Y=;
 b=Fkw50wGoUmRbqH5VJyGQWnViqD1l5tfBmRuN79LNatdqqGwmnz5nSXfTYmyYrl1mp8K1pf
 Gja7bu4KKaG65m1VDvLkDlpJTgakYQuNUjfmgsxN8k28FA38ON1piIpT1Y2t7RbvnhnbAC
 7DiUYOa/JPiW3LRXZEas0miNUqCqtV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652165473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRHeqI3k8J2ooVkR7KflA6OFxHYYVkgNRyQFj7FBy9Y=;
 b=ie5XU1bwrCY9AWSUiphIBiBgjUC18q8cAMDZpxF4ZKBNXE61t6E1pwNeo7qk5QsMTKgG/i
 9y2hg9wIULmgQcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3563B13AA5;
 Tue, 10 May 2022 06:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id COG1C2ELemIOZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 06:51:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 May 2022 08:51:02 +0200
Message-Id: <20220510065104.1199-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510065104.1199-1-pvorel@suse.cz>
References: <20220510065104.1199-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] tst_net.sh: Fix for disabled IPv6
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

Tests failed in tst_init_iface even IPv4 only test was run.
Allow to init interfaces at least for IPv4.

We need IPv6 enabled on both endpoints to be usable,
unless test use TST_NET_SKIP_VARIABLE_INIT=1, i.e. use network library
functions but no test links (atm just library test tst_ipaddr_un.sh,
but netns_helper.sh will also use it). In this case only IPv6 on lhost
is tested.

Tests which use TST_IPV6=6 to force IPv6 (atm just broken_ip-nexthdr.sh)
need to be fixed, unless they use just tst_ipaddr_un() (e.g. library
test tst_ipaddr_un.sh).

Store result into $TST_NET_IPV6_ENABLED.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
Rebased. tst_net_require_ipv6 is now in tst_net_setup() instead in
tst_net_parse_args().

 testcases/lib/tst_net.sh | 69 ++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index b27b7e51c..29d80df89 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -59,6 +59,8 @@ tst_net_remote_tmpdir()
 
 tst_net_setup()
 {
+	[ "$TST_IPVER" = 6 ] && tst_net_require_ipv6
+
 	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 
@@ -98,6 +100,31 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
+tst_net_detect_ipv6()
+{
+	local type="${1:-lhost}"
+	local cmd='[ -f /proc/net/if_inet6 ]'
+	local ret
+
+	if [ "$type" = "lhost" ]; then
+		$cmd
+	else
+		tst_rhost_run -c "$cmd"
+	fi
+	ret=$?
+
+	if [ $ret -eq 0 ]; then
+		TST_NET_IPV6_ENABLED=1
+	else
+		tst_res TINFO "IPv6 disabled on $type"
+	fi
+}
+
+tst_net_require_ipv6()
+{
+	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
+}
+
 init_ltp_netspace()
 {
 	local pid
@@ -515,7 +542,9 @@ tst_init_iface()
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
-		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
+		if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+			sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
+		fi
 		ip link set $iface up
 		return $?
 	fi
@@ -527,7 +556,9 @@ tst_init_iface()
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
-	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
+	fi
 	tst_rhost_run -c "ip link set $iface up"
 }
 
@@ -604,7 +635,9 @@ tst_restore_ipaddr()
 	local ret=0
 	local backup_tst_ipv6=$TST_IPV6
 	TST_IPV6= tst_add_ipaddr $type $link_num || ret=$?
-	TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
+	fi
 	TST_IPV6=$backup_tst_ipv6
 
 	return $ret
@@ -936,6 +969,10 @@ tst_default_max_pkt()
 }
 
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
+
+# detect IPv6 support on lhost for tests which don't use test links
+tst_net_detect_ipv6
+
 [ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
 
 # Management Link
@@ -970,8 +1007,13 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 if [ -z "$_tst_net_parse_variables" ]; then
 	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
 	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
+
+	tst_net_detect_ipv6 rhost
+
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
+		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
+	fi
 fi
 
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
@@ -980,19 +1022,26 @@ if [ -z "$_tst_net_parse_variables" ]; then
 	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
 	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
 		|| echo "exit $?")
-	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
-		|| echo "exit $?")
+
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
+		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
+			|| echo "exit $?")
+	fi
 
 	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
 		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
-	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
-		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
+
+	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
+			$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
+	fi
 
 	tst_res_ TINFO "Network config (local -- remote):"
 	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
 	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
 	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+
 	export _tst_net_parse_variables="yes"
 fi
 
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
