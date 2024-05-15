Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6130FC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:44:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3183CF8D0
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:44:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B8A3CAEB6
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:44:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 57B731B60EF0
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:44:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96A4133BE2
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMVE5sOXjXe+Lqwl0IxDptsuRcCr6RpxinY6boKtiog=;
 b=xHeGNx3EESSjOie20CDE0d5NAAmoBK1CcbTHq5xXb+qva1/CMxR2+0Uk8FiOLFJUeby6+g
 4tkZPli1rqz6DrPyU4JqwCjbmyLda2yqSdPm1SfWPHDgRUeRQtAoxul5i9r9P0liB9pwnD
 zxgtfKNocBZOI+2XCovufavL7dUvHU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMVE5sOXjXe+Lqwl0IxDptsuRcCr6RpxinY6boKtiog=;
 b=lIR7AL+k6vdbGjrmbBdoqy+7EDagJrtj1aGtfIfqUyLxdffkZ22RLB5dKJwrDkilATYC+Z
 B00Y5q9+6bAvv/DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xHeGNx3E;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lIR7AL+k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMVE5sOXjXe+Lqwl0IxDptsuRcCr6RpxinY6boKtiog=;
 b=xHeGNx3EESSjOie20CDE0d5NAAmoBK1CcbTHq5xXb+qva1/CMxR2+0Uk8FiOLFJUeby6+g
 4tkZPli1rqz6DrPyU4JqwCjbmyLda2yqSdPm1SfWPHDgRUeRQtAoxul5i9r9P0liB9pwnD
 zxgtfKNocBZOI+2XCovufavL7dUvHU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMVE5sOXjXe+Lqwl0IxDptsuRcCr6RpxinY6boKtiog=;
 b=lIR7AL+k6vdbGjrmbBdoqy+7EDagJrtj1aGtfIfqUyLxdffkZ22RLB5dKJwrDkilATYC+Z
 B00Y5q9+6bAvv/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 833C7139B3
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMjcH0C8RGY/ZwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 15:44:30 +0200
Message-ID: <20240515134432.27996-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515134432.27996-1-mdoucha@suse.cz>
References: <20240515134432.27996-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 96A4133BE2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tcindex01: Pass if the tcindex module is
 blacklisted
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

Changes since v1:
- Use NETDEV_ADD_TRAFFIC_FILTER_RET() macro instead of the underlying function

 testcases/cve/tcindex01.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 70e5639f1..e9c8a9a90 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -106,12 +106,23 @@ static void run(void)
 	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
 		qd_config);
 	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
-	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
-		"tcindex", f_config);
+	ret = NETDEV_ADD_TRAFFIC_FILTER_RET(DEVNAME, qd_handle, 10, ETH_P_IP,
+		1, "tcindex", f_config);
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
-	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,
-		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
+	ret = NETDEV_ADD_TRAFFIC_FILTER_RET(DEVNAME, qd_handle, 10, ETH_P_IP,
+		1, "tcindex", f_config);
 	TST_ERR = tst_netlink_errno;
 	NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb");
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
