Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEFDC87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 12:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC8B33CB1A6
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:20:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 289E13C2FE7
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:20:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 495F11A0048F
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:20:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13C0D21228;
 Wed, 30 Jul 2025 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753878016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh733mvl/aJBOkASkgf6GJOBky1MzvySJ1Bdx0RizpM=;
 b=vJbcgp+AwvXkkNgOiOrFto04YoPHoLBEXpvIKRvVGjdQOsucOw5oM952dJgC233aqLd0TM
 7P+C27Ch4a3XALLCpLoaFdmtPEnA8pHVm+fvkSpabX482zf1G0ZJU9FOQQS4UblPnRuPfv
 KJMI6ORy6fJV7OeTl0zIARfXaHk0/FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753878016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh733mvl/aJBOkASkgf6GJOBky1MzvySJ1Bdx0RizpM=;
 b=SA7e/sMM3uhIOwn9djwv9TGD+Epw4jxP8gYG4eF00wULlY02eEqBofp4qCUwt6aUI5pNwx
 lSl9bmUbjBOqfCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753878016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh733mvl/aJBOkASkgf6GJOBky1MzvySJ1Bdx0RizpM=;
 b=vJbcgp+AwvXkkNgOiOrFto04YoPHoLBEXpvIKRvVGjdQOsucOw5oM952dJgC233aqLd0TM
 7P+C27Ch4a3XALLCpLoaFdmtPEnA8pHVm+fvkSpabX482zf1G0ZJU9FOQQS4UblPnRuPfv
 KJMI6ORy6fJV7OeTl0zIARfXaHk0/FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753878016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh733mvl/aJBOkASkgf6GJOBky1MzvySJ1Bdx0RizpM=;
 b=SA7e/sMM3uhIOwn9djwv9TGD+Epw4jxP8gYG4eF00wULlY02eEqBofp4qCUwt6aUI5pNwx
 lSl9bmUbjBOqfCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C04B51388B;
 Wed, 30 Jul 2025 12:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RofCK/8NimicIwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Jul 2025 12:20:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Jul 2025 14:20:14 +0200
MIME-Version: 1.0
Message-Id: <20250730-ioctl_pidfd_supported-v4-1-db7bd905a1d6@suse.com>
X-B4-Tracking: v=1; b=H4sIAP0NimgC/43N3wqCMBTH8VeRXbfYzuafddV7RIhuxxyUk02lE
 N+96ZUEUZffH5zPmUlAbzGQUzITj5MN1nUx5CEhuq26G1JrYhNgkLIcFLVOD/eyt6YxZRj73vk
 BDZUiN5BWUosCSLztPTb2ubmXa+zWhsH51/Zm4uv6S5w45VQVaQZZxbTM6nMYAx61e5AVnOAvB
 CLSKGwU40JyUXwgYocI9g0RKyKZZjKvQRncIcuyvAFldsIaQwEAAA==
X-Change-ID: 20250729-ioctl_pidfd_supported-437d25a4c382
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753878015; l=2649;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RJ6t+hodpFcvIEg5ilL4DW3P+BWaTcFjo1nYO3b4jsE=;
 b=wMP18O3/kqYBfTQO1kW3xU9SLpOwFn+yUa0jSvXSfID6u51JmeghhhKYuRVj8iltGTJcGn/3r
 99lAiV8mAy9AEV6iTT3TxrJD4w/iuNlcKxLxFBpWO4KT36lxUXDOzQs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.cz:email, suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Correctly check if PIDFD_INFO_EXIT is available
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
Changes in v4:
- use the right AND logic...
- Link to v3: https://lore.kernel.org/r/20250730-ioctl_pidfd_supported-v3-1-f40c047b29de@suse.com

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
index 8249ac753cf7fb8a3b749d55c7f0c3b30482c114..811f969cdee8147dfa43bc2ab1124dfd9fd21e41 100644
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
+		if (errno != ENOTTY &&
+			errno != EINVAL &&
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
