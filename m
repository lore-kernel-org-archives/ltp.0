Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB08C369A2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744638060; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cL2mKHSgozsZ0JrgTl73rCY+TtG7taSDu0FGifJCGh8=;
 b=iBedAhJv85+xq//iYRQ0IQSnFGRhB1NiDxytWgBI+XcqbcX+/bIT00jp5E/3XXD8cjwfn
 HXe3o71xUwMrEWLue9+s6iwrWLcweIjxSV8SJJ5ZlGAwRfob2haVc6qR2G0FtxluULNKeVc
 g8sFkXDCJKwxsbxKPRRPgzqXpBKMe+I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13C83CB71C
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 15:41:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8403CB72E
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:40:02 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E02A5600069
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:40:01 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso47338375e9.0
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744638001; x=1745242801; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Nstq+/OJWGE3+1pwNfk2HEEjEtd6El3C2ins37nRzI=;
 b=ZkwDHv6km36OJSmEu9fe3l+dJuh1LBWfzeiN25SflDe7w9DBDs7qXzpIkE+42QsYS5
 zcYnodrh1vY2PsItmziQh90I6uBR3XpzGjm+Dp0OhFHQ+JB2ZY0P/6K0/2xSme1NT+uK
 vbUFUy39yRSBjtJHIza4qTaFFwn49WbE/CG6ejKMP8GqxQptBvmh+t8gJrPh6ESN12N1
 Tr9980n4aKz9QSGrDRLDFI9KCk7ye2Q0s/4Q4FzZ0SPWCU6J8xahAIuwxTPEqulST03g
 h+OQGbJS0jmhYvjlv3UJj4t9foYKlql8HsQ5oqbkTeRcq3KEzpPa/eprTL3rMb1xlabq
 XILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744638001; x=1745242801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Nstq+/OJWGE3+1pwNfk2HEEjEtd6El3C2ins37nRzI=;
 b=jukODGVitWJmrPInGQ5e4lLzP9cAEKaS1tsWv1mWKEwxdyI6WW1SpExSULWpXJF65c
 Oka/7fkokSHEw+Y6HG8HJrou2AYwxS6lc5YhQqMM/W8HkCy63l5ntNj/0d8S0kVyZmc+
 ip9GcZDPhWmv7BOTEvktylHGFgyTXnrPJmqUPuUeYsZ9wyqI9iohhK9pvMvLEwsHlQek
 qK+tUNSQlV+sF+2U2Ag6/AYFwfJCTg5v8suCriMLrfAdPgL4LLy6aBL5OAm6hHUFGTR8
 NphGmbLTGwnNHT3GXGatBg7BiLxMLbIxPAViBjY8EdY2W5mpQF/alyKddncqSDJvhgJi
 9/Qg==
X-Gm-Message-State: AOJu0YyNrqEMaz5A7ue/ZN0yY4R8wnH+SaT+oFsLC6y8qLnFO70E4lMQ
 zFoctDL2Isoy2+86nOo6xbwP/ivHhQzqIriM955ftJXcHDmbyk0VILiYAfPzXH5mUYINoB67fpg
 PHQ==
X-Gm-Gg: ASbGnctOi8o8n7zLnDeof3lo/nU3k1vN8fJheMaSKX2z/9xIeSSblX3+CJwiN7MeOjO
 +CYQRg7w7tgFLCOprWynDVPz41UCUv7Sy5QwRHUeU7YiIqVcgZTwvpwgn5sTnVy+xSIGoCotxeR
 eK9xaAaesjHg2523BA2Lzua/ms2zUnEyrAPkBHy4l2bTxFJlNYnhG57yE9MQ3HPqeCqD6WapPdA
 XC9QwyS9/lVURIQDsJ+iI13ut9OFNiVlAoEl7wJxXV2EeraX1cMiVlPXqYC3b6iwZ9zRSASywD8
 PRAGzDvuciiTXFslpMZ7hBGfoVEufg==
X-Google-Smtp-Source: AGHT+IHvFPYYHUz7CMuYAQPLTsSHt2rJ6laN+xy5rOmW8XUqJv2y5lK5a50A0j939BhYXVmtS7jBFQ==
X-Received: by 2002:a05:6000:248a:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-39ea51eeac4mr10300626f8f.2.1744638001037; 
 Mon, 14 Apr 2025 06:40:01 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b02a3223545sm9171521a12.78.2025.04.14.06.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 06:40:00 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 14 Apr 2025 21:39:20 -0400
Message-ID: <20250415013944.173030-3-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415013944.173030-1-wegao@suse.com>
References: <20250410054956.5071-1-wegao@suse.com>
 <20250415013944.173030-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: #535
Local test show EOPNOTSUPP on exfat/vfat/ntfs/tmpfs,
so descope related file system currently.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 77e3c942f..932b7030c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -609,6 +609,7 @@ ioctl_ficlone02 ioctl_ficlone02
 ioctl_ficlone03 ioctl_ficlone03
 ioctl_ficlonerange01 ioctl_ficlonerange01
 ioctl_ficlonerange02 ioctl_ficlonerange02
+ioctl_fiemap01 ioctl_fiemap01
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 1f099ff95..53a82bb57 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -28,3 +28,4 @@
 /ioctl_ficlone04
 /ioctl_ficlonerange01
 /ioctl_ficlonerange02
+/ioctl_fiemap01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
new file mode 100644
index 000000000..da145e68b
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify basic fiemap ioctl functionality, including:
+ *
+ * - The ioctl returns EBADR if it receives invalid fm_flags.
+ * - 0 extents are reported for an empty file.
+ * - The ioctl correctly retrieves single and multiple extent mappings after writing to the file.
+ */
+
+#include <linux/fs.h>
+#include <linux/fiemap.h>
+#include <stdlib.h>
+#include <sys/statvfs.h>
+
+#include "tst_test.h"
+
+#define MNTPOINT "mntpoint"
+#define TESTFILE "testfile"
+#define NUM_EXTENT 3
+
+static void print_extens(struct fiemap *fiemap)
+{
+	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
+
+	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
+		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
+				i + 1,
+				fiemap->fm_extents[i].fe_logical,
+				fiemap->fm_extents[i].fe_physical,
+				fiemap->fm_extents[i].fe_flags,
+				fiemap->fm_extents[i].fe_length);
+	}
+}
+
+static void check_extent_count(struct fiemap *fiemap, unsigned int fm_mapped_extents)
+{
+	TST_EXP_EXPR(fiemap->fm_mapped_extents == fm_mapped_extents,
+		"Check extent fm_mapped_extents is %d", fm_mapped_extents);
+}
+
+static void check_extent(struct fiemap *fiemap,	int index_extents, unsigned int fe_mask,
+					unsigned int fe_flags, unsigned int fe_length)
+{
+	struct fiemap_extent *extent = &fiemap->fm_extents[index_extents];
+
+	TST_EXP_EQ_LU((extent->fe_flags & fe_mask), fe_flags);
+	TST_EXP_EXPR(extent->fe_physical >= 1, "Check fe_physical > %d", 1);
+	TST_EXP_EQ_LU(extent->fe_length, fe_length);
+}
+
+static void verify_ioctl(void)
+{
+	int fd;
+	struct fiemap *fiemap;
+	struct statvfs fs_info;
+	unsigned long blk_size;
+
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+
+	SAFE_STATVFS(".", &fs_info);
+
+	blk_size = fs_info.f_bsize;
+
+	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
+	fiemap->fm_start = 0;
+	fiemap->fm_length = ~0ULL;
+	fiemap->fm_extent_count = 1;
+
+	fiemap->fm_flags = -1;
+	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
+
+	fiemap->fm_flags =  0;
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	TST_EXP_EXPR(fiemap->fm_mapped_extents == 0,
+		"Empty file should have 0 extends mapped");
+
+	char *buf = SAFE_MALLOC(blk_size);
+
+	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, blk_size);
+	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	check_extent_count(fiemap, 1);
+	check_extent(fiemap, 0, FIEMAP_EXTENT_LAST, FIEMAP_EXTENT_LAST, blk_size);
+
+	fiemap->fm_extent_count = NUM_EXTENT;
+	SAFE_LSEEK(fd, 2 * blk_size, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
+	SAFE_LSEEK(fd, 4 * blk_size, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
+	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
+	print_extens(fiemap);
+	check_extent_count(fiemap, NUM_EXTENT);
+
+	for (int i = 0; i < NUM_EXTENT - 1; i++)
+		check_extent(fiemap, i, FIEMAP_EXTENT_LAST, 0, blk_size);
+
+	check_extent(fiemap, NUM_EXTENT - 1, FIEMAP_EXTENT_LAST, FIEMAP_EXTENT_LAST, blk_size);
+
+	free(buf);
+	free(fiemap);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(TESTFILE);
+}
+
+static void setup(void)
+{
+	SAFE_CHDIR(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
+	},
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
