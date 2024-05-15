Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E12C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:49:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9593CF7B1
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:49:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6A5A3CF154
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:48:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 786561400043
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:48:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF675204AA
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715766533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vt8CwEO1Mx3lM4yy7q0raD+nKro27/1GFTVgXaxy0HM=;
 b=v+UyArleqy1NQFL7slJ4knBAErKYXuHYZ3k/L2Z+qFccpqFVnSWbrM2sE6RYGc7a4o1jC4
 S10cw/NUh0Qq83McQnOLs+nGdpXfCRAGOWDRzF9sSlC6RuBcDKNqgtqc5K80rNnEV79+Hg
 cBqsZXtA22nvRPi+EydK1o2njmDRiWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715766533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vt8CwEO1Mx3lM4yy7q0raD+nKro27/1GFTVgXaxy0HM=;
 b=QhTwEbY2H+nxlZp2MmrWrZG6kBdfJZdLXth4yVNEz5SJegnfWCfOjLfim9RIwpN/xuP9w6
 aiJ0/3giQT1kvZDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715766533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vt8CwEO1Mx3lM4yy7q0raD+nKro27/1GFTVgXaxy0HM=;
 b=v+UyArleqy1NQFL7slJ4knBAErKYXuHYZ3k/L2Z+qFccpqFVnSWbrM2sE6RYGc7a4o1jC4
 S10cw/NUh0Qq83McQnOLs+nGdpXfCRAGOWDRzF9sSlC6RuBcDKNqgtqc5K80rNnEV79+Hg
 cBqsZXtA22nvRPi+EydK1o2njmDRiWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715766533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vt8CwEO1Mx3lM4yy7q0raD+nKro27/1GFTVgXaxy0HM=;
 b=QhTwEbY2H+nxlZp2MmrWrZG6kBdfJZdLXth4yVNEz5SJegnfWCfOjLfim9RIwpN/xuP9w6
 aiJ0/3giQT1kvZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5EA1372E
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CqgrMgWFRGZHawAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:48:53 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:47:52 +0200
Message-ID: <20240515094753.1072-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tcindex01: Pass if the tcindex module is blacklisted
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

The tcindex01 test currently fails if the tcindex module is enabled
in kernel config but cannot be autoloaded. Some distros chose
to blacklist the module rather than remove it completely, thus
check for autoload failure and pass in that case.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/tcindex01.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 70e5639f1..07239f9c0 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -106,8 +106,19 @@ static void run(void)
 	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
 		qd_config);
 	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
-	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
-		"tcindex", f_config);
+	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,
+		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
+	TST_ERR = tst_netlink_errno;
+
+	if (!ret && TST_ERR == ENOENT) {
+		tst_res(TPASS | TTERRNO,
+			"tcindex module is blacklisted or unavailable");
+		return;
+	}
+
+	if (!ret)
+		tst_brk(TBROK | TTERRNO, "Cannot add tcindex filter");
+
 	NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
 		1, "tcindex");
 	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
