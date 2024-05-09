Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E753C25B10
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 13:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B9C3CE2DB
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 15:37:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFCD73CB172
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:37:21 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDC211001134
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H6PCnKThG6LVex0R0ZAsiZ/QFrJ0RUt80wRghiuubmM=;
 b=ODVP0tU2Ue2oWoZIkd8GZOpzWYHQ5OrupGgDrewd+zxFsTCTwAxQrRWukNSt+43RdBhmci
 z/Qk72niN8DaYETlAX/NjMq/Sk8mMCKXKK2PA86caS0SVPIuoUPtbn14Bf/8QS7OC3sEDe
 pJ+AMeKHiHHbFmaoHDg3fpFYxD2JlGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-OjNvJlqbOP-cFBSGylq1Eg-1; Thu, 09 May 2024 09:37:17 -0400
X-MC-Unique: OjNvJlqbOP-cFBSGylq1Eg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34d91608deaso539088f8f.0
 for <ltp@lists.linux.it>; Thu, 09 May 2024 06:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261836; x=1715866636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6PCnKThG6LVex0R0ZAsiZ/QFrJ0RUt80wRghiuubmM=;
 b=cgod1/SGu7eXPuRsZ5QpOBd6mIQeG/c1CSiW0k3DVk1SCPVbkQr9EFaQc1iXcGt6nY
 0In0dqm8HuE76TJzxJkdlHRnBLslrkED60L2E7Zp/lQpHLut8XcdrQSPgl/hqns3hUPe
 rh/C4uaysrVnhn4D3gd993QxTVgDtkHRgR/ZEcHs85CxPAZG94ir/Md7ZjGY+ZQULXNu
 nnPNR+VmkEQI+QyKM7p/fEjaf5gRcRnQ+NtL8llh7tlqDXPnVJ8A1wctgoVNjZkLKHG0
 QsbVC2gep7KuzEBp7MBZspXJakKVndmMIKQPAw+A89U48CXqENGZv7NcPjX9NqMnTkHS
 PkcA==
X-Gm-Message-State: AOJu0Yzevo8Uwf5MWPXruvs39DKq3lAXDh+O/u0lZSHI3GmFKrMM1t6O
 WpOzgtqKJkwUGQlJigTTVXqlA7v5v5aGKSSzTXogQ+f/Vz38eBO/xtWk79qEU0k35P6zGKyEqiH
 uup8yG2Z3D6NoLShD/1BKjz3Fk4SZOznwhwjAM0Qn1i2df3eQCb6aVq+dvkb+nQXg4hW16Kc9y5
 Wljq5FOeX6Ke3byJA2Tv30rwpIx+Y3xn9Z
X-Received: by 2002:adf:e752:0:b0:34f:824:17b2 with SMTP id
 ffacd0b85a97d-34fca80d99bmr3411179f8f.65.1715261836252; 
 Thu, 09 May 2024 06:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhcbsauK1yqd14bIiJVlNNIF5/8TaCetBjXgSc75NoLuImV3gqeY1feZ08551gWDPeGIErpQ==
X-Received: by 2002:adf:e752:0:b0:34f:824:17b2 with SMTP id
 ffacd0b85a97d-34fca80d99bmr3411166f8f.65.1715261835871; 
 Thu, 09 May 2024 06:37:15 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([78.209.176.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbc4b41sm1722254f8f.113.2024.05.09.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:37:15 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 May 2024 15:37:12 +0200
Message-ID: <20240509133712.3383293-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/mlock05: add mlock test for locking and
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
 testcases/kernel/syscalls/mlock/mlock05.c  | 103 +++++++++++++++++++++
 3 files changed, 105 insertions(+)
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
index 000000000..4b131d0dd
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -0,0 +1,103 @@
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
+ * Rss and Locked size should be equal to the size of the memory allocation
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
+	// find desired mapping
+	while (fgets(buffer, LINELEN, file) != NULL) {
+		unsigned long mapping_address;
+
+		// check the starting address
+		ret = sscanf(buffer, "%lx[^-]", &mapping_address);
+
+		if ((ret == 1) && (mapping_address == desired_mapping_address)) {
+			mapping_found = true;
+			break;
+		}
+	}
+
+	if (!mapping_found) {
+		fclose(file);
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
+
+			if (ret != 1) {
+				tst_brk(TBROK, "failure occured while reading field %s", desired_field);
+				return 0;
+			}
+
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
+	unsigned long Locked;
+	unsigned long Rss;
+	char *buf;
+
+	buf = SAFE_MMAP(NULL, MMAPLEN, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	SAFE_MLOCK(buf, MMAPLEN);
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
