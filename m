Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5439C433FE
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 22:04:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C8E3C92A4
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 23:04:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2119D3C8F4A
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:03:44 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02C8A60083C
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:03:44 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 l35-20020a05600c1d2300b0034d477271c1so372961wms.3
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iiRs4WSXRGx2bH5OriEhocjiz6dhs5fUbW2MS8geM6U=;
 b=PWInY4VHtK2STAhQQHQZKQEFnF55SQL0lmnennlyUru9Jowz0ChOBLAh7kvyfKB5WE
 uPtgWbFjuFZ+bh3WEGOZz21bcJM7RAFV9UCv1DHS2dYWWKsGzcfqn4mZ1biJehrBgRE3
 VlQ83H3eC2qBLaFM+HDzibLraS5tJs7gro/qyoUpZ16ql+kYOurSU8VRloIKDOMdG6Z4
 YZiKVEh7PBxseK8vPDE5vxfeKWa626MoZqsfksCpAvi8Lgvhrhz/V3fKZaSmK4e43GV5
 ShdIs8u5BllyfY1jp5dRzNXhEZ7YDVTJTCZrf4UwqqWkqBngJjnEKMsU3+0jZ6uM/+Ke
 5e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iiRs4WSXRGx2bH5OriEhocjiz6dhs5fUbW2MS8geM6U=;
 b=FdBuWN6C9IBlipm4OGW6zZnzBtQItGGt3iJ1yQF88OcvG8TrGZegT90nHsUBWY6M7h
 rrXpghNJMYeVhsiOmYpSQNvOeMkp81D8t2KQOX/JvbtqYKr3P8Cm7rCKxiQj3rs8eB9r
 dgzO2otF6lCtCrYKrHk/Il94u/YBYuJjqYB6TF3o7+pOMiLj+Eqc+lOBO6CBtIUedYFr
 PRFDVkR8LwETuB4rz0MUIxi6zll9n2c7o7lsnVEVD3RC3tYmD4j3dtoI+z1UyWmMrcyU
 luZl3ygnugQDOW+Pde/P3mvRSX+5S+6zKr3M/8z6MjyWxEDmeOI9r9Brol8elrPqyeDC
 v4YA==
X-Gm-Message-State: AOAM532Wcw+0WKTVBX5KT6VbZ7P90ucWke+WGFR7Kriadeco37ooa3id
 iSdRpdXXLkyy7CReyo1+gIzH+L7BIfmzGD3E
X-Google-Smtp-Source: ABdhPJxWa9Lev93E00k01JzT4LAX77CwvAewvOA0KmwLOOuCLJhemSFjZ9ZE0RPFOsVgHBPPTHISrA==
X-Received: by 2002:a1c:1f84:: with SMTP id f126mr289397wmf.54.1643061823313; 
 Mon, 24 Jan 2022 14:03:43 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id n14sm457789wmq.42.2022.01.24.14.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 14:03:42 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 24 Jan 2022 23:03:33 +0100
Message-Id: <20220124220334.154003-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_net.sh: Fix for disabled IPv6
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

From: Petr Vorel <pvorel@suse.cz>

Tests failed in tst_init_iface even IPv4 only test was run.
Allow to init interfaces at least for IPv4.

Tests which use TST_IPV6=6 needs to be fixed (unless they use
just tst_ipaddr_un()).

Store result into TST_NET_{L,R}HOST_IPV6 in order to cache the result.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* cache variables with $TST_NET_{L,R}HOST_IPV6 (mdoucha)
NOTE: although I'd prefer to cache the result internally and use
function for detection, tst_net.sh uses variables for most of the
things, thus keep it this way.

Kind regards,
Petr

 testcases/lib/tst_net.sh | 72 ++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 4dc0fca92..d1ae3042a 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -24,7 +24,9 @@ TST_IPV6_FLAG=${TST_IPV6_FLAG:-}
 tst_net_parse_args()
 {
 	case $1 in
-	6) TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6";;
+	6)  tst_net_require_ipv6
+		TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6"
+		;;
 	*) [ "$TST_PARSE_ARGS_CALLER" ] && $TST_PARSE_ARGS_CALLER "$1" "$2";;
 	esac
 }
@@ -100,6 +102,30 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
+tst_net_detect_ipv6()
+{
+	local type="${1:-lhost}"
+	local cmd='[ -f /proc/net/if_inet6 ]'
+
+	if [ "$type" = "lhost" ]; then
+		$cmd
+		return $?
+	fi
+
+	tst_rhost_run -c "$cmd"
+	return $?
+}
+
+tst_net_require_ipv6()
+{
+	local err="IPv6 not supported on:"
+	local missing
+
+	[ "$TST_NET_LHOST_IPV6" = 1 ] || missing=" lhost"
+	[ "$TST_NET_RHOST_IPV6" = 1 ] || missing="$missing rhost"
+	[ -z "$missing" ] || tst_brk_ TCONF "$err$missing"
+}
+
 init_ltp_netspace()
 {
 	local pid
@@ -517,7 +543,9 @@ tst_init_iface()
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
-		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
+		if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
+			sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
+		fi
 		ip link set $iface up
 		return $?
 	fi
@@ -529,7 +557,9 @@ tst_init_iface()
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
-	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
+	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
+		tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
+	fi
 	tst_rhost_run -c "ip link set $iface up"
 }
 
@@ -606,7 +636,9 @@ tst_restore_ipaddr()
 	local ret=0
 	local backup_tst_ipv6=$TST_IPV6
 	TST_IPV6= tst_add_ipaddr $type $link_num || ret=$?
-	TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
+	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
+		TST_IPV6=6 tst_add_ipaddr $type $link_num || ret=$?
+	fi
 	TST_IPV6=$backup_tst_ipv6
 
 	return $ret
@@ -971,8 +1003,16 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 if [ -z "$_tst_net_parse_variables" ]; then
 	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
 	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
+
+	tst_net_detect_ipv6 && TST_NET_LHOST_IPV6=1
+	tst_net_detect_ipv6 rhost && TST_NET_RHOST_IPV6=1
+
+	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
+		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
+	fi
+	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
+		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
+	fi
 fi
 
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
@@ -981,19 +1021,29 @@ if [ -z "$_tst_net_parse_variables" ]; then
 	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
 	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
 		|| echo "exit $?")
-	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
-	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
-		|| echo "exit $?")
+
+	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
+		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
+	fi
+
+	if [ "$TST_NET_RHOST_IPV6" = 1 ]; then
+		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
+			|| echo "exit $?")
+	fi
 
 	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
 		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
-	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
-		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
+
+	if [ "$TST_NET_LHOST_IPV6" = 1 ]; then
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
