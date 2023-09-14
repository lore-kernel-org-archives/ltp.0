Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E433BCA0EF6
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05DEA3CE744
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:50:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B424D3CE6FF
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:50:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 459D5605625
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:50:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 736022184E;
 Thu, 14 Sep 2023 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694695802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmkw9VZovuuoedHJbgQCpEAlnL9TFBwMG2n7CNIWr2U=;
 b=bARDxG0bpV/LWyw4Xue/Snrqy3QKwnESqQ5qZ0HLjh8SPQ5GFnpuJN9wehwW9FKUpjse7F
 aWmqjenuoo2aWyVVVItoOh2XeasJNbFi4I8JP5MmFZszuKqdBeTTgMNf5+8e/9h8IWDVmx
 UvEnM8VbkqlXiYlApJwsWvsBPG+A/ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694695802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmkw9VZovuuoedHJbgQCpEAlnL9TFBwMG2n7CNIWr2U=;
 b=/MZqbB18IcTNZRpeX+u2Mjdm2D0STXhSF19lfbWpXBFKXrKvFwyD8c2C1u+tSoKA+BrJXT
 NAGwKapstdtPHPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 517BF139F2;
 Thu, 14 Sep 2023 12:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SC4rE3oBA2UIPgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 14 Sep 2023 12:50:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
	ltp@lists.linux.it
Date: Thu, 14 Sep 2023 14:49:29 +0200
Message-ID: <20230914125001.21803-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914125001.21803-1-mdoucha@suse.cz>
References: <20230914125001.21803-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tcindex01: Simplify test
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

Changes since v1: Call tst_netdev_add_traffic_filter() in non-strict mode
and report meaningful results according to return/errno value.

 testcases/cve/tcindex01.c | 45 +++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 9bd7de9dd..91bfafb53 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -84,31 +84,26 @@ static void setup(void)
 
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
+	int ret;
+
+	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
+		qd_config);
+	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
+	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
+		"tcindex", f_config);
+	NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
+		1, "tcindex");
+	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,
+		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
+	TST_ERR = tst_rtnl_errno;
+	NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb");
+
+	if (ret)
+		tst_res(TPASS, "Removing tcindex filter works correctly");
+	else if (TST_ERR == EEXIST)
+		tst_res(TFAIL, "Kernel traffic filter list is corrupted");
+	else
+		tst_brk(TBROK | TTERRNO, "Unexpected rtnetlink error");
 }
 
 static void cleanup(void)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
