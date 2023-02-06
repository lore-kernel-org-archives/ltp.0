Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B942BC64EC3
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 17:03:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326D93CC240
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 18:03:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 040333C2730
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 18:03:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C0152001DB
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 18:03:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83909606E1;
 Mon,  6 Feb 2023 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675703010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqflvKKU5z+Hnugd3McuTk5/fCdSazq3jJ3fvDDzkTY=;
 b=DhpG6LpdIbceI1bTAVsqofOmMWB3bE2TMV0g/gnIRFJNFMgVfbEcggVP2eUZ4qWAOykl3f
 +9GTgV/weqeKgjW0913YHV4qIgaOwYOFh03kPproeqTyFZyc+HbrUpLFxLetsLaScS6Fxc
 QPXbZQkPeI1UUN8dF+Sdb/b12pSIMD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675703010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vqflvKKU5z+Hnugd3McuTk5/fCdSazq3jJ3fvDDzkTY=;
 b=XMKIPAV59iBP+SEGlBpfMWpoCn33nvtF4OnZ08RB8vGrA5J08ROhWcFqRb/EFMdGzsl6tj
 VjKiw4DOii45hcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36B23138E8;
 Mon,  6 Feb 2023 17:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G9qRCuIy4WP2IgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 17:03:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Feb 2023 18:03:25 +0100
Message-Id: <20230206170325.19813-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] iptables_lib.sh: Fix for iptables-translate >=
 v1.8.9
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
Cc: netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

iptables-translate <= v1.8.8 didn't use quotes:
$ iptables-translate -A INPUT -s 127.0.0.1 -p icmp -j DROP
nft add rule ip filter INPUT ip protocol icmp ip saddr 127.0.0.1 counter drop

iptables-translate since v1.8.9 started to add quotes:
$ iptables-translate -A INPUT -s 127.0.0.1 -p icmp -j DROP
nft 'add rule ip filter INPUT ip protocol icmp ip saddr 127.0.0.1 counter drop'

That broke nft01.sh test:

Error: syntax error, unexpected junk
'add rule ip filter INPUT ip protocol icmp ip saddr 127.0.0.1 counter drop'
^
nft01 1 TFAIL: nft command failed to append new rule

Therefore filter out also quotes (to existing backslash).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/iptables/iptables_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/iptables/iptables_lib.sh b/testcases/network/iptables/iptables_lib.sh
index ab76cbd416..7e138ea33b 100755
--- a/testcases/network/iptables/iptables_lib.sh
+++ b/testcases/network/iptables/iptables_lib.sh
@@ -22,7 +22,7 @@ NFRUN()
 	if [ "$use_iptables" = 1 ]; then
 		ip${TST_IPV6}tables $@
 	else
-		$(ip${TST_IPV6}tables-translate $@ | sed 's,\\,,g')
+		$(ip${TST_IPV6}tables-translate $@ | sed "s/[\']//g")
 	fi
 }
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
