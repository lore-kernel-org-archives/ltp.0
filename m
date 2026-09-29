Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387DC9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:15:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C51273E5873
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:15:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 110BE3C0177
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:15:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 856C51400B78
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:15:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C8C51F460;
 Tue, 29 Sep 2026 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790691314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GHGzYtIvOKydTY8eCQI3a1LinXlNzXUKOWeKYpjTxKA=;
 b=Fda6yhcOnfCe7X/YPd1XV8cxzLr+n4+cxgZ2Zr6O6jCY6XfvyV835Ol+wP5h+9d8gotoAb
 MHq1rOjMQekhUrjUpSURurllJ9S6C2ZDsBdFNAtpsZH43czKISwRaphZUYrwUwqGdPoT+T
 HOcd+i2e2WKtrBFyW0wX3qtkdnYsivY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790691314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GHGzYtIvOKydTY8eCQI3a1LinXlNzXUKOWeKYpjTxKA=;
 b=cIZOPZD64DUyqH2hGYgTlckzlribQ3c3Eq3upZpR7MbHymft4Tkf23l1cFf9vOFaaicZuW
 4E5ipXP3+Eq6ATBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CpnLlYI+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+eQgoXM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790691310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GHGzYtIvOKydTY8eCQI3a1LinXlNzXUKOWeKYpjTxKA=;
 b=CpnLlYI+OqF5Jc3N8W0dWcY5aevUJTuM7MqoWlDeEaU2F7K3vn8mLasVqjYLF6g4QzjGEA
 cIQRPjljgR99fp0PpiFroJCCqJZlxrU+z8BouCvQ/c5x/uh3Tp9KLJ4e9CVACfDIEpr7Ts
 iVUnkf9sAl7TA+Ep4vFvC+rX9gzeB6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790691310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GHGzYtIvOKydTY8eCQI3a1LinXlNzXUKOWeKYpjTxKA=;
 b=+eQgoXM85aH06qC1UgFcILqtVeJP9zG7h14GSDDac1msvwELXzfWMwfva2AZL3je+RYBRZ
 oJJKi3SQ4HXvL5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5219133F1;
 Tue, 29 Sep 2026 14:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oqhcKu3Hu2rfTwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Sep 2026 14:15:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Sep 2026 16:15:01 +0200
MIME-Version: 1.0
Message-Id: <20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com>
X-B4-Tracking: v=1; b=H4sIAOTHu2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3bTMivjUgvycnPikgjRd01QTc6OURItUM+NkJaCegqJUoAKwedG
 xEH5xaVJWanIJyBCl2loAFq3WdnEAAAA=
X-Change-ID: 20260929-fix_epoll_bpf-5e472da8e63c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790691309; l=4476;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KoMFFpkbripVAqV7gpWnk42kudrgfWa/Z5aBnYZKgG8=;
 b=okUk1IDn6HiZXZJFVpJVN9Vlg/8kc3n5evos7WyIZ8GaNpzXxbyoRnDI1KdixB7Ogd1YwSTrZ
 oUAALinPj4/BUFNRhVLpMeofNebkR4TZL57wwxTvXcAaknVDoAqY6q2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1C8C51F460
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] epoll_ctl06: Fix BPF map on old kernels
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

BPF map file descriptors gained a poll callback in upstream kernel
5.8. Without that callback, EPOLL_CTL_ADD fails with EPERM, while the
test expected it to succeed.

Detect BPF map poll support at runtime so that older kernels with
backported support are handled correctly as well.

Fixes: c4c0ca4c749e ("syscalls: Add epoll_ctl06")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
tst_tmpdir.c:309: TINFO: Using /var/tmp/LTP_epoXsyHnT as tmpdir (btrfs filesystem)
tst_test.c:2067: TINFO: LTP version: 20260529
tst_test.c:2070: TINFO: Tested kernel: 4.4.140-491.1.TDC.gedc1884-default #1 SMP Wed Sep 23 11:06:41 UTC 2026 (edc1884) x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:760: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1897: TINFO: Overall timeout per run is 0h 02m 00s
epoll_ctl06.c:57: TPASS: epoll_ctl() on file : EPERM (1)
epoll_ctl06.c:57: TPASS: epoll_ctl() on O_PATH file : EBADF (9)
epoll_ctl06.c:57: TPASS: epoll_ctl() on directory : EPERM (1)
epoll_ctl06.c:57: TPASS: epoll_ctl() on /dev/zero : EPERM (1)
epoll_ctl06.c:57: TPASS: epoll_ctl() on /proc/self/maps : EPERM (1)
epoll_ctl06.c:57: TPASS: epoll_ctl() on pipe read end passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on pipe write end passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on unix socket passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on inet socket passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on epoll passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on eventfd passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on signalfd passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on timerfd passed
tst_fd.c:144: TCONF: pidfd_open(): ENOSYS (38)
epoll_ctl06.c:57: TPASS: epoll_ctl() on fanotify passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on inotify passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on userfaultfd passed
epoll_ctl06.c:57: TPASS: epoll_ctl() on perf event passed
tst_fd.c:200: TCONF: Skipping io uring: ENOSYS (38)
epoll_ctl06.c:57: TFAIL: epoll_ctl() on bpf map failed: EPERM (1)
tst_fd.c:225: TCONF: Skipping fsopen: ENOSYS (38)
tst_fd.c:234: TCONF: Skipping fspick: ENOSYS (38)
tst_fd.c:243: TCONF: Skipping open_tree: ENOSYS (38)
epoll_ctl06.c:57: TPASS: epoll_ctl() on memfd : EPERM (1)
tst_fd.c:261: TCONF: Skipping memfd secret: ENOSYS (38)

Summary:
passed   18
failed   1
broken   0
skipped  6
warnings 0
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
index 69321582f..e85e9e259 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
@@ -12,19 +12,23 @@
  * poll file operation are expected to succeed. The rest must fail with:
  *
  * - EPERM for fds that are valid but lack poll support (regular files,
- *   directories, /dev/zero, /proc files, memfd).
+ *   directories, /dev/zero, /proc files, memfd and BPF maps on kernels
+ *   without BPF map poll support).
  * - EBADF for fds that are not usable for I/O (O_PATH, open_tree).
  */
 
+#include <poll.h>
 #include <sys/epoll.h>
 
 #include "tst_test.h"
 #include "tst_epoll.h"
 #include "tst_fd.h"
 
-static int exp_errno(enum tst_fd_type type)
+static int exp_errno(struct tst_fd *fd)
 {
-	switch (type) {
+	struct pollfd pfd = {.fd = fd->fd, .events = POLLIN};
+
+	switch (fd->type) {
 	case TST_FD_FILE:
 	case TST_FD_DIR:
 	case TST_FD_DEV_ZERO:
@@ -37,6 +41,13 @@ static int exp_errno(enum tst_fd_type type)
 	case TST_FD_PATH:
 	case TST_FD_OPEN_TREE:
 		return EBADF;
+	case TST_FD_BPF_MAP:
+		/*
+		 * The BPF poll callback returns POLLERR for array maps. Without
+		 * the callback, poll() returns the default readiness mask.
+		 */
+		SAFE_POLL(&pfd, 1, 0);
+		return pfd.revents & POLLERR ? 0 : EPERM;
 	default:
 		return 0;
 	}
@@ -50,7 +61,7 @@ static void run(void)
 	TST_FD_FOREACH(fd) {
 		efd = SAFE_EPOLL_CREATE1(0);
 		ev.data.fd = fd.fd;
-		err = exp_errno(fd.type);
+		err = exp_errno(&fd);
 
 		TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
 				 fd.fd, &ev), err,

---
base-commit: 0596b09f22f449cb300e8ad2d08d8b186f551a05
change-id: 20260929-fix_epoll_bpf-5e472da8e63c

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
