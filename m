Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92310C64EC4
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 15:11:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29FF13CBE8C
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 16:11:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D75E3CBE51
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7DAE2200A06
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 141CA34130;
 Fri, 17 Feb 2023 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676646643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebVUsn+92IiKLbHpFpzg1xO0OIveUyWD3P9lUBYOLVo=;
 b=wMG1/gzeBmM8nTAMNjP7ILaOrkGYnz618UNNmv/6TL1aO/F9MkwBTxyt30WBjmB3tBoD0U
 HUIMI0qXW4gq4FAPNYalhzIzbT2K2sJKJWndBehx9zPWfgTii4424e3SRH3b/1Eoz9iXly
 Pi53FcqGm+VzTbvTjfAj2o+cwrhsunQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676646643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebVUsn+92IiKLbHpFpzg1xO0OIveUyWD3P9lUBYOLVo=;
 b=z4ig1cc46SI2AjMqCfjU4zZlGg5W80Bnxmf6CBHdNsv5q1RooDlaoWatp4HG2vRszUGUvT
 CXFIes5QN5+jybCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE568138E3;
 Fri, 17 Feb 2023 15:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WHiSLvKY72MSMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 15:10:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Feb 2023 16:10:36 +0100
Message-Id: <20230217151036.10295-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217151036.10295-1-pvorel@suse.cz>
References: <20230217151036.10295-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tst_net.sh: Detect IPv6 disabled on interface
 via sysctl
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

IPv6 on interface can be also disabled by sysctl
net.ipv6.conf.$iface.disable_ipv6=1. This is better to be checked:
* for all interfaces before run (can be disabled even for netns
  interface previously created).
* before ip addr command tries to work with IPv6 (in tst_init_iface()
  and tst_add_ipaddr(), other functions should run these before)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 96eed50793..f414dd9359 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -121,6 +121,47 @@ tst_net_detect_ipv6()
 	TST_NET_IPV6_ENABLED=1
 }
 
+# Detect IPv6 disabled on interface via sysctl
+# net.ipv6.conf.$iface.disable_ipv6=1.
+# $TST_NET_IPV6_ENABLED: 1 on IPv6 enabled, 0 on IPv6 disabled.
+# return: 0 on IPv6 enabled, 1 on IPv6 disabled.
+tst_net_detect_ipv6_iface()
+{
+	[ "$TST_NET_IPV6_ENABLED" = 1 ] || return 1
+
+	local iface="$1"
+	local type="${2:-lhost}"
+	local check="sysctl -n net.ipv6.conf.$iface.disable_ipv6"
+	local disabled
+
+	if [ "$type" = "lhost" ]; then
+		disabled=$($check)
+	else
+		disabled=$(tst_rhost_run -c "$check")
+	fi
+	if [ $disabled = 1 ]; then
+		tst_res_ TINFO "IPv6 disabled on $type on $iface"
+		TST_NET_IPV6_ENABLED=0
+		return 1
+	fi
+
+	return 0
+}
+
+# Detect IPv6 disabled on used interfaces.
+tst_net_check_ifaces_ipv6()
+{
+	local iface
+
+	for iface in $(tst_get_ifaces); do
+		tst_net_detect_ipv6_iface || return
+	done
+
+	for iface in $(tst_get_ifaces rhost); do
+		tst_net_detect_ipv6_iface $iface rhost || return
+	done
+}
+
 tst_net_require_ipv6()
 {
 	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
@@ -531,7 +572,9 @@ tst_init_iface()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 	local iface="$(tst_iface $type $link_num)"
+
 	tst_res_ TINFO "initialize '$type' '$iface' interface"
+	tst_net_detect_ipv6_iface $iface $type
 
 	if [ "$type" = "lhost" ]; then
 		if ip xfrm state 1>/dev/null 2>&1; then
@@ -591,6 +634,8 @@ tst_add_ipaddr()
 	local link_num="${2:-0}"
 	local iface=$(tst_iface $type $link_num)
 
+	tst_net_detect_ipv6_iface $iface $type
+
 	if [ "$TST_IPV6" ]; then
 		dad="nodad"
 		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
@@ -1005,6 +1050,7 @@ tst_net_setup_network()
 		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
 
 	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+		tst_net_check_ifaces_ipv6
 		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
 		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
 			|| echo "exit $?")
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
