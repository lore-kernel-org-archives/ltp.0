Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225C8C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 13:24:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 873963CE11F
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 15:24:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A54D3CE05A
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:24:09 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4014F1A00E6C
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IyHOG8hEACjU2TLhKqOVLw1DDy68lMuixwjJzO1lTBk=;
 b=JLdeRGu3ZZNFI2G9Ksi6NdWEc3+osc0LiYlKnel6I+ToCMR7ruKn2nUHOwiQtIQ1ZFGjTi
 H1kRIb8NSTNYhUHBP+uh8dvBmOveWfCYVPZrVK18mn8p8PaLrmtLJRpUaqrRBLLSaJgho8
 ApjU1iA7DYNQQrQy5sls3yn2Z/3n7JM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-fj36CGyIMMOJ56rVvPvJ0A-1; Thu, 09 May 2024 09:24:04 -0400
X-MC-Unique: fj36CGyIMMOJ56rVvPvJ0A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e3dcc3471aso5709551fa.1
 for <ltp@lists.linux.it>; Thu, 09 May 2024 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261043; x=1715865843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IyHOG8hEACjU2TLhKqOVLw1DDy68lMuixwjJzO1lTBk=;
 b=OT9AUB7t/Kak5fIvTFwoKIxomQDWq4W1laAzkQGxCVeFFxliY+CvGf9pdGAiChOOp0
 ivZyODy7OP2YjGs6wxGBuxWWzg92bNtDkpHrUZj+ZKIXhdD/vxSOx/F4znXPc0yHhERs
 biKDWEUrBoflYkxadOFiOLVMKxDbB4pb2mMbyTC3sHIsGEX6H2xKpOpvcAQAmW3VEMmQ
 sPjV9S+DuNmCXYDzMUOpF0HXV2/5nu6TZSuy5KQV0z78I22M4hXn7ICfV7gmvDxTCyz2
 vlo4gjoglqpa6Vu8aSCU9ORLUSnZXgmVslt4MpdgK9QpNU0aY1cTp883hO12cX6Kdej6
 5wsQ==
X-Gm-Message-State: AOJu0YzMO28aeBWj22UUbEGBM0g68NjzGPcJvCUJFdRUULhIYfLP8Myj
 ByV0NU2mXpATnWjg0P3J66PPnJdZIOY+/SA69JcxFrWBezQvi2inulMW6MZQ77GzgctNu+02ZYH
 LpFsh32WxMb3N5zkBp+0FOgExOsqGBogfk5ht3W0Wuia2c42T69U/g1EfF0P8cmdCpNnfvFdCt8
 YF4mG3JhX2ZyAoFPqpzCS44N7FxaIOZtod
X-Received: by 2002:a2e:80c2:0:b0:2d6:d351:78ae with SMTP id
 38308e7fff4ca-2e44759fb43mr37340131fa.29.1715261043196; 
 Thu, 09 May 2024 06:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1HK2moIM6CDTMFKlVKn0oAqwZMlBTXK09zcQBair8ZviNwLKpssZoG6OdpYuL8XQkPF52Uw==
X-Received: by 2002:a2e:80c2:0:b0:2d6:d351:78ae with SMTP id
 38308e7fff4ca-2e44759fb43mr37339921fa.29.1715261042720; 
 Thu, 09 May 2024 06:24:02 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([78.209.176.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88208886sm60801615e9.45.2024.05.09.06.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:24:02 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 May 2024 15:23:58 +0200
Message-ID: <20240509132358.3370390-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/mlock05: add mlock test for locking and
 pre-faulting of memory
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
Cc: Filippo Storniolo <fstornio@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

check Rss and Locked variables from /proc/$pid/smaps of the
the new memory mapping.
Rss and Locked size should be equal to the size
of the memory allocation.

Co-developed-by: Dennis Brendel <dbrendel@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/mlock/.gitignore |   1 +
 testcases/kernel/syscalls/mlock/mlock05.c  | 107 +++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mlock/mlock05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 252123d8b..05a52fc8f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -781,6 +781,7 @@ mlock01 mlock01
 mlock02 mlock02
 mlock03 mlock03 -i 20
 mlock04 mlock04
+mlock05 mlock05
 
 mlock201 mlock201
 mlock202 mlock202
diff --git a/testcases/kernel/syscalls/mlock/.gitignore b/testcases/kernel/syscalls/mlock/.gitignore
index 306574bbc..1872229b8 100644
--- a/testcases/kernel/syscalls/mlock/.gitignore
+++ b/testcases/kernel/syscalls/mlock/.gitignore
@@ -2,3 +2,4 @@
 /mlock02
 /mlock03
 /mlock04
+/mlock05
diff --git a/testcases/kernel/syscalls/mlock/mlock05.c b/testcases/kernel/syscalls/mlock/mlock05.c
new file mode 100644
index 000000000..e7714453f
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Red Hat
+ * Author: Filippo Storniolo <fstornio@redhat.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify mlock() causes pre-faulting of PTEs and prevent memory to be swapped out.
+ *
+ * Find the new mapping in /proc/$pid/smaps and check Rss and Locked fields after
+ * mlock syscall:
+ * - Rss and Locked size should be equal to the size of the memory allocation
+ */
+
+#include "tst_test.h"
+
+#define MMAPLEN			(1UL<<20)
+#define LINELEN			256
+
+static unsigned long get_proc_smaps_field(unsigned long desired_mapping_address, char *desired_field)
+{
+	bool mapping_found = false;
+	char buffer[LINELEN] = "";
+	FILE *file = NULL;
+	int ret = 0;
+
+	file = fopen("/proc/self/smaps", "r");
+	if (file == NULL) {
+		tst_brk(TBROK | TERRNO, "cannot open file proc/self/smaps");
+		return 0;
+	}
+
+	// find desired field
+	while (fgets(buffer, LINELEN, file) != NULL) {
+		unsigned long mapping_address;
+
+		// check the starting address
+		ret = sscanf(buffer, "%lx[^-]", &mapping_address);
+
+		// most lines will not match the pattern for the mapping address
+		// so it is not treated as an error
+		if (ret == -1)
+			continue;
+
+		if (mapping_address == desired_mapping_address) {
+			mapping_found = true;
+			break;
+		}
+	}
+
+	if (!mapping_found) {
+		tst_brk(TBROK, "cannot find mapping %lx in proc/self/smaps", desired_mapping_address);
+		return 0;
+	}
+
+	// find desired field
+	while (fgets(buffer, LINELEN, file) != NULL) {
+		if (strstr(buffer, desired_field) != NULL) {
+			unsigned long desired_value;
+
+			// extract the value for the requested field
+			ret = sscanf(buffer, "%*[^0-9]%lu%*[^0-9]", &desired_value);
+			fclose(file);
+			if (ret != 1) {
+				tst_brk(TBROK, "failure occured while reading field %s", desired_field);
+				return 0;
+			}
+			return desired_value;
+		}
+	}
+
+	fclose(file);
+	tst_brk(TBROK, "cannot find %s field", desired_field);
+
+	return 0;
+}
+
+static void verify_mlock(void)
+{
+	unsigned long Rss;
+	unsigned long Locked;
+	char *buf;
+
+	buf = SAFE_MMAP(NULL, MMAPLEN, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MLOCK(buf, MMAPLEN);
+
+	printf("buf is %p\n", buf);
+
+	Rss = get_proc_smaps_field((unsigned long)buf, "Rss");
+	Locked = get_proc_smaps_field((unsigned long)buf, "Locked");
+
+	// Convertion from KiB to B
+	Rss *= 1024;
+	Locked *= 1024;
+
+	TST_EXP_EQ_LU(Rss, MMAPLEN);
+	TST_EXP_EQ_LU(Locked, MMAPLEN);
+
+	SAFE_MUNLOCK(buf, MMAPLEN);
+	SAFE_MUNMAP(buf, MMAPLEN);
+}
+
+static struct tst_test test = {
+	.test_all = verify_mlock,
+};
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
