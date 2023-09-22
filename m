Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B95E6FE52
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 15:55:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE0573CE36C
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 17:55:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2102A3CBAB8
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 17:55:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69BDD10006B6
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 17:55:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AEB821CA0;
 Fri, 22 Sep 2023 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695398110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mf+HvXMMA9GS+uAyWDGerllDWXU5jjKIUUgSMhdLyiQ=;
 b=JuHrHQvGakPZv+zhoLkwV9f181sQDXsBcK2CbpZayZ7Rccu99i3HjuJS9PDuwHoiKOzoaC
 qJ90mmhglIRLmxGM5yAsB4w6B+Z7Xbf+ZjFRd9GLCV0Krb9NhdK/B3/fXjVNc8w3bqWobJ
 6Vy9wcPlbMXOLLHyOFidYgXrRpIQkKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695398110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mf+HvXMMA9GS+uAyWDGerllDWXU5jjKIUUgSMhdLyiQ=;
 b=P5G5CVOxBuuUc1wJhyWk28HbrdWgAMCf0+ls/95FBfWzXFzyn5OF3VRIqakvVrbqCzZHza
 5xmttJHPvqNp7FBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD27E13597;
 Fri, 22 Sep 2023 15:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mo+UMN24DWUuKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Sep 2023 15:55:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Sep 2023 17:55:07 +0200
Message-Id: <20230922155507.604020-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ipneigh01.sh: Add workaround for ARP timeout
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
Cc: Xu Senmiao <xusenmiao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Xu Senmiao <xusenmiao@huawei.com>

When the ARP status of the rhost is stale,
lhost ping rhost and the lhost deletes the ARP record,
the record in the rhost changes from stale to delay.

Then, the probe request is sent to the lhost, and the lhost ARP
information is updated.

   rhost(10.0.0.1)      lhost(10.0.0.2)
t1 10.0.0.2 STALE       ping 10.0.0.1
                        10.0.0.1 REACHABLE
                        arp -d 10.0.0.1
t2 10.0.0.2 DELAY
t3 probe 10.0.0.2
t4                      10.0.0.1 REACHABLE

Clear the ARP entries of rhost before each round of test.
This fixes an issue where ipneigh01_arp fail due to ARP timeout.

Signed-off-by: Xu Senmiao <xusenmiao@huawei.com>
[ pvorel: use $DEL_CMD ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Using DEL_CMD to fix working on system without arp installed.

Xu, can you confirm that it fixes your problem?
Also, do you have this problem also on IPv6?
Could you test both arp and ip?
Also, do you have any idea why rhost get stale?

Kind regards,
Petr

 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index e67ff5cc8..f37241d49 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -19,14 +19,14 @@ do_setup()
 	case $CMD in
 	ip)
 		SHOW_CMD="ip neigh show"
-		DEL_CMD="ROD ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
+		DEL_CMD="ip neigh del $(tst_ipaddr rhost) dev $(tst_iface)"
 		;;
 	arp)
 		if [ -n "$TST_IPV6" ]; then
 			tst_brk TCONF "'arp' doesn't support IPv6"
 		fi
 		SHOW_CMD="arp -an"
-		DEL_CMD="ROD arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
+		DEL_CMD="arp -d $(tst_ipaddr rhost) -i $(tst_iface)"
 		;;
 	*)
 		tst_brk TBROK "unknown or missing command, use -c [ arp | ip ]"
@@ -56,6 +56,7 @@ do_test()
 	tst_res TINFO "stress auto-creation $entry_name cache entry deleted with '$CMD' $NUMLOOPS times"
 
 	for i in $(seq 1 $NUMLOOPS); do
+		$DEL_CMD
 
 		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null || \
 			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
@@ -74,7 +75,7 @@ do_test()
 		[ "$ret" -ne 0 ] && \
 			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
 
-		$DEL_CMD
+		ROD $DEL_CMD
 
 		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
 			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
