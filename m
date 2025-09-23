Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0CCAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 07:51:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89DFC3CDE90
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 09:51:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04E2F3C4F80
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 09:51:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 333171000347
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 09:51:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA41721A54;
 Tue, 23 Sep 2025 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758613879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ANu2232szvzTpTWVmOE08Z4QLldRFNNb9lb2tPhLdc=;
 b=n5mvZuf3Brj5iMiZXYP1EBj0xNU+rPLlCTUofeTy5K+EryYhl5LMejhLPMJwd7e45YYgev
 RLvMSEjJaXPkLIjgj4B2XfWowcYmURUdIFQley/M5U2AfdAkHDnyLGy8/dx6bzfcJOD3oJ
 z6qcrk0rmoQymNHV1kVT/k1mOZB5DJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758613879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ANu2232szvzTpTWVmOE08Z4QLldRFNNb9lb2tPhLdc=;
 b=4+F1DDuie+klrNHQxjs2dsOv6BjilCn3kSkTEWjBEin3O0JlCrOHuMgAOZh05SE4CaqeZh
 qGvuecNIIXe8hHAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758613878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ANu2232szvzTpTWVmOE08Z4QLldRFNNb9lb2tPhLdc=;
 b=Crjb02VLz1CxKkdKInr8XedBu7mOShWFBaS4bublrJ0BUui53baWW5bMq5jD3v7cjSkmEh
 ifwLNZALsPcaIPQTOS4HwSPvQ+e603xfhvOsr0eRHwQj77RR1Oe1t3/OpSAX45yu16GjSx
 C9YfzLs2iAPg3jnyLBXuU3/Ysd7Hq70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758613878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ANu2232szvzTpTWVmOE08Z4QLldRFNNb9lb2tPhLdc=;
 b=/A3rda6ddB2qWoG7xlkr22Lxp3DT6M6tG9mLxxvSC/LMI3ICc4CfF1OgO0qVNXbJtZLDig
 x54UYmwVI2x00NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B432D1388C;
 Tue, 23 Sep 2025 07:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xCzEK3ZR0mj+NAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 23 Sep 2025 07:51:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Sep 2025 09:51:08 +0200
Message-ID: <20250923075118.29757-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922210723.GA44059@pevik>
References: <20250922210723.GA44059@pevik>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Introduce ioctl_pidfd_get_info_supported() function
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

- use new routine in ioctl_pidfd05 test
- refactor ioctl_pidfd_info_exit_supported() routine

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 49 ++++++++++++-------
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     |  9 +++-
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 811f969cd..067ef18ba 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -9,19 +9,16 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 
-static inline int ioctl_pidfd_info_exit_supported(void)
+static inline long ioctl_pidfd_get_info_supported(void)
 {
-	int ret;
 	pid_t pid;
-	int pidfd;
-	int supported = 0;
+	int pidfd, ret;
 	struct pidfd_info info;
 
-	if (tst_kvercmp(6, 15, 0) >= 0)
+	if (tst_kvercmp(6, 12, 0) >= 0)
 		return 1;
 
 	memset(&info, 0, sizeof(struct pidfd_info));
-	info.mask = PIDFD_INFO_EXIT;
 
 	pid = SAFE_FORK();
 	if (!pid)
@@ -31,23 +28,39 @@ static inline int ioctl_pidfd_info_exit_supported(void)
 	SAFE_WAITPID(pid, NULL, 0);
 
 	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	SAFE_CLOSE(pidfd);
+
 	if (ret == -1) {
-		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
-		 * - EINVAL: until v6.13 kernel
-		 * - ESRCH: all kernels between v6.13 and v6.15
+		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented; return -1 */
+		if (errno == ENOTTY)
+			return -1;
+
+		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but invalid args
+		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
+		 * both mean supported, but info.mask is not set; return 0
 		 */
-		if (errno != ENOTTY &&
-			errno != EINVAL &&
-			errno != ESRCH)
-			tst_brk(TBROK | TERRNO, "ioctl error");
-	} else {
-		if (info.mask & PIDFD_INFO_EXIT)
-			supported = 1;
+		if (errno == EINVAL || errno == ESRCH)
+			return 0;
+
+		tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
 	}
 
-	SAFE_CLOSE(pidfd);
+	/* ioctl(PIDFD_GET_INFO) successful; return mask */
+	return info.mask;
+}
+
+static inline bool ioctl_pidfd_info_exit_supported(void)
+{
+	long mask;
+
+	if (tst_kvercmp(6, 15, 0) >= 0)
+		return 1;
+
+	mask = ioctl_pidfd_get_info_supported();
+	if (mask == -1)
+		return 0;
 
-	return supported;
+	return !!(mask & PIDFD_INFO_EXIT);
 }
 
 #endif
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index c379717b3..871f2fe5e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -14,7 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
-#include "lapi/ioctl.h"
+#include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
 	uint32_t dummy;
@@ -48,8 +48,15 @@ static void run(void)
 	SAFE_CLOSE(pidfd);
 }
 
+static void setup(void)
+{
+	if (ioctl_pidfd_get_info_supported() == -1)
+		tst_brk(TCONF, "ioctl(PIDFD_GET_INFO) is not implemented");
+}
+
 static struct tst_test test = {
 	.test_all = run,
+	.setup = setup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
 		{&args, .size = sizeof(*args)},
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
