Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFFEC6379F
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 15:10:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2466A3CBE7E
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 16:10:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F3573CBE0D
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C0DC6011C4
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 16:10:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B56923412F;
 Fri, 17 Feb 2023 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676646642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9D9DqHcG49q9LQby8IGxbnBXvOUHgNfHxlq3yZ1PWs=;
 b=IkWxyefmh6i8Tg7Z9I3NidUnv8LSZyGXF5BR2BbrV1mx2Z4+MRcBJTauGMLfucqgoHRgtZ
 WHeugUdn2BTnm3SyKp3ytwKILkJz6hcHstMbF7nJrzLNf8yr02gwcNbLn/39uZRixfEE43
 fNLCUSzYyZxJfUzHOGuP8Js9WpgbSYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676646642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9D9DqHcG49q9LQby8IGxbnBXvOUHgNfHxlq3yZ1PWs=;
 b=aV0oC8VsWarvYQVfaf1U9LnUs1sh1uhiLfvNk8mT3WhddYMcc+MNJVg12syAIM+BGfLmeZ
 oykEGVcXwG97LJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 792BC138E3;
 Fri, 17 Feb 2023 15:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wDh5GvKY72MSMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 15:10:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Feb 2023 16:10:35 +0100
Message-Id: <20230217151036.10295-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217151036.10295-1-pvorel@suse.cz>
References: <20230217151036.10295-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_net.sh: Detect IPv6 disabled via sysct
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

net.ipv6.conf.all.disable_ipv6=1 disables IPv6 on all interfaces
(including both already created and later created).

The check prevent failures on IPv6 tests, and error messages on both
IPv4 and IPv4 tests:

    # sysctl -w net.ipv6.conf.all.disable_ipv6=1
    # ./ping02.sh -6
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

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fc64a588ae..96eed50793 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -84,25 +84,41 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
+# Detect IPv6 disabled via ipv6.disable=1 kernel cmdline parameter
+# or sysctl net.ipv6.conf.all.disable_ipv6=1 (disables IPv6 on all
+# interfaces (including both already created and later created).
+# $TST_NET_IPV6_ENABLED: 1 on IPv6 enabled, 0 on IPv6 disabled.
 tst_net_detect_ipv6()
 {
 	local type="${1:-lhost}"
 	local cmd='[ -f /proc/net/if_inet6 ]'
-	local ret
+	local disabled iface ret
 
 	if [ "$type" = "lhost" ]; then
 		$cmd
 	else
 		tst_rhost_run -c "$cmd"
 	fi
-	ret=$?
 
-	if [ $ret -eq 0 ]; then
-		TST_NET_IPV6_ENABLED=1
+	if [ $? -ne 0 ]; then
+		TST_NET_IPV6_ENABLED=0
+		tst_res_ TINFO "IPv6 disabled on $type via ipv6.disable=1"
+		return
+	fi
+
+	cmd='sysctl -n net.ipv6.conf.all.disable_ipv6'
+	if [ "$type" = "lhost" ]; then
+		disabled=$($cmd)
 	else
+		disabled=$(tst_rhost_run -c "$cmd")
+	fi
+	if [ $disabled = 1 ]; then
+		tst_res_ TINFO "IPv6 disabled on $type net.ipv6.conf.all.disable_ipv6=1"
 		TST_NET_IPV6_ENABLED=0
-		tst_res_ TINFO "IPv6 disabled on $type"
+		return
 	fi
+
+	TST_NET_IPV6_ENABLED=1
 }
 
 tst_net_require_ipv6()
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
