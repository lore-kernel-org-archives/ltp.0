Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6268C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 16:49:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35FD53CA113
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 17:49:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0355B3C0204
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:48:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 441D4601DAF
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:48:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62996219A8;
 Fri, 18 Feb 2022 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645202932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wsfhlk1TEEuXxKCXD3tLsRnBF1okkiwBzkvdh+FYEYE=;
 b=lprte65vNISfdsIpYzghswVdfG/9EsNLjddlr7+yrh6FkUzZlHfy8QsMKk+BO5dclYLHpc
 zoYsE8PWv0rVCzwvk/ZX5/U5nt24nH3Cf2p2nVqeuxOxfZ78a36gOBgjTKGOZ11yF8Gifc
 3pU8JAzSIYgs9KezWNTqXEEgBWzcQvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645202932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wsfhlk1TEEuXxKCXD3tLsRnBF1okkiwBzkvdh+FYEYE=;
 b=HuamBMEvjgen3u33eKrKVxWNMrLBPoAgNUts8LaAfN6ocvqOuS3LyXM7bR6Na6kB7DRZ5z
 cYFqUiCaxGPFgMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F040513CB6;
 Fri, 18 Feb 2022 16:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tRtpOPPND2IwSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 16:48:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Feb 2022 17:48:45 +0100
Message-Id: <20220218164845.11501-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?b?W1JGQ8WKW0RPX05PVF9NRVJHRV1bUEFUQ0ggdjIgMS8xXSBu?=
 =?utf-8?q?etstress=3A_Fix_race_between_SETSID=28=29_and_exit=280=29?=
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

******* DO NOT MERGE *******

There is a race between the SETSID() and exit(0) in move_to_background()
caused by "Killed the leftover descendant processes" introduced in
72b172867 ("Terminate leftover subprocesses when main test process
crashes").

If the main test process calls exit(0) before the newly forked child
managed to do SETSID() it's killed by the test library because it's
still in the old process group. Therefore use TST_CHECKPOINT_{WAIT,WAKE}()
to avoid the race.

Link: https://lore.kernel.org/ltp/Yg+RXbUTOxK56iZa@pevik/

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This patch somehow cause server to think that "client asks to terminate"
server_fn():

void *server_fn(void *cfd)
{
	...
	/* client asks to terminate */
	if (recv_msg[0] == start_fin_byte) {
		tst_res(TINFO, "client asks to terminate");
		goto out;
	}

This is really strange, because because server shouldn't do anything
before exit(), I miss something here.

Kind regards,
Petr

tcp_ipsec 1 TINFO: timeout per run is 0h 5m 0s
tcp_ipsec 1 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.9uqaI9HX3i'
tcp_ipsec 1 TINFO: run client 'netstress -l -H 10.0.0.1 -n 100 -N 100 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times

=> PROBLEM HERE
netstress.c:588: TINFO: client asks to terminate
netstress.c:644: TBROK: Server closed

tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
netstress.c:901: TINFO: connection: addr '10.0.0.1', port '34989'
netstress.c:902: TINFO: client max req: 100
netstress.c:903: TINFO: clients num: 2
netstress.c:908: TINFO: client msg size: 100
netstress.c:909: TINFO: server msg size: 100
netstress.c:823: TINFO: tcp_tw_reuse is already set
netstress.c:953: TINFO: TCP client is using old TCP API.
netstress.c:795: TINFO: '/proc/sys/net/ipv4/tcp_fastopen' is 1
netstress.c:476: TINFO: Running the test over IPv4
netstress.c:503: TINFO: total time '4' ms
netstress.c:521: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
tcp_ipsec 1 TFAIL: can't read tst_netload.res
tcp_ipsec 1 TINFO: AppArmor enabled, this may affect test results
tcp_ipsec 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
tcp_ipsec 1 TINFO: loaded AppArmor profiles: none

 testcases/network/netstress/netstress.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 0914c65bd4..6c9e83112e 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -713,11 +713,15 @@ static void server_cleanup(void)
 
 static void move_to_background(void)
 {
-	if (SAFE_FORK())
+	if (SAFE_FORK()) {
+		TST_CHECKPOINT_WAIT(0);
 		exit(0);
+	}
 
 	SAFE_SETSID();
 
+	TST_CHECKPOINT_WAKE(0);
+
 	close(STDIN_FILENO);
 	SAFE_OPEN("/dev/null", O_RDONLY);
 	close(STDOUT_FILENO);
@@ -1024,4 +1028,5 @@ static struct tst_test test = {
 		{"B:", &server_bg, "Run in background, arg is the process directory"},
 		{}
 	},
+	.needs_checkpoints = 1,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
