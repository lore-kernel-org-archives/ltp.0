Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431E5C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740574331; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=s/CHQZToblLyphOQ3KBIRB+Pjrtbm0jf2JN6IrN4s8o=;
 b=Lrz9Uf7YNaqLA9YIpjNica0A1XV1BFgD9QNEl/ySM889doXz7pfCybFyfE8imbyShTydU
 2moUjPdoy5nvCZGy4LvDOd5jP7QOGUfFbbaU/LA86Y0o04YFP2f4qLTOfVUhEi3++uUMmqH
 6IXofhC3Aj4tX81Qw5kFJwxvPjGO80Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7846E3C9CE1
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 13:52:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76ED33C7D28
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 13:51:49 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D61D1BC670B
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 13:51:48 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390dc0a7605so299446f8f.1
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740574307; x=1741179107; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42bkecPE/CTLaJjUm3pFuVvhv2+clBNGbfwoicwgEeU=;
 b=DVTHHG+ULXT7z4eBhahfjbhgAhhPXpcpOg2wN/H+TcnPnz+UIEJch2q7rpRofRFhBd
 Nr4/fm4dX8uTe3rjXj2IFSf2PGmUOfw60qDyeJPn3wz0bMV8xYPMSnMVMat5RS84jx9f
 oiZe7Bmi0+yqhRoamVNVT9XWSrNmQJ1McDoaxeKZKKovKUaD2+z1VekD/cUP4koQln7K
 7wtBkNr+NLyo4pduLYCReaBwRAr5gI4qVOSTZxs+P1qkCnsf3Ixn0d5O3YkffdI83QR+
 znWMyHwLvGwCeMScPr0VgqQkiGJ8fvWiB5rePzYIcW7zle2o/8UTFUZGflFE7dl1xAuo
 C04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740574307; x=1741179107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42bkecPE/CTLaJjUm3pFuVvhv2+clBNGbfwoicwgEeU=;
 b=BYkvCebN7DxPaqA8UKzgJoh2pKrd2PCt10Frt4QVnhJt3d7bMLDUfsi+GfhYD908pn
 vugSt9TPQBN+S4x9LKM7slQU8iPtaQGuSBcDxOIpVTN484lN+Hc3Z17HOFe+5NrEV1Bo
 oXJETe4wI090UqOWgeWP/013TayBvI3K9j7H2xmszd6cxusj14cJs26WKOBYNC7tRtzr
 WozOlm3zbwhOXTH56BZCvw5qWip3AUjWCPkSlIifopOJzyVgbvIICI0lvmLL0ncC62Bn
 ES9zaewBFZeeUy+tzYvS2KRDFsbUxVaFbnUQzOhIgJxH0jiMPT7H3gt0UgI7BU2tBTdk
 F1OQ==
X-Gm-Message-State: AOJu0YwHiCdsFGk3jNNwkk3fbki8g+kMZ8LQ0Fgm4cnE45uwFq3t66fT
 h7uca6fYRmcrKFExbiwj61lNUYrTxXFxLqzN6h3UdnjQ6r1zYZQBTtP02AHDkk8yOaDPvmNYxVs
 +Tg==
X-Gm-Gg: ASbGncssSVhvaNp0M5lX/NHEf3N4X9QcyT/qZaSrlEsi/iWFjLtsXXfF1WmU2xYLWmm
 gdq5Hz549owWKK6HGgyqwA6TA+LKTASjToF0dB3evbHZkq9ikLyY6X9aJADB55fJHOpon7oM/FG
 oHGSAHJKSJknpgFFsrrPci7sPpoYzhwpYdCMAaDkHt9di8gJZ2pGCfezgMacnGbBSIN/bQ4zfTO
 fO3ghCkiEqoav/iIKp8/Qz5sn+5CLSqhuu0bRejxIatcW33pT6nfc5dt1rVVV+NVzd1FwgGcCpb
 Y4B/+em63bw+pPexepN6p/f9ww==
X-Google-Smtp-Source: AGHT+IEVePqAc1N/NUCqRmpifa8ytzr5MwCQjp2L7SJjkd0DVC1KC4IkKnWnnoNaBfc98NlqioaI5A==
X-Received: by 2002:a05:6000:1548:b0:38d:daf3:be60 with SMTP id
 ffacd0b85a97d-390cc63ccf0mr6961567f8f.48.1740574306903; 
 Wed, 26 Feb 2025 04:51:46 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc31fsm5425610f8f.87.2025.02.26.04.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 04:51:46 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 26 Feb 2025 07:51:41 -0500
Message-Id: <20250226125141.27417-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250113055231.5908-1-wegao@suse.com>
References: <20250113055231.5908-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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
 include/lapi/ioctl.h                       | 133 ++++++++++++++++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl10.c  | 177 +++++++++++++++++++++
 5 files changed, 313 insertions(+)
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
diff --git a/include/lapi/ioctl.h b/include/lapi/ioctl.h
index f91a9e68c..d0f8bf254 100644
--- a/include/lapi/ioctl.h
+++ b/include/lapi/ioctl.h
@@ -9,6 +9,7 @@
 
 #include "config.h"
 #include <sys/ioctl.h>
+#include <stdint.h>
 
 /* musl not including it in <sys/ioctl.h> */
 #include <sys/ttydefaults.h>
@@ -37,4 +38,136 @@ struct termio
 };
 #endif /* HAVE_STRUCT_TERMIO */
 
+#ifndef HAVE_STRUCT_PROCMAP_QUERY
+#define PROCFS_IOCTL_MAGIC 'f'
+#define PROCMAP_QUERY   _IOWR(PROCFS_IOCTL_MAGIC, 17, struct procmap_query)
+enum procmap_query_flags {
+        /*
+         * VMA permission flags.
+         *
+         * Can be used as part of procmap_query.query_flags field to look up
+         * only VMAs satisfying specified subset of permissions. E.g., specifying
+         * PROCMAP_QUERY_VMA_READABLE only will return both readable and read/write VMAs,
+         * while having PROCMAP_QUERY_VMA_READABLE | PROCMAP_QUERY_VMA_WRITABLE will only
+         * return read/write VMAs, though both executable/non-executable and
+         * private/shared will be ignored.
+         *
+         * PROCMAP_QUERY_VMA_* flags are also returned in procmap_query.vma_flags
+         * field to specify actual VMA permissions.
+         */
+        PROCMAP_QUERY_VMA_READABLE              = 0x01,
+        PROCMAP_QUERY_VMA_WRITABLE              = 0x02,
+        PROCMAP_QUERY_VMA_EXECUTABLE            = 0x04,
+        PROCMAP_QUERY_VMA_SHARED                = 0x08,
+        /*
+         * Query modifier flags.
+         *
+         * By default VMA that covers provided address is returned, or -ENOENT
+         * is returned. With PROCMAP_QUERY_COVERING_OR_NEXT_VMA flag set, closest
+         * VMA with vma_start > addr will be returned if no covering VMA is
+         * found.
+         *
+         * PROCMAP_QUERY_FILE_BACKED_VMA instructs query to consider only VMAs that
+         * have file backing. Can be combined with PROCMAP_QUERY_COVERING_OR_NEXT_VMA
+         * to iterate all VMAs with file backing.
+         */
+        PROCMAP_QUERY_COVERING_OR_NEXT_VMA      = 0x10,
+        PROCMAP_QUERY_FILE_BACKED_VMA           = 0x20,
+};
+
+struct procmap_query {
+        /* Query struct size, for backwards/forward compatibility */
+        uint64_t size;
+        /*
+         * Query flags, a combination of enum procmap_query_flags values.
+         * Defines query filtering and behavior, see enum procmap_query_flags.
+         *
+         * Input argument, provided by user. Kernel doesn't modify it.
+         */
+        uint64_t query_flags;              /* in */
+        /*
+         * Query address. By default, VMA that covers this address will
+         * be looked up. PROCMAP_QUERY_* flags above modify this default
+         * behavior further.
+         *
+         * Input argument, provided by user. Kernel doesn't modify it.
+         */
+        uint64_t query_addr;               /* in */
+        /* VMA starting (inclusive) and ending (exclusive) address, if VMA is found. */
+        uint64_t vma_start;                /* out */
+        uint64_t vma_end;                  /* out */
+        /* VMA permissions flags. A combination of PROCMAP_QUERY_VMA_* flags. */
+        uint64_t vma_flags;                /* out */
+        /* VMA backing page size granularity. */
+        uint64_t vma_page_size;            /* out */
+        /*
+         * VMA file offset. If VMA has file backing, this specifies offset
+         * within the file that VMA's start address corresponds to.
+         * Is set to zero if VMA has no backing file.
+         */
+        uint64_t vma_offset;               /* out */
+        /* Backing file's inode number, or zero, if VMA has no backing file. */
+        uint64_t inode;                    /* out */
+        /* Backing file's device major/minor number, or zero, if VMA has no backing file. */
+        uint32_t dev_major;                /* out */
+        uint32_t dev_minor;                /* out */
+        /*
+         * If set to non-zero value, signals the request to return VMA name
+         * (i.e., VMA's backing file's absolute path, with " (deleted)" suffix
+         * appended, if file was unlinked from FS) for matched VMA. VMA name
+         * can also be some special name (e.g., "[heap]", "[stack]") or could
+         * be even user-supplied with prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME).
+         *
+         * Kernel will set this field to zero, if VMA has no associated name.
+         * Otherwise kernel will return actual amount of bytes filled in
+         * user-supplied buffer (see vma_name_addr field below), including the
+         * terminating zero.
+         *
+         * If VMA name is longer that user-supplied maximum buffer size,
+         * -E2BIG error is returned.
+         *
+         * If this field is set to non-zero value, vma_name_addr should point
+         * to valid user space memory buffer of at least vma_name_size bytes.
+         * If set to zero, vma_name_addr should be set to zero as well
+         */
+        uint32_t vma_name_size;            /* in/out */
+        /*
+         * If set to non-zero value, signals the request to extract and return
+         * VMA's backing file's build ID, if the backing file is an ELF file
+         * and it contains embedded build ID.
+         *
+         * Kernel will set this field to zero, if VMA has no backing file,
+         * backing file is not an ELF file, or ELF file has no build ID
+         * embedded.
+         *
+         * Build ID is a binary value (not a string). Kernel will set
+         * build_id_size field to exact number of bytes used for build ID.
+         * If build ID is requested and present, but needs more bytes than
+         * user-supplied maximum buffer size (see build_id_addr field below),
+         * -E2BIG error will be returned.
+         *
+         * If this field is set to non-zero value, build_id_addr should point
+         * to valid user space memory buffer of at least build_id_size bytes.
+         * If set to zero, build_id_addr should be set to zero as well
+         */
+        uint32_t build_id_size;            /* in/out */
+        /*
+         * User-supplied address of a buffer of at least vma_name_size bytes
+         * for kernel to fill with matched VMA's name (see vma_name_size field
+         * description above for details).
+         *
+         * Should be set to zero if VMA name should not be returned.
+         */
+        uint64_t vma_name_addr;            /* in */
+        /*
+         * User-supplied address of a buffer of at least build_id_size bytes
+         * for kernel to fill with matched VMA's ELF build ID, if available
+         * (see build_id_size field description above for details).
+         *
+         * Should be set to zero if build ID should not be returned.
+         */
+        uint64_t build_id_addr;            /* in */
+};
+#endif /* HAVE_STRUCT_PROCMAP_QUERY */
+
 #endif /* LAPI_IOCTL_H__ */
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
index 000000000..7ab3e4c43
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -0,0 +1,177 @@
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
+#include <linux/fs.h>
+#include "lapi/ioctl.h"
+
+#define PROC_MAP_PATH "/proc/self/maps"
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
+static void parse_maps_file(const char *filename, const char *keyword, struct map_entry *entry)
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
+				tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
+
+			entry->vm_flags = parse_vm_flags(entry->vm_flags_str);
+
+			SAFE_FCLOSE(fp);
+			return;
+		}
+	}
+
+	SAFE_FCLOSE(fp);
+	tst_brk(TFAIL, "parse maps file /proc/self/maps failed");
+}
+
+static void verify_ioctl(void)
+{
+	struct procmap_query q;
+	int fd;
+	struct map_entry entry;
+
+	memset(&entry, 0, sizeof(entry));
+
+	fd = SAFE_OPEN("/proc/self/maps", O_RDONLY);
+
+	parse_maps_file(PROC_MAP_PATH, "*", &entry);
+
+	/* CASE 1: exact MATCH at query_addr */
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = (uint64_t)entry.vm_start;
+	q.query_flags = 0;
+
+	TEST(ioctl(fd, PROCMAP_QUERY, &q));
+
+	if ((TST_RET == -1) && (TST_ERR == ENOTTY))
+		tst_brk(TCONF,
+			"This system does not provide support for ioctl(PROCMAP_QUERY)");
+
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
+	parse_maps_file(PROC_MAP_PATH, "*r-?p *", &entry);
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
+	parse_maps_file(PROC_MAP_PATH, pattern, &entry);
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_addr = entry.vm_start;
+	q.query_flags = 0;
+	q.vma_name_addr = (uint64_t)(unsigned long)buf;
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
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
