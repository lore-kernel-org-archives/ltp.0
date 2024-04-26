Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD627C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 09:52:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1555C3D03FB
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 11:52:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272363D0323
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 15:48:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0993320172D
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 15:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714139289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l/M09QdNtQPgUiNo1H6FwIu5Ec5EJMdtE+7cuUy75Lw=;
 b=V/WYQ4ifFRz4G0XW4HlN7UiSX0XLkZHCIJYCnu21iDnh32ksYy+5CNUHT4LkcrLYGh9puV
 mEqx9CXi3hWsgPm6UJXJc/0fiDCmC6Qo7q0V9t8h4TKEKvIQqUKnt0cTOzGjoEMEcWmwW0
 5r/2gKDZMYVy+bw8d3c4GvNvWTjRpSo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-FUthokGHOoO3TSRAQwtrgw-1; Fri, 26 Apr 2024 09:48:08 -0400
X-MC-Unique: FUthokGHOoO3TSRAQwtrgw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4393e712cd5so26924641cf.3
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 06:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714139287; x=1714744087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l/M09QdNtQPgUiNo1H6FwIu5Ec5EJMdtE+7cuUy75Lw=;
 b=qcD2dmI1CYOdivJh0N+MCqhUpDoZhRkvcxeWNzeVkAzGCSZaHsFlzMrWwtuxDJ1GM1
 ZH29OyNbemJEpfw9iypC9MnRMz4fPZrNxfjvn8Lki3ClcPe+8cRr3KbRM9n+mplgHGsd
 OHItedGTFaeLPRcOej24lT5X+mT7Oaf4HoMfteAWrfhRWVRmULIhwfix4kzhQjZCngxv
 e6+RCgv/JbpKyB1kYaPJhUEkseTOC3yz0rCv/jijnqvALrKUl+Gd58fSommbDLpKMRJm
 qRaJAgnA044OShXDMrYoPssyGynjsSURWluXKZA+GOtTizSAVJXPC3whv/3DcfC6CieF
 jDvQ==
X-Gm-Message-State: AOJu0Yxehr7ui5QIyiu0nk1UNEwUIgLyoNk07kxlnPXbIcit/v2cDEHM
 G4zRtH/mVWVoL71JyNsMmhUFGHnXpB6+fmw332VF+BmOaRyTnft5qYZA4K7U5OqlNea/CSXUHHb
 YcfZ+J/chwur9hjNFEZgh56yhUBPYS91SP1gIuMaukpTYRUTz+/gFdklTdHTscrDPJgPFdxAzTd
 3zaVUki+1DQ+Bxr1oPpovi+8c1p27XNTVS
X-Received: by 2002:ac8:584e:0:b0:439:db10:84f5 with SMTP id
 h14-20020ac8584e000000b00439db1084f5mr3362851qth.28.1714139287136; 
 Fri, 26 Apr 2024 06:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+fHwkUdo4xfiQFY38g0D16AdiFeMrZcwqq2Cy9ZJtDeFyf6b8gvGHszt3SjTI1WcRsX54bA==
X-Received: by 2002:ac8:584e:0:b0:439:db10:84f5 with SMTP id
 h14-20020ac8584e000000b00439db1084f5mr3362822qth.28.1714139286730; 
 Fri, 26 Apr 2024 06:48:06 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb
 (host-79-50-126-211.retail.telecomitalia.it. [79.50.126.211])
 by smtp.gmail.com with ESMTPSA id
 ev14-20020a05622a510e00b0043971e215a7sm5902290qtb.60.2024.04.26.06.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 06:48:06 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 26 Apr 2024 15:48:02 +0200
Message-ID: <20240426134802.2607150-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 29 Apr 2024 11:52:22 +0200
Subject: [LTP] [PATCH] syscalls/mlock05: add mlock test for locking and
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

check VmRSS and VmLck variables from /proc/$pid/status.
VmRSS size should at least as big as the memory allocation.
VmLck size should be equal to the size of the memory allocation.

Co-developed-by: Dennis Brendel <dbrendel@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mlock/.gitignore |  1 +
 testcases/kernel/syscalls/mlock/mlock05.c  | 69 ++++++++++++++++++++++
 3 files changed, 71 insertions(+)
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
index 000000000..e67cd1e03
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -0,0 +1,69 @@
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
+ * Checks the variables VmRSS and VmLck in /proc/$pid/status after the
+ * mlock syscall:
+ * - VmRSS size should be at least as big as the memory allocation
+ * - VmLck size should be equal to the size of the memory allocation
+ */
+
+#include "tst_test.h"
+
+#define MMAPLEN			(1UL<<20)
+
+static void verify_mlock(void)
+{
+	unsigned long VmRSS_before;
+	unsigned long VmRSS_after;
+	unsigned long VmLck_before;
+	unsigned long VmLck_after;
+	unsigned long VmRSS;
+	unsigned long VmLck;
+	char *buf;
+
+	buf = SAFE_MMAP(NULL, MMAPLEN, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmRSS: %lu", &VmRSS_before);
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &VmLck_before);
+
+	SAFE_MLOCK(buf, MMAPLEN);
+
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmRSS: %lu", &VmRSS_after);
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %lu", &VmLck_after);
+
+	VmRSS = VmRSS_after - VmRSS_before;
+	VmLck = VmLck_after - VmLck_before;
+
+	// Convertion from KiB to B
+	VmRSS *= 1024;
+	VmLck *= 1024;
+
+	if (VmRSS >= MMAPLEN) {
+		tst_res(TPASS, "Pre-allocation functionality of mlock() successful");
+	} else {
+		tst_brk(TBROK, "Expected pre-allocation of %lu bytes, "
+					"get %lu pre-allocated", MMAPLEN, VmRSS);
+	}
+
+	if (VmLck == MMAPLEN) {
+		tst_res(TPASS, "Locking functionality of mlock() successful");
+	} else {
+		tst_brk(TBROK, "Expected locking of %lu bytes, "
+					"get %lu locked", MMAPLEN, VmLck);
+	}
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
