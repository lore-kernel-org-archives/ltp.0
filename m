Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098F1CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 15:03:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C04E3CDEA7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 17:03:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8A03CAC1E
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:03:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D0393600272
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 17:03:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91E0F1F7F2;
 Tue, 23 Sep 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 867101388C;
 Tue, 23 Sep 2025 15:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7d/WIMm20miFUQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 23 Sep 2025 15:03:37 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Sep 2025 17:03:36 +0200
Message-ID: <20250923150337.19821-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aNKJP8fKNn6JcT5I@yuki.lan>
References: <aNKJP8fKNn6JcT5I@yuki.lan>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 91E0F1F7F2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Introduce ioctl_pidfd_get_info_supported() function
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

use this routine in ioctl_pidfd05 before proceeding with the test

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 42 +++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     |  9 +++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 811f969cd..29bc60cfb 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -9,6 +9,48 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 
+static inline bool ioctl_pidfd_get_info_supported(void)
+{
+	pid_t pid;
+	int pidfd, ret;
+	int supported = 0;
+	struct pidfd_info info;
+
+	if (tst_kvercmp(6, 12, 0) >= 0)
+		return 1;
+
+	memset(&info, 0, sizeof(struct pidfd_info));
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(100);
+
+	pidfd = SAFE_PIDFD_OPEN(pid, 0);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	SAFE_CLOSE(pidfd);
+
+	if (ret == -1) {
+		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented */
+		if (errno == ENOTTY)
+			supported = 0;
+
+		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but args invalid
+		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
+		 * supported in both cases, but info.mask not set
+		 */
+		else if (errno == EINVAL || errno == ESRCH)
+			supported = 1;
+		else
+			tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
+	} else {
+		supported = 1;
+	}
+
+	return supported;
+}
+
 static inline int ioctl_pidfd_info_exit_supported(void)
 {
 	int ret;
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index c379717b3..d20c6f074 100644
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
+	if (!ioctl_pidfd_get_info_supported())
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
