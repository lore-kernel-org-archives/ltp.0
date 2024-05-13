Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA81C25B74
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 15:14:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DF413CF11A
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 17:14:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D55E3CEFD4
 for <ltp@lists.linux.it>; Mon, 13 May 2024 17:14:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF22C208196
 for <ltp@lists.linux.it>; Mon, 13 May 2024 17:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715613257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZAfVMjs+hq/FYsOaFgfjENfDdzd2xi3xJD06ME7NEm4=;
 b=D22T3vm3Rgx0d/UJrDNwgRmOgLopvRtA8315FqxtdYgDb03ds3odho8FWEA/chU44Ycuzx
 Kc5zhCksl+UzGml7WrDf6B6ACEmRYxxY458QJqS0Dr4csRrmDtQPHdttyXLx/JbLm8NNfS
 +Nj45AIyE1ZNkwaOKIMf59skllVZKvM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-sTZnjlfNMsOtfurq9GxAbQ-1; Mon, 13 May 2024 11:14:15 -0400
X-MC-Unique: sTZnjlfNMsOtfurq9GxAbQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-23d18580177so6809061fac.0
 for <ltp@lists.linux.it>; Mon, 13 May 2024 08:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715613254; x=1716218054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZAfVMjs+hq/FYsOaFgfjENfDdzd2xi3xJD06ME7NEm4=;
 b=WgVQWQKcBhu+TCp5aKxUdrheeApgvtG/TO8UNJm9kiV3iItsfN9d4zbZdivkKq13PR
 d2MmWCuPQJ0/k2/YlbcgBFtRxEaN8RwgZ5s9rcvEwLKjP8b8NGb26hB2eddp/tHbTYDz
 feV376K4gjIfmqyRi+l2eDxlGoXEBUvIgz1eB0hdRskAwfJ5cCHWHU03jjkSq2DGtS+z
 PKe4MxXZYAxv+mq1XI9ur4FB1e9ndLqUUpjSSKxnQrC2jqv0YVt4IgJHVHUp5gi4F6m0
 PyL3ghkDYRsnPsPVAOhJBMR2WNMhcsBimhUZzCI+rLwZESTZhZe0fDhd0P5ehTfFns6i
 0VMQ==
X-Gm-Message-State: AOJu0YxiV81bmEtkPGJTEh+K0kC9pYv7ik603iyUbgHH5Xn77EPgnGM5
 JjEX/57AOS9z9bec/WBNTXyhKYYSBpkh7hE0VEPIIJ1cwHf2Aqo0q/toFyTuto01fsrBBA8buL/
 8SYtYjM6tnTL7UVCen3G04iE/U2tF8yDj6S5dg85O2Cu82ACkMINIA2Uou/Sdvie9sbK/xEj/jE
 aIKkgXiyAq5GQm/iDjnquoZWkbE7UJHYV+
X-Received: by 2002:a05:6871:891:b0:23c:3afb:eceb with SMTP id
 586e51a60fabf-24172a4d896mr16458570fac.1.1715613254305; 
 Mon, 13 May 2024 08:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERkux0avhA6d7N/ZVVbpU9HmIznBFaVNPzpE35FNl6hbpNMZaX5LLkAypyl3iqgW2sBpd2pQ==
X-Received: by 2002:a05:6871:891:b0:23c:3afb:eceb with SMTP id
 586e51a60fabf-24172a4d896mr16458545fac.1.1715613253851; 
 Mon, 13 May 2024 08:14:13 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([78.208.179.227])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792e36d8d9esm70356085a.110.2024.05.13.08.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 08:14:13 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 13 May 2024 17:14:08 +0200
Message-ID: <20240513151408.237675-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls/mlock05: add mlock test for locking and
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
 testcases/kernel/syscalls/mlock/mlock05.c  | 114 +++++++++++++++++++++
 3 files changed, 116 insertions(+)
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
index 000000000..8e805736d
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -0,0 +1,114 @@
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
+#include "tst_safe_stdio.h"
+
+#define MMAPLEN			(1UL<<20)
+#define LINELEN			256
+
+static void get_proc_smaps_info(unsigned long desired_mapping_address, unsigned long *Rss, unsigned long *Locked)
+{
+	bool mapping_found = false;
+	bool Locked_found = false;
+	bool Rss_found = false;
+	char buffer[LINELEN];
+	FILE *fp;
+	int ret;
+
+	fp = SAFE_FOPEN("/proc/self/smaps", "r");
+
+	while (fgets(buffer, LINELEN, fp) != NULL) {
+		unsigned long mapping_address;
+
+		ret = sscanf(buffer, "%lx[^-]", &mapping_address);
+		if ((ret == 1) && (mapping_address == desired_mapping_address)) {
+			mapping_found = true;
+			break;
+		}
+	}
+
+	if (!mapping_found) {
+		SAFE_FCLOSE(fp);
+		tst_brk(TBROK, "Mapping %lx not found in /proc/self/smaps", desired_mapping_address);
+		return;
+	}
+
+	while (fgets(buffer, LINELEN, fp) != NULL) {
+		unsigned long possible_starting_mapping;
+		unsigned long possible_ending_mapping;
+
+		ret = sscanf(buffer, "%lx-%lx", &possible_starting_mapping, &possible_ending_mapping);
+		if (ret == 2)
+			break;
+
+		if (strncmp(buffer, "Rss", strlen("Rss")) == 0) {
+			ret = sscanf(buffer, "%*[^:]:%lu kB", Rss);
+			if (ret != 1) {
+				SAFE_FCLOSE(fp);
+				tst_brk(TBROK, "failure occurred while reading field Rss");
+				return;
+			}
+
+			Rss_found = true;
+		}
+
+		if (strncmp(buffer, "Locked", strlen("Locked")) == 0) {
+			ret = sscanf(buffer, "%*[^:]:%lu kB", Locked);
+			if (ret != 1) {
+				SAFE_FCLOSE(fp);
+				tst_brk(TBROK, "failure occurred while reading field Locked");
+				return;
+			}
+
+			Locked_found =  true;
+		}
+
+		if (Rss_found && Locked_found) {
+			SAFE_FCLOSE(fp);
+			return;
+		}
+	}
+
+	SAFE_FCLOSE(fp);
+	tst_brk(TBROK, "cannot find both Rss and Locked in mapping %lx", desired_mapping_address);
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
+	get_proc_smaps_info((unsigned long)buf, &Rss, &Locked);
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
