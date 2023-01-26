Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE0BC61D97
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:54:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C38B3CD363
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:54:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2C43CC75C
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A87C76005EF
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 621061FEFB;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfFk3mNEH4vTFvXXhNrrkxvvmxoIzSH++jCBcySLRmQ=;
 b=pey9fqnztuaTLtf3KB5afCZxZSktUfvpn1ePRqF7PVa8qXNA2iP/vykVeKwCzAvMdx1WGY
 IXEtC7UgYtj6gWlkow2OU91vcTBccWC5Ee3f9Hvy0bsxGJl0Z1xvN2XeYFLM9ArwPcuu6+
 zQ9kEqMm+ccVbQ8tn6bPQ8b+4Cc2jek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfFk3mNEH4vTFvXXhNrrkxvvmxoIzSH++jCBcySLRmQ=;
 b=XNvkIgdhmocTe9EnTjK/5EMXiPNCymS7WwkeTfiGDk3+G1vquzLW7foxCzwoRLycczEj7u
 SI2PS8AnWjJqmuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F6F139B3;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AId1CH/20mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:54 +0100
Message-Id: <20230126215401.29101-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/9] tst_net.sh: Check for disabled IPv6 in legacy
 tests
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

Before tests timeout:

    # ./tcpdump01.sh -6

    tcpdump01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    tcpdump01 1 TINFO: add local addr 10.0.0.2/24
    tcpdump01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    tcpdump01 1 TINFO: add remote addr 10.0.0.1/24
    tcpdump01 1 TINFO: Network config (local -- remote):
    tcpdump01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    tcpdump01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
    tcpdump01 1 TINFO: fd00:1:1:1::2/64/ -- fd00:1:1:1::1/64/
    tcpdump01 1 TINFO: start ping6 in background
    tcpdump01 1 TINFO: running tcpdump...
    (timeout)

With this patch:
    tcpdump01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ...
    tcpdump01 1 TCONF: IPv6 disabled

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 925cf50e1c..b76734210a 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1094,6 +1094,7 @@ export NS_ICMPV6_SENDER_DATA_MAXSIZE=1452
 # in the following document: testcases/network/stress/README
 
 if [ -n "$TST_USE_LEGACY_API" ]; then
+	[ "$TST_IPVER" = 6 ] && tst_net_require_ipv6
 	tst_net_remote_tmpdir
 fi
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
