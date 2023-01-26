Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86D8C05027
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:54:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E822D3CD36B
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:54:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59A0A3CC77B
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DCBEF1000A5E
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BADF1FF2E;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsHAT0ECd/D4JtsUBEI4Y70oYCdfJxmBS1FMBd2gqnA=;
 b=sJx9jLiJboBJsGJhmb8n1ab4RUsv13buJG348QTu/eNew3bboa2SoLhjkHe25cUdo1HUXk
 wwGx0YhsBjrj4rVsv1PSiZo93X9Gou3FVGU/yGzpbQte8BT5xzxT7aClJyP3GgJXYsReFp
 HmwY4gOsqtkMWXe231AaJQPuyjER3Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsHAT0ECd/D4JtsUBEI4Y70oYCdfJxmBS1FMBd2gqnA=;
 b=oYkSlbRwvY8GjI8ZppgHNmvSHpt83IQVBnuW6D1fzlgDHIiCs2oQd8TMbaCC8tOEqG7cPh
 3unaTKoYUIqz3HDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D56F139B3;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8GJTGH/20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:55 +0100
Message-Id: <20230126215401.29101-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/9] tst_net.sh: Remove unneeded
 $_tst_net_parse_variables
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

$_tst_net_parse_variables guarder (originally introduced as
$TST_PARSE_VARIABLES in 9aab3ffd55) was not needed any more since
a93c34f914 which introduced $TST_LIB_NET_LOADED guarder at the top of
the file.

was used as a guarder to protect running
configuration in case tst_net.sh was loaded more times.

Fixes: a93c34f914 ("tst_net.sh: Introduce TST_LIB_NET_LOADED")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 54 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index b76734210a..1b3a7e6683 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1005,47 +1005,41 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
 # tst_net_ip_prefix -h
 # tst_net_iface_prefix -h
 # tst_net_vars -h
-if [ -z "$_tst_net_parse_variables" ]; then
-	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
-	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
+eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
+eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
 
-	[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6 rhost
+[ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6 rhost
 
-	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
-		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
-	fi
+if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
+	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
 fi
 
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
 
-if [ -z "$_tst_net_parse_variables" ]; then
-	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
-	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
-		|| echo "exit $?")
-
-	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
-		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
-			|| echo "exit $?")
-	fi
-
-	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
-		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
+eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
+eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
+	|| echo "exit $?")
 
-	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
-		eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
-			$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
-	fi
+if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+	eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
+	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
+		|| echo "exit $?")
+fi
 
-	tst_res_ TINFO "Network config (local -- remote):"
-	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
-	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
-	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
+	$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
 
-	export _tst_net_parse_variables="yes"
+if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
+	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
+		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
 fi
 
+tst_res_ TINFO "Network config (local -- remote):"
+tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
+tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
+tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+
 export TST_NET_DATAROOT="$LTPROOT/testcases/bin/datafiles"
 
 export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
