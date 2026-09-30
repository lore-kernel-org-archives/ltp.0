Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1E0CA5FBB
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 07:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9473E55C1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:23:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 126833E237F
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:23:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8DB19600806
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:23:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12FB1F86C;
 Wed, 30 Sep 2026 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790753005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5d+tGILVGClgDPI0nzJrjvQ1dTLYXGq0Wx72M8rRrZs=;
 b=lX/4VEUQwvF/KjCOdpPrufECaudoccfSGkFfTNGEJt0vGNs19F+pZ672gAKvVQGrj+VF4D
 sAbNZUhMx2F7nqVnNgN6ZXW2X8zMxRxBEvIgYmjAJRhC9XqAe3K10PyocKSiFoj5N7Z0QJ
 0HpLcCFLxYijzFOjWOWtKXZEma0526E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790753005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5d+tGILVGClgDPI0nzJrjvQ1dTLYXGq0Wx72M8rRrZs=;
 b=fENHDYbdS41fbryIyeha/I4EPxhBHCSxxUVSyvuzJ84fwNSNZ03ZNcZ/J8GwxQGkcCha5m
 V8aBZVbYIOYNLQCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JOp5Iazd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g8FXoXCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790753001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5d+tGILVGClgDPI0nzJrjvQ1dTLYXGq0Wx72M8rRrZs=;
 b=JOp5IazdN1cG14vOB90VgAmcNicIVNasvZkjqxU5XvVjuyWV95XlcQZgEJeCLeU45TubSv
 XfvAvo0yUk9NObEExK732QrR8B6glNnGJ4FBfv8RFjrJcxjQpmRCmIOmn3yulDsOXTKYBH
 zxPS8vgL+IVpNT4yaRcFF0CR7AlkWjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790753001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5d+tGILVGClgDPI0nzJrjvQ1dTLYXGq0Wx72M8rRrZs=;
 b=g8FXoXCWei3+dFST9Q/+PCPa95nLKEIK6OAU33dWV0337xDo04pUrUWC3BmFM7SRnNTFps
 29NGUvAnwPVGt7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85D7413A1E;
 Wed, 30 Sep 2026 07:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /9JtFum4vGrrNAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 07:23:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 09:23:19 +0200
MIME-Version: 1.0
Message-Id: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
X-B4-Tracking: v=1; b=H4sIAOa4vGoC/3WNwQ6CMBAFf4Xs2RpaEKwn/8MQQssiNUBJF4iG9
 N9t8exxknnzdiB0BgluyQ4ON0PGTgHEKQHdN9MTmWkDg0hFkUohWWfeNc52GGo1d+yCeSna5op
 FpiFsZodBOHqP6se0qhfqJUai0RtarPschxuP3r/2xhlnmVRcNirNM13eaSU8aztC5b3/Amj1j
 nK7AAAA
X-Change-ID: 20260929-fix_epoll_bpf-5e472da8e63c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790753001; l=4667;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QyZSHZVj+EQN3hj4b+7l/yvGY7tFxuJAe2kx3RwC9zw=;
 b=lxv5PR4i5THAibHQD61RmtPFJrZryvrAh01Pv7xk9wXHWnVzf2Duh3snKEfNLbrvxB3RYrhd9
 lTyi2Jmn+PHBF0UOhsNHIMaMK3CaW0apbtl6d1rATiZJ02ZbZ9QXcbA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C12FB1F86C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] epoll_ctl06: Fix BPF map on old kernels
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
Changes in v2:
- skip after 5.8 kernel
- Link to v1: https://lore.kernel.org/20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
index 69321582f..9c6cd2460 100644
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
@@ -37,6 +41,16 @@ static int exp_errno(enum tst_fd_type type)
 	case TST_FD_PATH:
 	case TST_FD_OPEN_TREE:
 		return EBADF;
+	case TST_FD_BPF_MAP:
+		if (tst_kvercmp(5, 8, 0) >= 0)
+			return 0;
+
+		/*
+		 * The BPF poll callback returns POLLERR for array maps. Without
+		 * the callback, poll() returns the default readiness mask.
+		 */
+		SAFE_POLL(&pfd, 1, 0);
+		return pfd.revents & POLLERR ? 0 : EPERM;
 	default:
 		return 0;
 	}
@@ -50,7 +64,7 @@ static void run(void)
 	TST_FD_FOREACH(fd) {
 		efd = SAFE_EPOLL_CREATE1(0);
 		ev.data.fd = fd.fd;
-		err = exp_errno(fd.type);
+		err = exp_errno(&fd);
 
 		TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
 				 fd.fd, &ev), err,

---
base-commit: 1cbe713ca9d55bed7e4d52c6f2216ba3e2089346
change-id: 20260929-fix_epoll_bpf-5e472da8e63c

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
