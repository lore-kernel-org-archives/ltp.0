Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0362C05027
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 17:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9ACE3CC157
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 18:01:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD0E3CC136
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 18:01:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AE43600971
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 18:01:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6E481FED5
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675875707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m7WBfwukV2ayHkq++jrdUSvv1LVFNVohB4Xd3kBCzTA=;
 b=XqWv49VeCkKxaDHJGJqW/oz3fqj3WNU2Fkb8BTaYCNk6eWX7mAvXCFU7PRvJrPrUrHtPZN
 vSapOT4JOSEQzlCdVz8J+kuLvMq/Ae6V2bo54mr+a1C1DnHXOxvB+SQfHDcDbLYA6en9Wl
 uYHalfY6gqeG/szuSfeH3dSrFuzMzWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675875707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m7WBfwukV2ayHkq++jrdUSvv1LVFNVohB4Xd3kBCzTA=;
 b=HSlQNz1I9QjkDyljmLUieyKtleyv1kmg7NX6QL5BmAV1wz16MepuQv9HKspI/i1MzfYQwN
 w+bpBHClrwIw2oDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83B8913425
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 17:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NwFXH3vV42MZaAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 08 Feb 2023 17:01:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Feb 2023 18:01:46 +0100
Message-Id: <20230208170146.22193-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ipneigh01.sh: Do not resolve hostnames when using arp
 -a
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

Unresolvable IP addresses can cause test timeouts.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 644a1fb8d..e67ff5cc8 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -25,7 +25,7 @@ do_setup()
 		if [ -n "$TST_IPV6" ]; then
 			tst_brk TCONF "'arp' doesn't support IPv6"
 		fi
-		SHOW_CMD="arp -a"
+		SHOW_CMD="arp -an"
 		DEL_CMD="ROD arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
 		;;
 	*)
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
