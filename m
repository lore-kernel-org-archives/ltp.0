Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B17CD6E77
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 16:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 572573E618C
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 18:39:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B0643CE0FA
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 18:39:19 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CC041A008BF
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 18:39:18 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c1630159bso1115310a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780591158; x=1781195958; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MLs0vUVyfm8sfpIQqGSyrS0uTEyaiJ80EJw7Ganz1I=;
 b=G5W9u8ZgObL9hXjzHpqxXNISUwmcp7RT6N+3O0U48z7mNgfGa5f3anJf1/mWhk4+6g
 thyxJYt69sik1r26mjB+g0WZIFHgV30oFEw9YpuHGytdR21imdxLt7iKkYscdN4MgiZl
 vdxio/1Z0iPqCw1JjAG99Iw0Gm9T1wrIczMbc1hvYn7QJk+LdwJ506ldnNtR3n7dJO9f
 0sHLxiRwEA9xbOr49x/hqLNzsIkveXZOVKJ6nOTJQ5rIQDgbOC2s3iqNvaty7HZMfqat
 nzulUH9pwBEn9jJ3tJeNY/Wjco9LVjWFVDdgecAmLGjNo2HwC68i+6N0Eg56ERGdivpc
 zobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591158; x=1781195958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/MLs0vUVyfm8sfpIQqGSyrS0uTEyaiJ80EJw7Ganz1I=;
 b=LUiDASM6eWbz2/4DVM6P3PNlz/c3mjYIXv1FRoc3Lf2vSY1J9s0FK4iJoxxH7DXh/Q
 XzD3s+ioxTwCU9BKUQid5PqJQzB7ag2ow1UTUo46G/L+lBkfHXx2PcFOI1UCTzLX9Upb
 pl3Anxe9t7t14I+wyZPt8SnDimqNuxl1kX143fnh0UV9YbuOLRUP5Gc/isXcfbwIAB39
 xVt+VSSKem88xynod3Spt0dB1IkIobyRVDoCNM5tOPYOHdoabadufPuq5igS4qSGz0LA
 7i42xhpD8i0L4r10hBZnG+wn3Q4TZWum6JUEzPS8sBHiIhFxQCFLzf4KOGCwTgXsnCx1
 Qvhw==
X-Gm-Message-State: AOJu0YwIx+JasKswspL0WLQ/guKROJBotqmvTFzw+mtyd+NmTEYbUs1l
 L+pQs+cMtLJmv3I4ma9RSHOmA84+c5JyTKZm+rtY4HZwizYIxMACgblj/XTRkw==
X-Gm-Gg: Acq92OHc8Ct5JrXtj53D58jiepbYlruwVjZq8/shSA3LhvZDfv1QxqnG2CQRcstcv8M
 v/PKVw1+g+2EuhO1zbBsCXFHfzvS57IknMH45xRFM6jZTAkxPwpWdP4+tAA1IZ0yoqdeqlVX9dR
 VtuK4z36mCs59zNyUohBKQOnLZlqmAj202tFHE9ezxrDaMDgSmaNdJhA9GaP6maL0j1/KE4P9TN
 iGR0KMPrVdpUU3v+xN5auqhdHxoAYbSNHmyUu04ngnGBwLAyQzYdkmu4FP0cTpbPpH9lovDKm2C
 Jng3Yc3UK2ar9CpPaiXVUUq1jurHMCzey7xNOk3Lc1GrptP6zAqD5gwkUwB+j7pF0rWypAlF26o
 crpmx9LCvchL6J2CBLEyzzFPBmjeUMmMwX2qUq7YI7eGrNvhuTGnIhYzmqQPNmNg99k1RfkwOUP
 z0hyTIGn2kuPnqzPPsjV2f6EyztLQ56Wx67fF3BORiGyZ3Mn3kfiD+inqvdUC0ADuN97og
X-Received: by 2002:a17:907:7248:b0:bed:8f7e:d85b with SMTP id
 a640c23a62f3a-bf0af50a2b0mr462598866b.42.1780591157587; 
 Thu, 04 Jun 2026 09:39:17 -0700 (PDT)
Received: from localhost ([37.109.163.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517721e5sm335087966b.9.2026.06.04.09.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:39:17 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 18:38:29 +0200
Message-ID: <20260604163909.17853-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <89e9004c-4415-4f05-8288-4f73a491d8dd@suse.cz>
References: <89e9004c-4415-4f05-8288-4f73a491d8dd@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] lapi: Add io_uring_clone_buffers and
 RDS_CMSG_ZCOPY_COOKIE fallbacks
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add IORING_REGISTER_CLONE_BUFFERS opcode and struct io_uring_clone_buffers
to lapi/io_uring.h for kernels/headers that predate the clone-buffers API.
Add lapi/rds.h with a fallback for RDS_CMSG_ZCOPY_COOKIE, which is absent
in older userspace headers (e.g. openSUSE Leap 42.2).

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 configure.ac            |  1 +
 include/lapi/io_uring.h | 17 +++++++++++++++++
 include/lapi/rds.h      | 16 ++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 include/lapi/rds.h

diff --git a/configure.ac b/configure.ac
index 0653d7793..3a1283ac3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,6 +255,7 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
                 struct __kernel_old_itimerval],,,[#include <sys/socket.h>])
 
 AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
+AC_CHECK_TYPES([struct io_uring_clone_buffers],,,[#include <linux/io_uring.h>])
 AC_CHECK_TYPES([struct mount_attr],,,[
 #ifdef HAVE_MOUNT_SETATTR
 # include <sys/mount.h>
diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 2026863a2..afc32c247 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -265,6 +265,23 @@ struct io_uring_probe {
 
 #endif /* IOSQE_FIXED_FILE */
 
+/* linux/io_uring.h: IORING_REGISTER_CLONE_BUFFERS = 30 */
+#ifndef IORING_REGISTER_CLONE_BUFFERS
+# define IORING_REGISTER_CLONE_BUFFERS	30
+#endif
+
+/* Argument for IORING_REGISTER_CLONE_BUFFERS (linux/io_uring.h) */
+#ifndef HAVE_STRUCT_IO_URING_CLONE_BUFFERS
+struct io_uring_clone_buffers {
+	uint32_t src_fd;
+	uint32_t flags;
+	uint32_t src_off;
+	uint32_t dst_off;
+	uint32_t nr;
+	uint32_t pad[3];
+};
+#endif
+
 #ifndef IOSQE_IO_HADRLINK
 /* like LINK, but stronger */
 #define IOSQE_IO_HARDLINK_BIT	3
diff --git a/include/lapi/rds.h b/include/lapi/rds.h
new file mode 100644
index 000000000..7405a7f37
--- /dev/null
+++ b/include/lapi/rds.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Sebastian Chlad <sebastian.chlad@suse.com>
+ */
+
+#ifndef LAPI_RDS_H__
+#define LAPI_RDS_H__
+
+#include <linux/rds.h>
+
+/* Fallback for older userspace headers (e.g. openSUSE Leap 42.2). */
+#ifndef RDS_CMSG_ZCOPY_COOKIE
+# define RDS_CMSG_ZCOPY_COOKIE	12
+#endif
+
+#endif /* LAPI_RDS_H__ */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
