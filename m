Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0849CC6B38
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 07:14:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EC903E69DC
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 09:14:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69CB3E6990
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 09:14:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 37068100034E
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 09:14:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DBC421DE0;
 Fri, 16 Oct 2026 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792134864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96l7vkyJgedjymQAF+wmC/nG+yRcEWDnc7NzqyykJd8=;
 b=wdACQUdgiL3OLWuQgo5Sm49sQrq2czRgh6CUR+0ft7temlJARKwDuP2E3orLZIYEA2OnTl
 VkCdb8yplfbht1xZqT9tUm50HXU7tCwGy9s1wmUUtA4EfT29IIn0SlppxN2Y8xbiZMxKkF
 gEqBJVY9cRy//EU/+bEwU+OtD/jgKKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792134864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96l7vkyJgedjymQAF+wmC/nG+yRcEWDnc7NzqyykJd8=;
 b=Di7ypjv7zctidXEGa+yVVO/kjosm25QDlnjw+hDk13PknpCk12q1iLVi5p7sgqmO2phu71
 yOxAaBj2rKsYp/Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wdACQUdg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Di7ypjv7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792134864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96l7vkyJgedjymQAF+wmC/nG+yRcEWDnc7NzqyykJd8=;
 b=wdACQUdgiL3OLWuQgo5Sm49sQrq2czRgh6CUR+0ft7temlJARKwDuP2E3orLZIYEA2OnTl
 VkCdb8yplfbht1xZqT9tUm50HXU7tCwGy9s1wmUUtA4EfT29IIn0SlppxN2Y8xbiZMxKkF
 gEqBJVY9cRy//EU/+bEwU+OtD/jgKKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792134864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96l7vkyJgedjymQAF+wmC/nG+yRcEWDnc7NzqyykJd8=;
 b=Di7ypjv7zctidXEGa+yVVO/kjosm25QDlnjw+hDk13PknpCk12q1iLVi5p7sgqmO2phu71
 yOxAaBj2rKsYp/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09C81378C;
 Fri, 16 Oct 2026 07:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zXmlE8/O0WrwDQAAD6G6ig
 (envelope-from <gpathak@suse.de>); Fri, 16 Oct 2026 07:14:23 +0000
From: Gaurav Pathak <gpathak@suse.de>
Date: Fri, 16 Oct 2026 12:43:59 +0530
MIME-Version: 1.0
Message-Id: <20261016-statx-atomic-write-v7-1-d9cd4e1f1bcd@suse.com>
X-B4-Tracking: v=1; b=H4sIALfO0WoC/x3MTQqAIBBA4avIrBtQ+xG6SrQQG2sWaahUEN09a
 fkt3nsgU2LKMIoHEp2cOYYK0whwmw0rIS/VoKUelFQD5mLLjbbEnR1eiQuh89KpnrRpfQc1PBJ
 5vv/pNL/vB+fegzdkAAAA
X-Change-ID: 20261016-statx-atomic-write-cf0c15e273f4
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8737;
 i=gaurav.pathak@suse.com; h=from:subject:message-id;
 bh=oNeuCCaxcqjebwHeat4SG74gLQ+yc+0FY7TIJ2cluDc=;
 b=owGbwMvMwCUWE1e4+dFlWS3G02pJDFkXz52PmiFVKK7H96fwBZNfZrl1W3Kvj/UlntCbzyd/4
 ts9ba1DRykLgxgXg6yYIouxQrO431XmaltNTTmYOaxMIEMYuDgFYCIHTRkZuvOZTnlH/Pv0r+fl
 nDwnp9a4rtV3Es7tsp9Tcm/f3R/F7xn+cG7PTm1eGvGvtNC0YPPFG9FmCw/LcSfwOs1OEcvneK/
 FCgA=
X-Developer-Key: i=gaurav.pathak@suse.com; a=openpgp;
 fpr=332083174ED5037B3D29291E5C5E71B3E2D31D2A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 8DBC421DE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] syscalls/statx13: Add basic test for
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
The test ensures the filesystem correctly advertises the
STATX_ATTR_WRITE_ATOMIC attribute when queried on a file opened with
O_DIRECT. It also verifies that the reported optimized maximum is
logically consistent by falling within the absolute minimum and maximum
boundaries. Furthermore, it checks that all reported atomic write unit
sizes are valid powers of two, adhering to the strict requirements of
the kernel block layer.

If the underlying storage hardware or filesystem lacks atomic write
support, the test gracefully skips with TCONF.

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
---
 include/lapi/stat.h                        |  17 +++-
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx13.c  | 138 +++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 17b62ea98d6776fafc8713e710093f3c8cf41fc4..859e410ab5cd5560cda49594c77ca87522ae1143 100644
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
index accdf2df9b36a0b839a4611b2c231be8d79f4db7..c0d8eb31ec53805244c629611ce26b3cf414508f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1947,6 +1947,7 @@ statx09 statx09
 statx10 statx10
 statx11 statx11
 statx12 statx12
+statx13 statx13
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index f6a423eed84dd67152e6f75809037c92ceb1e060..e601a46a352562fb67836a5f78e19e49323f9bf4 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -10,3 +10,4 @@
 /statx10
 /statx11
 /statx12
+/statx13
diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
new file mode 100644
index 0000000000000000000000000000000000000000..cf94568e601d9f8cef67d7e2da51027538d6c2a7
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx13.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <gaurav.pathak@suse.com>
+ */
+
+/*\
+ * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
+ * It ensures that supported filesystems (xfs and ext4) correctly report their
+ * atomic write limits to user space when queried via statx().
+ *
+ * Minimum Linux version required is v6.12.
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
+static struct ltp_statx *buff;
+
+static void verify_statx(void)
+{
+	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff->buff),
+			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buf)", TESTFILE);
+
+	if (!TST_PASS)
+		return;
+
+	/* Check if the kernel populated the atomic limit struct members */
+	if (!(buff->data.stx_mask & STATX_WRITE_ATOMIC))
+		tst_brk(TCONF, "Kernel may be too old to report atomic limits: STATX_WRITE_ATOMIC missing from stx_mask");
+
+	/* Check if the filesystem supports reporting the atomic write attribute */
+	if (!(buff->data.stx_attributes_mask & STATX_ATTR_WRITE_ATOMIC)) {
+		tst_res(TFAIL, "Inconsistent: stx_mask has STATX_WRITE_ATOMIC but stx_attributes_mask lacks STATX_ATTR_WRITE_ATOMIC");
+		return;
+	}
+
+	/* Check if the file/device actively supports atomic writes */
+	if (!(buff->data.stx_attributes & STATX_ATTR_WRITE_ATOMIC)) {
+		if (buff->data.stx_atomic_write_unit_min || buff->data.stx_atomic_write_unit_max ||
+				buff->data.stx_atomic_write_unit_max_opt || buff->data.stx_atomic_write_segments_max) {
+			tst_res(TFAIL,
+				"Inconsistent: STATX_ATTR_WRITE_ATOMIC unset but limits nonzero (min=%u max=%u opt=%u segs=%u)",
+				buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max,
+				buff->data.stx_atomic_write_unit_max_opt, buff->data.stx_atomic_write_segments_max);
+			return;
+		}
+
+		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes");
+	}
+
+	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min <= buff->data.stx_atomic_write_unit_max,
+			"stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
+			buff->data.stx_atomic_write_unit_min, buff->data.stx_atomic_write_unit_max);
+
+	TST_EXP_EXPR(buff->data.stx_atomic_write_segments_max > 0,
+			"stx_atomic_write_segments_max(%u) > 0", buff->data.stx_atomic_write_segments_max);
+
+	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_min > 0 &&
+			__builtin_popcount(buff->data.stx_atomic_write_unit_min) == 1,
+			"stx_atomic_write_unit_min(%u) is a power of 2",
+			buff->data.stx_atomic_write_unit_min);
+
+	TST_EXP_EXPR(buff->data.stx_atomic_write_unit_max > 0 &&
+			__builtin_popcount(buff->data.stx_atomic_write_unit_max) == 1,
+			"stx_atomic_write_unit_max(%u) is a power of 2",
+			buff->data.stx_atomic_write_unit_max);
+
+	if (buff->data.stx_atomic_write_unit_max_opt == 0) {
+		tst_res(TPASS, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
+	} else {
+		if (buff->data.stx_atomic_write_unit_max_opt > buff->data.stx_atomic_write_unit_max)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
+					buff->data.stx_atomic_write_unit_max_opt,
+					buff->data.stx_atomic_write_unit_max);
+
+		else if (buff->data.stx_atomic_write_unit_max_opt < buff->data.stx_atomic_write_unit_min)
+			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
+					buff->data.stx_atomic_write_unit_max_opt,
+					buff->data.stx_atomic_write_unit_min);
+		else
+			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
+					buff->data.stx_atomic_write_unit_max_opt,
+					buff->data.stx_atomic_write_unit_min,
+					buff->data.stx_atomic_write_unit_max);
+
+		TST_EXP_EXPR(__builtin_popcount(buff->data.stx_atomic_write_unit_max_opt) == 1,
+				"stx_atomic_write_unit_max_opt(%u) is a power of 2",
+				buff->data.stx_atomic_write_unit_max_opt);
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
+	.bufs = (struct tst_buffers []) {
+		{&buff, .size = sizeof(*buff)},
+		{}
+	},
+	.filesystems = (struct tst_fs[]) {
+		{
+			.type = "xfs",
+			.min_kver = "6.12",
+			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},
+		},
+		{
+			.type = "ext4",
+			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", "4096", "-C", "65536", NULL},
+		},
+		{}
+	},
+};

---
base-commit: 07da37cf3dbda876b33ad820168a33b9deacbddb
change-id: 20261016-statx-atomic-write-cf0c15e273f4

Best regards,
-- 
Gaurav Pathak <gaurav.pathak@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
