Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B06C54EAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:55:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEFD43CD355
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:55:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA4B23CD354
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BCDB11000A5E
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D3D7821CE0;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSlqSulkOhhl6S44JHoPABKoxo2SW/5X43ERAj8X6fU=;
 b=DRzk0LjeVYXyXyr6pJV9iSeIRbteM+lrL1pxfUhIVSBsxZItebeEWehmy84TyBY35RbFnS
 LdWEKVWDKgqlcu/ZUEj+o9zaGICoQog2agjjD4tLU/YKJjrynikeGeOscX6xrY+8anUhVS
 42BCQKN+eR8FtJOdk0V2SRs2xkDbKlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSlqSulkOhhl6S44JHoPABKoxo2SW/5X43ERAj8X6fU=;
 b=4+sfL76ill3FH0CmRxAkGRlvYNoPIi1VRDprFyEfsizcF/ZZXB/Z086BKRESe/fIoHEEF0
 wLeTmYXMENVhZtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9500139B3;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4ElKJ4D20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:54:00 +0100
Message-Id: <20230126215401.29101-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/9] tst_net.sh: Harden on disabled IPv6 via sysctl
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

Detect IPv6 can be disabled via sysctl (for both netns or on ssh based
links) and tests than fails:

    # sysctl net.ipv6.conf.ltp_ns_veth2.disable_ipv6=1
    # TST_NET_RHOST_RUN_DEBUG=1 ./ping02.sh -6
    ping02 1 TINFO: tst_rhost_run: cmd: [ -f /proc/net/if_inet6 ]
    ping02 1 TINFO: NETNS: sh -c " [ -f /proc/net/if_inet6 ] || echo RTERR" 2>&1
    ping02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ping02 1 TINFO: add local addr 10.0.0.2/24
    ping02 1 TINFO: add local addr fd00:1:1:1::2/64
    RTNETLINK answers: Permission denied
    ping02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    ...
    ping02 1 TINFO: timeout per run is 0h 5m 0s
    ping6: connect: Network is unreachable
    ping02 1 TFAIL: ping6 -I ltp_ns_veth2 -c 3 -s 8 -f -p 000102030405060708090a0b0c0d0e0f fd00:1:1:1::1 >/dev/null failed unexpectedly

Therefore detect IPv6 disabled via sysctl:
1) tst_init_iface - to avoid setting net.ipv6.conf.$iface.accept_dad=0.
tst_init_iface is called by tst_restore_ipaddr, which is called by
init_ltp_netspace (netns) at the start of testing.
2) For ssh are all devices tested at the start.

There are guards in both functions to avoid repeated checks (e.g.
tst_restore_ipaddr() it's also cleanup function for some tests therefore
called by both netns and ssh).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 518a3ed579..7ee8594a54 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -126,6 +126,43 @@ tst_net_require_ipv6()
 	[ "$TST_NET_IPV6_ENABLED" = 1 ] || tst_brk_ TCONF "IPv6 disabled"
 }
 
+# Detect IPv6 disabled via sysctl.
+tst_net_detect_ipv6_sysctl()
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
+tst_net_check_ifaces_ipv6()
+{
+	local iface
+
+	for iface in $(tst_get_ifaces); do
+		tst_net_detect_ipv6_sysctl || return
+	done
+
+	for iface in $(tst_get_ifaces rhost); do
+		tst_net_detect_ipv6_sysctl $iface rhost || return
+	done
+}
+
 init_ltp_netspace()
 {
 	local pid
@@ -531,7 +568,9 @@ tst_init_iface()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 	local iface="$(tst_iface $type $link_num)"
+
 	tst_res_ TINFO "initialize '$type' '$iface' interface"
+	tst_net_detect_ipv6_sysctl $iface $type
 
 	if [ "$type" = "lhost" ]; then
 		if ip xfrm state 1>/dev/null 2>&1; then
@@ -1015,6 +1054,7 @@ if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
 fi
 
 tst_net_use_netns && init_ltp_netspace
+tst_net_check_ifaces_ipv6
 
 eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
 eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
