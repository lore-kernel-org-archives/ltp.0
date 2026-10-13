Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9A9CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 09:09:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07F5F3E6A40
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 11:09:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B8B3CC895
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 11:08:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F0B01A00917
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 11:08:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 046741F849;
 Tue, 13 Oct 2026 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791882525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4UJWaazAWFdsFvrAxB8hnrFKv2aFSSZuNgpdvXUYJY=;
 b=N8tWMJoKOv7yzyIvyfx7qx3QpqVe9Mlx5SpA07a2Z3rKoPFpn+QCv9HbPS6UZzdDghgn/a
 TvCy34NbaSDe63b/3Dreu1TQusUnPXRjszE9k0e3jUZZGb+ko7sz2wLSFkJsjEVjP2Ogek
 Feu+hr0fF7loScVNuQ74PNjIkMGSGYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791882525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4UJWaazAWFdsFvrAxB8hnrFKv2aFSSZuNgpdvXUYJY=;
 b=bBzqbRaMqd/MWeRh9d+XkvEhT/Qhy1YD4xnZrrQLqC7IaSUREYc0iS439XPOpbJRgKwEyJ
 Z5hkMo0Cnp659XCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791882524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4UJWaazAWFdsFvrAxB8hnrFKv2aFSSZuNgpdvXUYJY=;
 b=L34dRTbGTBt412CVDWL2D6E3dN8HI9fAo/DGiZhbzPWH2vrnHgHhxmtSneL/Q2RmBi5Qem
 iDw8bhdrWywugJGl8FCEafq7x6caIgHn+iPNS6X9z8DDPKMEsaFeJGCxVIF+jFIrmBZbPK
 VAsFA863zkpCnFVOWwZM6y/T8AdfCYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791882524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4UJWaazAWFdsFvrAxB8hnrFKv2aFSSZuNgpdvXUYJY=;
 b=Hn9dD2218K+eyeaRPes/FHB3QcIlb0q5JpGV+/DKUm3+MtkjJqGtNxlP93uaVTXXZorRCz
 KWFoCW4e3YD+zLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD72B13341;
 Tue, 13 Oct 2026 09:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DOX3Ehr1zWr9TwAAD6G6ig
 (envelope-from <gpathak@suse.de>); Tue, 13 Oct 2026 09:08:42 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Tue, 13 Oct 2026 14:37:28 +0530
Message-ID: <20261013090740.71898-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <lbvEwRyhGK5uRMDXEGYnefAp6akeeV6nr278@localhost.localdomain>
References: <lbvEwRyhGK5uRMDXEGYnefAp6akeeV6nr278@localhost.localdomain>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,configure.ac:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gaurav Pathak <gaurav.pathak@suse.com>

This patch adds a new test to validate the atomic write limit fields.
The test ensures the filesystem correctly advertises the STATX_ATTR_WRITE_ATOMIC
attribute when queried on a file opened with O_DIRECT. It also verifies that the
reported optimized maximum is logically consistent by falling within the
absolute minimum and maximum boundaries. Furthermore, it checks that all
reported atomic write unit sizes are valid powers of two, adhering to the strict
requirements of the kernel block layer.

If the underlying storage hardware or filesystem lacks atomic write
support, the test gracefully skips with TCONF.

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
---
 configure.ac                               |   4 +-
 include/lapi/stat.h                        |  17 ++-
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx13.c  | 125 +++++++++++++++++++++
 5 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx13.c

diff --git a/configure.ac b/configure.ac
index 370c2e74f..8ec6720dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -180,7 +180,9 @@ AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
-AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
+AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt,
+				  struct statx.stx_atomic_write_unit_min, struct statx.stx_atomic_write_unit_max,
+				  struct statx.stx_atomic_write_segments_max],,,[
 #define _GNU_SOURCE
 #include <sys/stat.h>
 ])
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 17b62ea98..859e410ab 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -93,7 +93,14 @@ struct statx_timestamp {
 	uint64_t	stx_mnt_id; \
 	uint32_t	stx_dio_mem_align; \
 	uint32_t	stx_dio_offset_align; \
-	uint64_t	__spare3[12]; \
+	uint64_t	stx_subvol; \
+	uint32_t	stx_atomic_write_unit_min; \
+	uint32_t	stx_atomic_write_unit_max; \
+	uint32_t	stx_atomic_write_segments_max; \
+	uint32_t	stx_dio_read_offset_align; \
+	uint32_t	stx_atomic_write_unit_max_opt; \
+	uint32_t	__spare2[1]; \
+	uint64_t	__spare3[8]; \
 };
 
 LTP_DEFINE_STATX_STRUCT(statx_fallback);
@@ -197,6 +204,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_DIOALIGN		0x00002000U
 #endif
 
+#ifndef STATX_WRITE_ATOMIC
+#define STATX_WRITE_ATOMIC  0x00010000U
+#endif
+
 #ifndef STATX__RESERVED
 # define STATX__RESERVED	0x80000000U
 #endif
@@ -248,6 +259,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_MNT_ID_UNIQUE  0x00004000U
 #endif
 
+#ifndef STATX_ATTR_WRITE_ATOMIC
+#define STATX_ATTR_WRITE_ATOMIC	0x00400000
+#endif
+
 #define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
 	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
 
diff --git a/runtest/syscalls b/runtest/syscalls
index accdf2df9..c0d8eb31e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1947,6 +1947,7 @@ statx09 statx09
 statx10 statx10
 statx11 statx11
 statx12 statx12
+statx13 statx13
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index f6a423eed..e601a46a3 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -10,3 +10,4 @@
 /statx10
 /statx11
 /statx12
+/statx13
diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
new file mode 100644
index 000000000..01a22a458
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx13.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <gaurav.pathak@suse.com>
+ */
+
+/*\
+ * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
+ * It ensures that supported filesystems (xfs and nfs) correctly report their
+ * atomic write limits to user space when queried via statx().
+ *
+ * Minimum Linux version required is v6.11.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mnt_point"
+#define TESTFILE MNTPOINT "/testfile"
+#define MODE 0644
+
+static int file_fd = -1;
+
+static void verify_statx(void)
+{
+	struct ltp_statx buff;
+
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff.buff),
+			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buf)", TESTFILE);
+
+	/* Check if the kernel populated the atomic limit struct members */
+	if (!(buff.data.stx_mask & STATX_WRITE_ATOMIC))
+		tst_brk(TCONF, "Kernel may be too old to report atomic limits: STATX_WRITE_ATOMIC missing from stx_mask");
+
+	/* Check if the filesystem supports reporting the atomic write attribute */
+	if (!(buff.data.stx_attributes_mask & STATX_ATTR_WRITE_ATOMIC))
+		tst_brk(TCONF, "FS atomic query unsupported: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes_mask.");
+
+	/* Check if the file/device actively supports atomic writes */
+	if (!(buff.data.stx_attributes & STATX_ATTR_WRITE_ATOMIC))
+		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes");
+
+	if (buff.data.stx_atomic_write_unit_min <= buff.data.stx_atomic_write_unit_max)
+		tst_res(TPASS, "stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
+				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);
+	else
+		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) > stx_atomic_write_unit_max(%u)",
+				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);
+
+	if (buff.data.stx_atomic_write_unit_min > 0 &&
+			__builtin_popcount(buff.data.stx_atomic_write_unit_min) == 1)
+		tst_res(TPASS, "stx_atomic_write_unit_min(%u) is power of 2",
+				buff.data.stx_atomic_write_unit_min);
+	else
+		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) is not a power of 2",
+				buff.data.stx_atomic_write_unit_min);
+
+	if (buff.data.stx_atomic_write_unit_max > 0 &&
+			__builtin_popcount(buff.data.stx_atomic_write_unit_max) == 1)
+		tst_res(TPASS, "stx_atomic_write_unit_max(%u) is power of 2",
+				buff.data.stx_atomic_write_unit_max);
+	else
+		tst_res(TFAIL, "stx_atomic_write_unit_max(%u) is not a power of 2",
+				buff.data.stx_atomic_write_unit_max);
+
+	if (buff.data.stx_atomic_write_unit_max_opt == 0) {
+		tst_res(TPASS, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
+	} else {
+		if (buff.data.stx_atomic_write_unit_max_opt > buff.data.stx_atomic_write_unit_max)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
+					buff.data.stx_atomic_write_unit_max_opt,
+					buff.data.stx_atomic_write_unit_max);
+
+		else if (buff.data.stx_atomic_write_unit_max_opt < buff.data.stx_atomic_write_unit_min)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
+					buff.data.stx_atomic_write_unit_max_opt,
+					buff.data.stx_atomic_write_unit_min);
+		else
+			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
+					buff.data.stx_atomic_write_unit_max_opt,
+					buff.data.stx_atomic_write_unit_min,
+					buff.data.stx_atomic_write_unit_max);
+
+		if (__builtin_popcount(buff.data.stx_atomic_write_unit_max_opt) != 1)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power of 2",
+					buff.data.stx_atomic_write_unit_max_opt);
+	}
+}
+
+static void setup(void)
+{
+	char *data_buff = NULL;
+	struct stat sb;
+
+	SAFE_STAT(MNTPOINT, &sb);
+
+	data_buff = SAFE_MEMALIGN(sb.st_blksize, sb.st_blksize);
+	memset(data_buff, '@', sb.st_blksize);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
+	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, sb.st_blksize);
+
+	SAFE_CLOSE(file_fd);
+	free(data_buff);
+}
+
+static struct tst_test test = {
+	.test_all = verify_statx,
+	.setup = setup,
+	.min_kver = "6.11",
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.filesystems = (struct tst_fs[]) {
+		{
+			.type = "xfs",
+			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},
+		},
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", "4096", "-C", "65536", NULL},
+		},
+		{}
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
