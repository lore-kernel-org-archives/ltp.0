Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC9CA0EEB
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 16:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 813433CE813
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 18:12:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70C8D3CB4CD
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 18:12:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4EC7200C14
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 18:12:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A8F21F45F
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694535151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3/4YFUsckc0FRHTb/NWmlXrGwOCT5s4rEIJZARE9o/A=;
 b=XuRJsLBTLknZqsDoUU/nJaVPH1QZywpmSQC6HzmEX8AMoFW8VRWW9K23EVy3etUofYidny
 rZB7MnYq1nL9HufqFC5ZsfqcQkXcJCJ0JO6aihnAWFNT4wxZkj7KJifrPhL9Kbca1RIEDa
 aINOR+toGGLwD+7SZllhmuPQHcx20Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694535151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3/4YFUsckc0FRHTb/NWmlXrGwOCT5s4rEIJZARE9o/A=;
 b=j8kRzgx5OooYQlbuzqZydDE494BP5Z1PDLS0HxIps74JKjunmdJPzgiPZR5gaHSuGUTmjn
 EqUbVc+K/AP8GUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF82A139DB
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tgbvM+6NAGUlDwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:12:30 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 18:12:25 +0200
Message-ID: <20230912161230.31983-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tcindex01: Simplify test
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

The bug can be reproduced simply by adding, removing and adding again
the same tcindex traffic filter. If the bug is present, the attempt
to add the removed filter again will fail with EEXIST error.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This change makes the test much faster by removing usleep() call and also
allows reliably reproducing the bug on kernels v4.x.

 testcases/cve/tcindex01.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 9bd7de9dd..eb1f01109 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -84,31 +84,18 @@ static void setup(void)
 
 static void run(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < 100; i++) {
-		NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle,
-			"htb", qd_config);
-		NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb",
-			cls_config);
-		NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
-			"tcindex", f_config);
-		NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
-			1, "tcindex");
-
-		/* Wait at least one jiffy for use-after-free */
-		usleep(10000);
-
-		NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle,
-			"htb");
-	}
-
-	if (tst_taint_check()) {
-		tst_res(TFAIL, "Kernel is vulnerable");
-		return;
-	}
-
-	tst_res(TPASS, "Nothing bad happened (yet)");
+	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
+		qd_config);
+	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
+	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
+		"tcindex", f_config);
+	NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
+		1, "tcindex");
+	tst_res(TINFO, "Trying to add removed tcindex filter again...");
+	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
+		"tcindex", f_config);
+	NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb");
+	tst_res(TPASS, "Removing tcindex filter works correctly");
 }
 
 static void cleanup(void)
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
