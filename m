Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C505C04FFE
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 13:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 786CD3C8603
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 15:34:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD2923C5D1E
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 15:33:48 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B891A207222
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 15:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714397626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aVs7V/ds5Nn6CjCzSLpXGGtmb9DUqn/a3TlSeO6lN2Y=;
 b=QX7VWpzD2gaVhRbt9XDCCLjfacDTExsCK0xdXpkWrOyFx1RYF1wZCdk2FwRezMD2GcOi+J
 Tva0w0nglosRLVyoaBg05E3Eem3mv3g1Q9CeeLuykRwQtO+ygoDFUCISFq0UMpeG5imlmg
 LWyJWtYz1fNkcSGqMg1OxfXo9/km+jM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-pGfoNgIFMK-jVzjIQ19Ghw-1; Mon, 29 Apr 2024 09:33:45 -0400
X-MC-Unique: pGfoNgIFMK-jVzjIQ19Ghw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c84dc9a073so3578698b6e.1
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 06:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714397624; x=1715002424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVs7V/ds5Nn6CjCzSLpXGGtmb9DUqn/a3TlSeO6lN2Y=;
 b=IIc43lruuEma3QdWB9kQLsDIMoeHP6HFxqJgLeI5E2S4BSGDr3d7lpH1GqzUq3nlTJ
 xAdl0fXCe3+p9e0dOU5u/wVLjicC0lf/iIZugyVSz994CzSK2487W8tX9DCPFRWicHmr
 Nu4WXabcGW7942l+N3Dk4oX7H1Z38l17e1XsLevVumBwtbARzfZM5rODbUq5qC+dqkGA
 MwS2v2rQMogsDGE5j2pO27iGQxQTkEkjhZ2oDaQTzSWIWiBM9YVXAGbMuo1tXHLlEXIn
 FOzeywXzTsouSGGnmyW1qBmhb7j7oKVRP5CJHWknK6Y45BdXIvHM+OE7NzO1bo5/Q3jK
 avRg==
X-Gm-Message-State: AOJu0YwcXhwmccPQRb8ncnteuOOK70yfpt9j6XTMOTm3JEi3bskzpu5p
 4wmFhRlafkBK2Z5l339B2GLEdM7Da4uouR/dzIaAG3zOf4x8P7yDYIwfTka5aVHUoy04/rOTATu
 DW1xc7JbiUUUlgkZ2rSKxaI6i8EMjFBjnX6ck/sZSC0Da22xOt6TtAK/xcttimvrIddXHvIiCDs
 sWW16zO7xdW+dja6+Rfri+VcxcqvrW5MEC
X-Received: by 2002:a05:6808:189a:b0:3c7:366b:980a with SMTP id
 bi26-20020a056808189a00b003c7366b980amr14650903oib.5.1714397623965; 
 Mon, 29 Apr 2024 06:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvZ1niCTu/I6PxKkzZviimmnXY+Lrc09Q5aY99HzmXZvksZRc0DAmxz4jRbNI+kKhALcI6A==
X-Received: by 2002:a05:6808:189a:b0:3c7:366b:980a with SMTP id
 bi26-20020a056808189a00b003c7366b980amr14650874oib.5.1714397623447; 
 Mon, 29 Apr 2024 06:33:43 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb
 (host-79-50-126-211.retail.telecomitalia.it. [79.50.126.211])
 by smtp.gmail.com with ESMTPSA id
 mm8-20020a0562145e8800b006a0d22f23c0sm608688qvb.61.2024.04.29.06.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 06:33:43 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 29 Apr 2024 15:33:36 +0200
Message-ID: <20240429133336.3166386-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mlock05: add mlock test for locking and
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
 testcases/kernel/syscalls/mlock/mlock05.c  | 60 ++++++++++++++++++++++
 3 files changed, 62 insertions(+)
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
index 000000000..2475cb333
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -0,0 +1,60 @@
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
+	TST_EXP_EXPR(VmRSS >= MMAPLEN,
+				"(VmRSS=%lu) >= (MMAPLEN=%lu)", VmRSS, MMAPLEN);
+
+	TST_EXP_EQ_LU(VmLck, MMAPLEN);
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
