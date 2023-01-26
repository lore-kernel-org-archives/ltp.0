Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920CFC54EAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A113CD36B
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:55:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08EE73CC7C7
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E87C814010FC
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6678521CBE;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFW+cU2mo0aueEbbXhGdYftJB8DJTJI5APmB0Z0sa78=;
 b=sjL0J1nOGgY/Yn9j1qgtMlRV/1Xp8SgDtX1syd01LPLENzM9DWe3gObyy2srx0vqC0hZsO
 g20Bil/N5xVtvgkFqebC864KtucWz2q6onJMCB/C+CDngbtG8GZvfHAQuQxnoMRx761Hy3
 wo15Jfe9fVcB4BzLHtKMPqRTjBua3Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFW+cU2mo0aueEbbXhGdYftJB8DJTJI5APmB0Z0sa78=;
 b=1U1Dxu1v8BlqvfhtEaHgQm7vrnoK2Y/QCyDeT4WIj1I51O0yMgsGPtfUk4QAHcD9vMn99h
 o2gwFUXHJRs20NDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3932E139B3;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cA74C4D20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:58 +0100
Message-Id: <20230126215401.29101-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/9] tst_net.sh: Rename function + add doc
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

Rename tst_net_detect_ipv6() to tst_net_detect_ipv6_cmdline() because
there will be another function to detect IPv6 disabled via sysctl.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 6cb9f02a5f..3a9c16f070 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -100,7 +100,10 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
-tst_net_detect_ipv6()
+# detect IPv6 not disabled via ipv6.disable=1 kernel cmdline parameter
+# or via CONFIG_IPV6=y kernel configure option
+# $TST_NET_IPV6_ENABLED: 1 (enabled), 0 (disabled)
+tst_net_detect_ipv6_cmdline()
 {
 	local type="${1:-lhost}"
 	local cmd='[ -f /proc/net/if_inet6 ]'
@@ -970,7 +973,7 @@ tst_default_max_pkt()
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
 # detect IPv6 support on lhost for tests which don't use test links
-tst_net_detect_ipv6
+tst_net_detect_ipv6_cmdline
 
 [ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
 
@@ -1007,7 +1010,7 @@ tst_require_cmds tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
 eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
 eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
 
-[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6 rhost
+[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6_cmdline rhost
 
 if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
 	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
