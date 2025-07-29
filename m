Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247C4C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 13:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F9223CA7DF
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 15:38:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD30D3C9FF2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:38:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E2E316008C5
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:38:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 381C5219AD;
 Tue, 29 Jul 2025 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753796303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f99VtCou0ljA7vncVlLmoGpcOLgVvweXhipotUiucAE=;
 b=Cie+8XL50rqsJgxuWv76I+sLVLh4OgJdGml+TRFj1JeJ7wNw7FGEMYHrHG70dkiPAbscPi
 JUeqDYIbz+tAxYjOz7roN73L/g4Gei10VKm6Xt0GcNOo2v+drrBhiNx3rmDsaW8DMyNOQT
 Vcbd8M/UtxyDJPa5l1ZKMbOWPl7bB+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753796303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f99VtCou0ljA7vncVlLmoGpcOLgVvweXhipotUiucAE=;
 b=i8mIWgS0/S754BlwuZhcdz+8KFfp2ch4NlVPkwjy14zXVjR//DQctg90jOXwey5LNdwmVG
 R1TvF/8RkdqKhSAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cie+8XL5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i8mIWgS0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753796303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f99VtCou0ljA7vncVlLmoGpcOLgVvweXhipotUiucAE=;
 b=Cie+8XL50rqsJgxuWv76I+sLVLh4OgJdGml+TRFj1JeJ7wNw7FGEMYHrHG70dkiPAbscPi
 JUeqDYIbz+tAxYjOz7roN73L/g4Gei10VKm6Xt0GcNOo2v+drrBhiNx3rmDsaW8DMyNOQT
 Vcbd8M/UtxyDJPa5l1ZKMbOWPl7bB+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753796303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f99VtCou0ljA7vncVlLmoGpcOLgVvweXhipotUiucAE=;
 b=i8mIWgS0/S754BlwuZhcdz+8KFfp2ch4NlVPkwjy14zXVjR//DQctg90jOXwey5LNdwmVG
 R1TvF/8RkdqKhSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E88913876;
 Tue, 29 Jul 2025 13:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id be6vAM/OiGiaIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Jul 2025 13:38:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 15:38:13 +0200
MIME-Version: 1.0
Message-Id: <20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com>
X-B4-Tracking: v=1; b=H4sIAMTOiGgC/x3MSwqAMAwA0atI1hY0tvi5iohIEzUgtrQqgnh3i
 8u3mHkgchCO0GUPBL4kitsTyjwDu077wkooGbBAU9TYKnH22EYvNNMYT+9dOJiUrmpCM2lbNQi
 p9YFnuf9vP7zvB31vsbJnAAAA
X-Change-ID: 20250729-ioctl_pidfd_supported-437d25a4c382
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753796302; l=1718;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rSiFErHCQGit44K2ewovGfsI/OrGQtErkGaLdeYL6NE=;
 b=deb1tAq26TTf/5dkWgEX0efGBHW6qgmE0cSgMxrGgvWC7NMF1UO8yeAMVOJ4wuDCjhB48lGq9
 V7h2GJVPBmwBcNraFMKBLPbRlx8EC770cLPzv+/3CFsdXoSYwiFEDPY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 381C5219AD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Correctly check if PIDFD_INFO_EXIT is available
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

When systems are not having the PIDFD_INFO_EXIT implementation,
ioctl_pidfd testing suite might fail with:

	ioctl_pidfd.h:32: TBROK: ioctl(...) failed: ENOTTY (25)

Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY
error like a sign for not having PIDFD_INFO_EXIT implemented in the
system.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 8249ac753cf7fb8a3b749d55c7f0c3b30482c114..b2de5389ef78e530e1a3be0525b0a6a238d1d009 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -11,7 +11,7 @@
 
 static inline int ioctl_pidfd_info_exit_supported(void)
 {
-	int ret = 0;
+	int ret;
 	pid_t pid;
 	int pidfd;
 	struct pidfd_info info;
@@ -29,13 +29,17 @@ static inline int ioctl_pidfd_info_exit_supported(void)
 	pidfd = SAFE_PIDFD_OPEN(pid, 0);
 	SAFE_WAITPID(pid, NULL, 0);
 
-	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
-	SAFE_CLOSE(pidfd);
-
-	if (info.mask & PIDFD_INFO_EXIT)
-		ret = 1;
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	if (ret == -1) {
+		if (errno != ENOTTY)
+			tst_brk(TBROK | TERRNO, "ioctl error");
+	} else {
+		if (info.mask & PIDFD_INFO_EXIT)
+			return 1;
+	}
 
-	return ret;
+	SAFE_CLOSE(pidfd);
+	return 0;
 }
 
 #endif

---
base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
change-id: 20250729-ioctl_pidfd_supported-437d25a4c382

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
