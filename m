Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C68BC02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739514067; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=lzn2pNEYBTmUBixLdeKPdt1RNQTurUjdwStDELLvAZg=;
 b=UGV4e1j7iY2z/nV17HMDU3+2UK7jUOc564Z1zHF3yhmOZajfJzk7l7tF840OrM+VuuEMl
 bG7gh7Z+mVozxvzAAHhcf4/CdVvQhdqhN39ZuVcIx3ydm2frCHVQSoV64UMZcVyT4//gJoj
 +hPHqceCQd3TQRE+O2VBaM/PcU8CrB4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE2643C02C9
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 07:21:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB1BD3C02C9
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 07:20:47 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02ED51429EB8
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 07:20:46 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so17408975e9.1
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 22:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739514046; x=1740118846; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VThktRxOoJwugIGSRBXDnKg4J8HH4NW5xCCmJGM7MBk=;
 b=b/rYtwkRGW+4L4Zmq2B1BzvpTYTviaz4rHHlvjJTDiz440RlEt37CA76L+sWzYVf5x
 9pY7PCQ9CTbhz2wkuJnBJSZe1KFZyUaiaW/epbPgYwfzxOWCGecpXVC0V/BlskMychwh
 J1/ymd297HBM3Hm3rQPLUkDz+r0WBEtEvhnD5Eon0AnqKUDY7idGgRqKH0Q2NVNnvZOK
 Gk5pnPsq0NUlh81SoIG09vwa7vRP0c0uA6cuMBc9yxLcuor0psQIykG3M1i+QDcOI2S7
 HBgYVr6Or690Jjpeu6WNxB0BHLqnEyEcqC/fpkpCzdtIsx93OgzHXBINSalVPtnH1Va4
 KZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739514046; x=1740118846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VThktRxOoJwugIGSRBXDnKg4J8HH4NW5xCCmJGM7MBk=;
 b=rgfSLe5v0lRmNebuFOlXlH25GNr+Rhrjltf0ScTcufnMst/2nu6UfRr4Si/I2UDHfG
 InwA1moGWjR2FVZWa4MqUJ0r+TcF+nHLK1GIJEVc42FAEXffJ1qV1bM2LnO8Fqrb7dAW
 IoSg28yCBSvt/uxVTf9CEcXxx6cMeflojoSKOcuWYcA4thmIFF7r27dW5ytd4/mKMAxE
 ns8kTUO9iN82a1EmDjzHSr+yKg+CG7DqZhts7poUR/ZiSfbyDs4TIbvCKO5cb2qXjjL/
 CR8gosYF6Q5brxwgDxikxwjAkNNTYc3nCnUa/PIp566fWGaQKZ2UY+cKmq9a722rBgBr
 5ifA==
X-Gm-Message-State: AOJu0YyHtRQfrOjnQiD8ei+++ccg6CIAolj9a3/vk1V5JvwxKpKn5/Yt
 7YHDV1E6LaETQGhP6FGxsEghu4KhmDOAaWEiQYPainm8/WxAGmtyQiwik/pW79HK+YAvohr1BD0
 CyQ==
X-Gm-Gg: ASbGncv0vAFM5PhBVAdfcUZNXhldsFGgHZsVYbUmzDXqBu0S4O8ig0ZQLkW6H3EGPeL
 RCqb5ZNVnGuEXPxE1zbAINQ4gTPNQ4pAbSYwjQboNCSdcznidLuXy6ZV40UWS8Jsw6yw0TvfV3+
 fh/O7YThnlX+70D1Si3u+qBBEmXhk9aPSY9CRkYhwzGgmT+QPS0rx86tqNkZE34KAT/uoq11eQz
 h/xm0F5ULwKwGQQRtM6EjsCjyf62shvNIvvbuXRhI4NV54D7qO5C7OvRRnQcI85RjMIXT4ircJi
 c9qw
X-Google-Smtp-Source: AGHT+IHxmrUlmuiCdLeymJAD19lVlRaWOoxu+X07P7Qw2SYNwi9QGVTg9a7ypvmM470ecZlPaYGRHw==
X-Received: by 2002:a05:600c:190a:b0:439:6925:4d31 with SMTP id
 5b1f17b1804b1-4396925550cmr6700695e9.10.1739514045665; 
 Thu, 13 Feb 2025 22:20:45 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06c95bsm66158435e9.17.2025.02.13.22.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 22:20:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 14 Feb 2025 01:20:34 -0500
Message-Id: <20250214062034.29211-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mount_setattr01.c: Add clearing the attributes
 check
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../syscalls/mount_setattr/mount_setattr01.c  | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index e500df28e..aac487aa6 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -98,16 +98,47 @@ static void run(unsigned int n)
 	if (!TST_PASS)
 		goto out1;
 	mount_flag = 1;
+
+	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
+	if (!TST_PASS)
+		goto out2;
+
+	TST_EXP_EXPR(buf.f_flag & tc->expect_attrs, "%s set check pass", tc->name);
+
 	SAFE_CLOSE(otfd);
+	SAFE_UMOUNT(OT_MNTPOINT);
+	mount_flag = 0;
+
+	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
+		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
+	if (!TST_PASS)
+		return;
+
+	otfd = (int)TST_RET;
+
+	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
+		"%s set", tc->name);
+	if (!TST_PASS)
+		goto out1;
+
+	attr.attr_set &= ~tc->mount_attrs;
+	attr.attr_clr |= tc->mount_attrs;
+	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
+		"%s set", tc->name);
+	if (!TST_PASS)
+		goto out1;
+
+	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
+	if (!TST_PASS)
+		goto out1;
+	mount_flag = 1;
 
 	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
 	if (!TST_PASS)
 		goto out2;
 
-	if (buf.f_flag & tc->expect_attrs)
-		tst_res(TPASS, "%s is actually set as expected", tc->name);
-	else
-		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
+	TST_EXP_EXPR(!(buf.f_flag & tc->expect_attrs), "%s clear check pass", tc->name);
+	SAFE_CLOSE(otfd);
 
 	goto out2;
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
