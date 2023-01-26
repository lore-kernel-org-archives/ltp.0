Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25187C54EAA
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:55:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 484CC3CD373
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:55:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227013CD351
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C74F1601357
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E5AB21CDA;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+coZMfdIxH0MIoLlumza3DGHqOAPIwOoCAshKdHYvw=;
 b=THNeee9uQBG/JiKkTJ7P5eWH7NAklzFu5cA9x6iUwcYoHL5jARFqu2xAXrhUE+IkrXCdPz
 2DJnY0y4pXUa1+FW1qATtqZ0Xu0WniXb8VQKdVSSEa9TJvOHzXYkqxC93ESfCNjhqyRTQs
 7JLLlqMcaLsnqNALFqOWYfW+j1pceag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+coZMfdIxH0MIoLlumza3DGHqOAPIwOoCAshKdHYvw=;
 b=CHyaL/6DTZ0dJmLdJRhZFDiPklfhkpB6dqh5hQc5ymLRe9MzbGIgc+2FnqT4zcB1xsmYPM
 AURVY8tAr13vcVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71CDD139B3;
 Thu, 26 Jan 2023 21:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YDQpGoD20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:59 +0100
Message-Id: <20230126215401.29101-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] tst_net.sh: Remove unused variable ret
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

$? is enough in tst_net_detect_ipv6_cmdline().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 3a9c16f070..518a3ed579 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -100,23 +100,20 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
-# detect IPv6 not disabled via ipv6.disable=1 kernel cmdline parameter
-# or via CONFIG_IPV6=y kernel configure option
-# $TST_NET_IPV6_ENABLED: 1 (enabled), 0 (disabled)
+# Detect IPv6 disabled via ipv6.disable=1 kernel cmdline parameter
+# or via CONFIG_IPV6=y kernel configure option.
 tst_net_detect_ipv6_cmdline()
 {
 	local type="${1:-lhost}"
 	local cmd='[ -f /proc/net/if_inet6 ]'
-	local ret
 
 	if [ "$type" = "lhost" ]; then
 		$cmd
 	else
 		tst_rhost_run -c "$cmd"
 	fi
-	ret=$?
 
-	if [ $ret -eq 0 ]; then
+	if [ $? -eq 0 ]; then
 		TST_NET_IPV6_ENABLED=1
 	else
 		TST_NET_IPV6_ENABLED=0
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
