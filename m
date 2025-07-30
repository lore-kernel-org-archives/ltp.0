Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CECC87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 12:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0073A3CB046
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:14:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6D953C2FE7
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:14:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8C8C600082
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:14:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E517F21A9F;
 Wed, 30 Jul 2025 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753877649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1qyBxVT6ZHoR8gSbhdIzgtUbR6la5ltpa8bqcZXTfI=;
 b=WbeKa6bldg/Au7puepbS6HY7lP2dC9xw/srrHAzQspAORuYA3ratQTf6NUzUWaHXeEww86
 mGYexuuDMNyRiQJItEzGOmUIrOLU2b13ZSNBnL0mijyESCMletCVGUaTCN4nka2fVcVan+
 0G/wICd1tzG5+MJD0WEOe/z7ADPiymg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753877649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1qyBxVT6ZHoR8gSbhdIzgtUbR6la5ltpa8bqcZXTfI=;
 b=D35SJqM1Svd6FeTvocoM0UOBWING73y0LW8HC3QJCw8K/ZxD+FNzye2wvpzEo++sIjvEmr
 KztvQkjZelU1dHDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753877648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1qyBxVT6ZHoR8gSbhdIzgtUbR6la5ltpa8bqcZXTfI=;
 b=nFKMOWFogin+2uUUKXlHJimMmToG8ZBIl8gVXi3pkUT79vOZpjrBD+j2WELye+TRaTUwkf
 jIILULGGmyE73hECpCac+yQ/y81khhVI5v6FhjCTFRE6pL2RnVyN2mcVdQRg/xsE29s/FM
 3O8L6lMjya0XdbAtaCaonB0Oc2zvetM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753877648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1qyBxVT6ZHoR8gSbhdIzgtUbR6la5ltpa8bqcZXTfI=;
 b=3vV7s15AlkC5YSt7rCthQL3ja/GM+U8a9xepbl5x7RMQgJ4cJKF38WnXgElgFDC2ygM4WH
 eF6WEKnKWeVYjqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ECD51388B;
 Wed, 30 Jul 2025 12:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJafHpAMimiBIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Jul 2025 12:14:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Jul 2025 14:14:06 +0200
MIME-Version: 1.0
Message-Id: <20250730-ioctl_pidfd_supported-v3-1-f40c047b29de@suse.com>
X-B4-Tracking: v=1; b=H4sIAI4MimgC/43NywrCMBCF4VcpWRvJrTdXvodIqcnEDmgTkjYop
 e9u2pU7Xf4H5puFRAgIkZyKhQRIGNGNOeShIHroxztQNLmJYKJktWgpOj09Oo/Gmi7O3rswgaF
 K1kaUvdKyESTf+gAWX7t7ueYeME4uvPc3iW/rLzFxymnblJWoeqZVdTvHOcJRuyfZwCT+QkRGb
 Au2ZVwqLpsvZF3XD+TbDEf+AAAA
X-Change-ID: 20250729-ioctl_pidfd_supported-437d25a4c382
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753877648; l=2502;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=k3SEPOvzsw9CMvXZaBTbwkSyhr93W99PgXdTs/ynRsM=;
 b=gBB/j2/E2J5h/xhgi5afjnFHTRQ2morzBvFqrY70V8UXNqN40EIq7B6DXuY2tGLWnoaybukrg
 MlyGoTjggCABzeOALXJyD0fzUMADSWGpE56TN8XKgwp3b8kmJCyMQl/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.de:email, suse.com:email,
 suse.com:mid, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Correctly check if PIDFD_INFO_EXIT is available
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

Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY,
EINVAL and ESRCH errors like a sign for not having PIDFD_INFO_EXIT
implemented in the system.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Avinesh Kumar <akumar@suse.de>
Tested-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- take in consideration also EINVAL and ESRCH errors
- Link to v2: https://lore.kernel.org/r/20250729-ioctl_pidfd_supported-v2-1-f9ef90134138@suse.com

Changes in v2:
- close pidfd when PIDFD_INFO_EXIT is supported
- Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 8249ac753cf7fb8a3b749d55c7f0c3b30482c114..b5b8bd04dc522954387c1f9a50ee92325689ae6e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -11,9 +11,10 @@
 
 static inline int ioctl_pidfd_info_exit_supported(void)
 {
-	int ret = 0;
+	int ret;
 	pid_t pid;
 	int pidfd;
+	int supported = 0;
 	struct pidfd_info info;
 
 	if (tst_kvercmp(6, 15, 0) >= 0)
@@ -29,13 +30,24 @@ static inline int ioctl_pidfd_info_exit_supported(void)
 	pidfd = SAFE_PIDFD_OPEN(pid, 0);
 	SAFE_WAITPID(pid, NULL, 0);
 
-	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
-	SAFE_CLOSE(pidfd);
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	if (ret == -1) {
+		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
+		 * - EINVAL: until v6.13 kernel
+		 * - ESRCH: all kernels between v6.13 and v6.15
+		 */
+		if (errno != ENOTTY ||
+			errno != EINVAL ||
+			errno != ESRCH)
+			tst_brk(TBROK | TERRNO, "ioctl error");
+	} else {
+		if (info.mask & PIDFD_INFO_EXIT)
+			supported = 1;
+	}
 
-	if (info.mask & PIDFD_INFO_EXIT)
-		ret = 1;
+	SAFE_CLOSE(pidfd);
 
-	return ret;
+	return supported;
 }
 
 #endif

---
base-commit: 890d6d64a235548cec559ffaf2e9208b80e6902b
change-id: 20250729-ioctl_pidfd_supported-437d25a4c382

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
