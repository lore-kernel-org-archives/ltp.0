Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1347DE7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 05:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736747582; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Qsk//KFZdr83z/fiw0OOeP3NYSeky0Ik2GOfpTjORfQ=;
 b=eBmMwPkCTorw6znpbdcd6Dht7zNJ3ZUiqaU05Ot+P3sBddAd2S6y+1owlb+2bZihTeIGO
 laa3+B1c1hiYiDk1uIRvzrkbFeyWi4+AQk0B5yhAWSsPYcNISdy1bJWAOuwK+NkLRRQIsuy
 F51PSSwEz5Sc9Lg28KB2KQPIk0u0wTI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49F703C6BB9
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 06:53:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE80D3C054D
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 06:52:40 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA37C1BDC8D3
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 06:52:39 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f796586so39601495e9.3
 for <ltp@lists.linux.it>; Sun, 12 Jan 2025 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736747559; x=1737352359; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LYdpmsM4HUytATVdwEYvZkGn0FquV/a0IK+Vvs4Q6kc=;
 b=b6Th1qixcVyjY5vFNbI0WZa346qbwCG+M/bm0rADP6JAK0kKbj07/FjomIoLxXPvtm
 AR93lSHOtL36wMR0iwAz503WaD8L//GuhPDLmQ3zXawO+e/79yqQ7uix5apmh0PiPeZV
 S4DH8xTiTAAcTp576+eMwHBXEc+ysQr9RYqbX9j5Fdg85e/zYGoeEyTrgpnKg3J2vW1r
 wamzpkb385mCJUHwiLo/LVdFHf6v9S3nO4rUi8jaMqBpjq41qoiYnCRt/tgZBFZq+qIb
 AtZied5zEQ2sNDply+B0uJS+Tg+4c6aP6ZYXa+e9/zlNyRKalHrWnTWGQc2sU/ID3jVB
 s/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736747559; x=1737352359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYdpmsM4HUytATVdwEYvZkGn0FquV/a0IK+Vvs4Q6kc=;
 b=G7tK+qAxTaBxgmp8wAjhzVR4lwFJTixYye5V1A/sHjTFZLffzysVPtXjFdUJd4zqRF
 EbTsFWGGh2BM4t08pkjGhLc4PIHn1AQBB379p63sJWMi2L7HOk478U+dm1j6PjgbUU3H
 Dl8UxFYvcW8H8TFUrRqXmBIgthqGgBK5wG8IH2U5yMM1peGP76WkHUCoT+/29Lm3VOn1
 9UpModIGp4ojeZQ0VFfCCWigWFCtRQdv1q6C9dgmEDM7Xru+T2ZpQiKLChv1vkp479Xp
 Y9ycdl/4miXNVQYiyVh1st/WO9QwYuWbwVQ9HnRAyjZUqiV1f5VKGf31N45RvLplB+I1
 NWUw==
X-Gm-Message-State: AOJu0YxZOgJdUQ5bjOudLKtkSMrG5sl0QEktytqevtdD7F+N8ZTRy9vl
 cJNQXyG3+i+eLAamT/5C7DhgGYzkb4cziWiOySNRIf3KA1KIDgLuD66A+AZqLY/+NVGquCBq8u4
 =
X-Gm-Gg: ASbGnctcqOGQSa26SGfgJO//zzdxO0JEIizBAyMRiy08J5vmQ2kBngbr6QlF6KeFJKD
 8+WWCdHkZCh8kgw9V07URqOR1w5515izrPicWNpkS16rjVBugCLJAS+wd5aS1V3YQ5pzzsXlJdL
 B62LjGKayV0z+Lb2GzGCiJ/QH0/3N+Hk7i03Cz0qS+bv9YwCp0oWbpvHC3F/V6XOSUfgRdW+sd/
 JZ+5UvlWi5XJGaJtKWRkwCC9b9Nllg1mT6xQCI4EJqPUw==
X-Google-Smtp-Source: AGHT+IFtcTsqElT0zAWnIRNff8steQm5+hrFX7Efd/dUL8mNyeJSZSA1GJmqTmVfqjn4NI4iH58Tqw==
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr182836235e9.7.1736747558770; 
 Sun, 12 Jan 2025 21:52:38 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da6271sm166033625e9.9.2025.01.12.21.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 21:52:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 13 Jan 2025 00:52:31 -0500
Message-Id: <20250113055231.5908-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                               |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl10.c  | 175 +++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl10.c

diff --git a/configure.ac b/configure.ac
index 6992d75ca..56380d41e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -179,6 +179,7 @@ AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error
 		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_clone_range],,,[#include <linux/fs.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
+AC_CHECK_TYPES([struct procmap_query],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
 #define _GNU_SOURCE
diff --git a/runtest/syscalls b/runtest/syscalls
index ded035ee8..a13811855 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -583,6 +583,7 @@ ioctl06      ioctl06
 ioctl07      ioctl07
 ioctl08      ioctl08
 ioctl09      ioctl09
+ioctl10      ioctl10
 
 ioctl_loop01 ioctl_loop01
 ioctl_loop02 ioctl_loop02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 1f099ff95..9c3f66bf1 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -7,6 +7,7 @@
 /ioctl07
 /ioctl08
 /ioctl09
+/ioctl10
 /ioctl_loop01
 /ioctl_loop02
 /ioctl_loop03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
new file mode 100644
index 000000000..cd9e3c528
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test PROCMAP_QUERY ioctl() for /proc/$PID/maps.
+ * Test base on kernel selftests proc-pid-vm.c.
+ *
+ * 1. Ioctl with exact match query_addr
+ * 2. Ioctl without match query_addr
+ * 3. Check COVERING_OR_NEXT_VMA query_flags
+ * 4. Check PROCMAP_QUERY_VMA_WRITABLE query_flags
+ * 5. Check vma_name_addr content
+ */
+
+#include "config.h"
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <fnmatch.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include <sys/sysmacros.h>
+
+#ifdef HAVE_STRUCT_PROCMAP_QUERY
+#include <linux/fs.h>
+
+struct map_entry {
+	unsigned long vm_start;
+	unsigned long vm_end;
+	char vm_flags_str[5];
+	unsigned long vm_pgoff;
+	unsigned int vm_major;
+	unsigned int vm_minor;
+	unsigned long vm_inode;
+	char vm_name[256];
+	unsigned int vm_flags;
+};
+
+static unsigned int parse_vm_flags(const char *vm_flags_str)
+{
+	unsigned int flags = 0;
+
+	if (strchr(vm_flags_str, 'r'))
+		flags |= PROCMAP_QUERY_VMA_READABLE;
+	if (strchr(vm_flags_str, 'w'))
+		flags |= PROCMAP_QUERY_VMA_WRITABLE;
+	if (strchr(vm_flags_str, 'x'))
+		flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
+	if (strchr(vm_flags_str, 's'))
+		flags |= PROCMAP_QUERY_VMA_SHARED;
+
+	return flags;
+
+}
+
+static int parse_maps_file(const char *filename, const char *keyword, struct map_entry *entry)
+{
+	FILE *fp = SAFE_FOPEN(filename, "r");
+
+	char line[1024];
+
+	while (fgets(line, sizeof(line), fp) != NULL) {
+		if (fnmatch(keyword, line, 0) == 0) {
+			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
+						&entry->vm_start, &entry->vm_end, entry->vm_flags_str,
+						&entry->vm_pgoff, &entry->vm_major, &entry->vm_minor,
+						&entry->vm_inode, entry->vm_name) < 7)
+				return -1;
+
+			entry->vm_flags = parse_vm_flags(entry->vm_flags_str);
+
+			SAFE_FCLOSE(fp);
+			return 0;
+		}
+	}
+
+	SAFE_FCLOSE(fp);
+	return -1;
+}
+
+static void verify_ioctl(void)
+{
+	char path_buf[256];
+	struct procmap_query q;
+	int fd;
+	struct map_entry entry;
+
+	memset(&entry, 0, sizeof(entry));
+
+	snprintf(path_buf, sizeof(path_buf), "/proc/%u/maps", getpid());
+	fd = SAFE_OPEN(path_buf, O_RDONLY);
+
+	TST_EXP_PASS(parse_maps_file(path_buf, "*", &entry));
+
+	/* CASE 1: exact MATCH at query_addr */
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = (__u64)entry.vm_start;
+	q.query_flags = 0;
+
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
+
+	TST_EXP_EQ_LU(q.query_addr, entry.vm_start);
+	TST_EXP_EQ_LU(q.query_flags, 0);
+	TST_EXP_EQ_LU(q.vma_flags, entry.vm_flags);
+	TST_EXP_EQ_LU(q.vma_start, entry.vm_start);
+	TST_EXP_EQ_LU(q.vma_end, entry.vm_end);
+	TST_EXP_EQ_LU(q.vma_page_size, getpagesize());
+	TST_EXP_EQ_LU(q.vma_offset, entry.vm_pgoff);
+	TST_EXP_EQ_LU(q.inode, entry.vm_inode);
+	TST_EXP_EQ_LU(q.dev_major, entry.vm_major);
+	TST_EXP_EQ_LU(q.dev_minor, entry.vm_minor);
+
+	/* CASE 2: NO MATCH at query_addr */
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = entry.vm_start - 1;
+	q.query_flags = 0;
+
+	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
+
+	/* CASE 3: MATCH COVERING_OR_NEXT_VMA */
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = entry.vm_start - 1;
+	q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
+
+	/* CASE 4: NO MATCH WRITABLE at query_addr */
+	memset(&entry, 0, sizeof(entry));
+	TST_EXP_PASS(parse_maps_file(path_buf, "*r-?p *", &entry));
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = entry.vm_start;
+	q.query_flags = PROCMAP_QUERY_VMA_WRITABLE;
+	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
+
+	/* CASE 5: check vma_name_addr content */
+	char process_name[256];
+	char pattern[256];
+	char buf[256];
+
+	SAFE_READLINK("/proc/self/exe", process_name, sizeof(process_name));
+	sprintf(pattern, "*%s*", process_name);
+	memset(&entry, 0, sizeof(entry));
+	TST_EXP_PASS(parse_maps_file(path_buf, pattern, &entry));
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = entry.vm_start;
+	q.query_flags = 0;
+	q.vma_name_addr = (__u64)(unsigned long)buf;
+	q.vma_name_size = sizeof(buf);
+
+	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
+	TST_EXP_EQ_LU(q.vma_name_size, strlen(process_name) + 1);
+	TST_EXP_EQ_STR((char *)q.vma_name_addr, process_name);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+};
+#else
+	TST_TEST_TCONF(
+		"This system does not provide support for ioctl(PROCMAP_QUERY)");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
