Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A3BC54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA5773D0BE4
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 14:25:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23FA63CEB7D
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 13:32:42 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FB71201104
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 13:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709641960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=5Ufh0OzF8nyjnZ7TtBLTd0V3sBDva/ijNBhGWLy1e8g=;
 b=FvKm2FSLKmjC7f9qzsSqV/1UBCAWerS+rEzLk6MOy2/A+XKYe7+WT0u7FK2VzVywbeRCVK
 /5PKkWTHmyf0CkVyFBQDX+QmPvZyOCCxET/x5uBq1sIxbjI1Quv+a9Rb2ibEqsTRn2gGnn
 2URea3UuaKB0uO78cpOAhAFoWC7OxrU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-q9vjtBd_PFK1k6Y6dk2GVg-1; Tue, 05 Mar 2024 07:32:38 -0500
X-MC-Unique: q9vjtBd_PFK1k6Y6dk2GVg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a14d9c64e2so487831eaf.2
 for <ltp@lists.linux.it>; Tue, 05 Mar 2024 04:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641957; x=1710246757;
 h=content-transfer-encoding:to:autocrypt:subject:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ufh0OzF8nyjnZ7TtBLTd0V3sBDva/ijNBhGWLy1e8g=;
 b=YWModIFwcQm7tXKHH557aP0Q60/Vg8wqBk4nSKdAZLV/7sBPHisCpjScVQf1wE7GK5
 s00PWvlK4y1NSGfMT3jsEe3IxCx1MUcwPUtYf19G5ZSOpgOjLybrZ7K0SUMBVkBnqX5T
 srkjzi0TcXE0ADWuDMITs7pZWAr5jOx5RkIHhtzqVzRt/L6vn8FlHOnP/0K6enB+w1Lr
 tSqhCGmvfA1+NxhWJlAHCkkMNHBlbovMW2ZZohJ3atH8+EVBxLv7L9nPfMrq2Mtnh1kc
 L3tIBv/pJM1YkQU6o1l3AyL9tRwkdNYMzXrj1+DiBDNIqpGlLSjqCdB/5UmkOqub59rR
 q32Q==
X-Gm-Message-State: AOJu0YxVdqO+gd9B2qTSiLSmt+Y154zFlCa1xRseNFbl74EB5Blgt+Ii
 xumGZMBJ2CIIg+IehVJLZlzWHXQNzeVqs7+PGQhe8JeIOgv/7QMv7zVldC7o5dskvenGyYuxcp0
 BCgXN2eZeOPj7n3A6ps+v7pfwEsNhTHggX4Itz87KdK0aIzPqV3KOYM3ldnZMXuO2iy4m+jLqfh
 P0UHqXIfq8K7AObdbRH64Y4UQdbu34w9Pd
X-Received: by 2002:a05:6358:590c:b0:17b:f672:4abe with SMTP id
 g12-20020a056358590c00b0017bf6724abemr1704158rwf.16.1709641957491; 
 Tue, 05 Mar 2024 04:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqV0CNZvTTDdcEopCF8IdeLY/kSG4UucvuSa3zKCnQaZyN28w8y+BY9qZ9wLzWfsfjdLOLZQ==
X-Received: by 2002:a05:6358:590c:b0:17b:f672:4abe with SMTP id
 g12-20020a056358590c00b0017bf6724abemr1704136rwf.16.1709641956925; 
 Tue, 05 Mar 2024 04:32:36 -0800 (PST)
Received: from [192.168.176.20] (039-215-156-095.ip-addr.knet-kl.de.
 [95.156.215.39]) by smtp.gmail.com with ESMTPSA id
 pj4-20020a0562144b0400b006904a076f01sm5916741qvb.114.2024.03.05.04.32.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 04:32:36 -0800 (PST)
Message-ID: <c63c49c3-30e8-494d-9ceb-64fc55060e1f@redhat.com>
Date: Tue, 5 Mar 2024 13:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dennis Brendel <dbrendel@redhat.com>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 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
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 05 Mar 2024 14:24:56 +0100
Subject: [LTP] [PATCH v1] munlockall: add test case that verifies memory has
 been unlocked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Adding a munlockall() test case that checks if it has the desired effect,
i.e. after calling munlockall() no more memory is locked.

---
 .../kernel/syscalls/munlockall/munlockall02.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 testcases/kernel/syscalls/munlockall/munlockall02.c

diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
new file mode 100644
index 000000000..53d64d47e
--- /dev/null
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* 
+ * Copyright Red Hat
+ * Author: Dennis Brendel <dbrendel@redhat.com>
+ */
+
+/*
+ * [Description]
+ *
+ * Verify that munlockall(2) unlocks all previously locked memory
+ */
+
+#include <sys/mman.h>
+
+#include "tst_test.h"
+
+static void verify_munlockall(void)
+{
+    unsigned long int size = 0;
+
+    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+    if (size != 0UL) {
+        tst_res(TFAIL, "Locked memory after init should be 0 "
+                       "but is %ld", size);
+    }
+
+    if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
+        tst_res(TFAIL, "Could not lock memory using mlockall()");
+    }
+
+    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+    if (size == 0UL) {
+        tst_res(TFAIL, "Locked memory after mlockall() should be greater "
+                       "than 0, but is %ld", size);
+    }
+
+    if (munlockall() != 0) {
+        tst_res(TFAIL, "Could not unlock memory using munlockall()");
+    }
+
+    SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
+
+    if (size != 0UL) {
+        tst_res(TFAIL, "Locked memory after munlockall() should be 0 "
+                       "but is %ld", size);
+    } else {
+        tst_res(TPASS, "Test passed");
+    }
+}
+
+static struct tst_test test = {
+    .test_all = verify_munlockall,
+};
-- 
2.44.0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
