Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F82CD98C5
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:35:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B583E6EB6
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 21:35:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97A4C3C72B5
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:35:15 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 077031400246
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:35:15 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso3981144f8f.3
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781120114; x=1781724914; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEIS8WE0wHMUl69RylkztmiI5HcdBasIGwdSU30ZrOc=;
 b=bNzGoUQuSVyqDEm0vfvaalkdDpwL4OMF0lq55QTzTy6WaJhQkIND9vf41Ydho2p3/x
 ckSaKQI/T49eYUf0tShvBkyi/X9gkLyn1ppV3MO0n74881Zc5pfEryY79PcDHE0qQrNl
 7bJgC1+5DD1pkU6jm9v08ugkyRGUnxSJPu9c6rCEvS1KhrOOc++x8EupmQ9HnwdYFNhe
 npnYYCH6w9xwt2kh2Mr7Meu+ojCEr/ZqSFtAY4SLNTG/As0VfCza/xjD3EiJ34cW8Zjn
 mVsmbjCFaK4QN1NgUyqIuxAV7adu1VgK3UYA0Ka2Xjl1fRIXw1G6gMrmIvW/4KnUcXeI
 B5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781120114; x=1781724914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEIS8WE0wHMUl69RylkztmiI5HcdBasIGwdSU30ZrOc=;
 b=N0uqBoX5388lK5EbpF7wMRPPhxbCcf5N29odcWPP5WwEuSy01MBMcS7R1axT2xO0jX
 fxOEG3PirqQMb6CchYa1Jo1A93apXead4LYRFbYsqD+b9t0ydCC9PSnt099lJVonc8mV
 ZOFVxSCxi8uf4Cgn3/QqOa9QducvTxYeozMTXLgqe3WY3ALxzSLb5IbIL+0B48BBPbof
 qUlMc5+K9boodaP1qpeTHwP7/okC+PTfPY6umE+Mmhh/LYEB0m+6o/gItaoPVwTVJ4Bq
 ujwb6X0TXWB/uvT5n8NbmyNgaLfFpFrWsYT1AhH5kv6Y0REen0TfMC/TzXGQY6ySFoea
 lUGA==
X-Gm-Message-State: AOJu0YwrLBaT4RS9NLZpLGZM/oNN7LBfzOUMFmOFTNl7K9sn5Og+dbts
 Un0lOIsvDQag6IFegfLsHbCVFVUA/47CRZKTw3Otug7cL0I0bd/VJeE+EP/tJA==
X-Gm-Gg: Acq92OETmKHO+J/A7h+BEo+1XwXmUkpBYkz1wxX7lydShKCkRJeRYWXaSkOjo46qtce
 Np21oHNdRVZvOoz7m2c/YBOuB8x23aDCkylXJ+IlvtDq+QfkQx+n9qh/4PUBca6Xk/ew+YWIe/n
 ezqmcbu+fEHxyz4MjK5EVg9zDslaDwgQ5yXO8YoO2sik23W4COz9g1fa9V8ymXtPIcIFYzfwh3+
 8lzse70xhFQyvsMqO6Vk1zstVgUYK+NMBjmuC7tCdA/LGNjRyrjf9vZXOmafVKBAlDP3q2CXBAi
 /e9sFJwHUGNNJfYQOaIYd+CgbU7geSjMFab4+jyPNzoGY55C/jZW9+vbgtZ+HtFKFBG/yGx1Nqw
 OKii/aJjGjJoz75MkbllY+yGIPNoZ9RUGWpH5JveVvXAn2VNZfE4LyLRsYS7HD3EoYyIdprQBej
 HQAdblU2VMHV+xOyHLYDiRbkrNti8zpuJXztoQa2a1PeeLov5VnFFDGroEd6PnEWs4gXqX/Cjxx
 LPN30DuQQoZUkCnbpMczpd7wccooNEq0lxd7lbeXeAZzTY=
X-Received: by 2002:a05:6000:387:b0:460:50a1:b23a with SMTP id
 ffacd0b85a97d-46050a1b3d5mr17018284f8f.27.1781120114252; 
 Wed, 10 Jun 2026 12:35:14 -0700 (PDT)
Received: from localhost.suse.org (apn-78-30-82-184.dynamic.gprs.plus.pl.
 [78.30.82.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm129218330f8f.27.2026.06.10.12.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:35:13 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Wed, 10 Jun 2026 21:34:59 +0200
Message-ID: <20260610193500.30783-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ail6PkmN2aoEazI_@yuki.lan>
References: <ail6PkmN2aoEazI_@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] lapi: Add io_uring_clone_buffers and
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
Changes in v6:
- Remove superfluous comment from lapi/rds.h

 configure.ac            |  1 +
 include/lapi/io_uring.h | 17 +++++++++++++++++
 include/lapi/rds.h      | 15 +++++++++++++++
 3 files changed, 33 insertions(+)
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
index 000000000..4aa0e632f
--- /dev/null
+++ b/include/lapi/rds.h
@@ -0,0 +1,15 @@
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
+#ifndef RDS_CMSG_ZCOPY_COOKIE
+# define RDS_CMSG_ZCOPY_COOKIE	12
+#endif
+
+#endif /* LAPI_RDS_H__ */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
