Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CEAC05027
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48E0F3CC7D8
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:55:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759453CC75C
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A423814010FB
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFBDC1F8A8;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GETrtImuGVaJDIuSVddU6IQEW7phT8/t00L+uMsr9Kc=;
 b=KJcDU1MTXvFMdHbiihyDUIQIXc27CCE8GEo9MOnptC+GFdNejIy8aIBa2Y1EIHAb8ZXx0x
 REv/kzdVc6C4c3MIeifJH0rQdMMBxpxogp1yUwMrThNNNCJ32sB/k6QqhAZdUWnIRJ5W3C
 BPHX46Au4iUqa8SIqI6sbvb4FbGQOVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GETrtImuGVaJDIuSVddU6IQEW7phT8/t00L+uMsr9Kc=;
 b=4VQZrvbYIrZ6UgGwUjojCLdmJrwHtBPKxKMdQ8OnvOFkG0d76eI0w0VXgYEiKDPanBCXd4
 Eqj00M5LsKhjorBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6FD5139B3;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4DHRJn/20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:56 +0100
Message-Id: <20230126215401.29101-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] tst_net.sh: Remove unneeded $TST_INIT_NETNS
 variable
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

Similarly to the previous commit, also $TST_INIT_NETNS guarder is not
needed since a93c34f914 which introduced $TST_LIB_NET_LOADED guarder at
the top of the file.

Also use tst_net_use_netns() instead of the variable (encapsulation).

Fixes: a93c34f914 ("tst_net.sh: Introduce TST_LIB_NET_LOADED")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 1b3a7e6683..425f0b8b7e 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -150,8 +150,6 @@ init_ltp_netspace()
 	LHOST_IFACES="${LHOST_IFACES:-ltp_ns_veth2}"
 	RHOST_IFACES="${RHOST_IFACES:-ltp_ns_veth1}"
 
-	export TST_INIT_NETNS="no"
-
 	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
 	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
 
@@ -1015,7 +1013,7 @@ if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
 	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
 fi
 
-[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
+tst_net_use_netns && init_ltp_netspace
 
 eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
 eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
