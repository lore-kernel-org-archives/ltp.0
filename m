Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6653F459FC
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 17:51:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1899F3E5FFD
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 19:51:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9813E543D
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 19:51:00 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ACD81600BA2
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 19:50:59 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso11736245ad.1
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775843458; x=1776448258; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TQGYFnZ3WShp/mkWZOeWTK3J4rRK9QPj6S1dZ3pYQfU=;
 b=QhUCceQ/rco0EqxUyykLCP4zT6B/d+UcGocP1SKUootcQpetDgNa/uKP62LWrvXzTy
 ippLdlv1DEger6P+ayadG6RWc8GRDKRzEq3T32AiHBlzlN8bDMx2LKjiih1aM5nMdi57
 FmfNlhwBMyFvI9bpDdH4PTD0SXec72lI9MtA46faEZs9Ig6owjUrC/FoVr/m0SkKANSk
 CPjcdBx9DNcX0AmgxoKeiTt+fSDZfYgQg+BoBLw0ySHvbbvm9cg2xRl8wFq/UHcwvKzq
 NOjbWr5RasAW3IcGYzchqYpCGh8v+0xxHkdIHc3S1z6eUyL7rAo8/KIx1P2NG8+/s0/B
 MPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843458; x=1776448258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQGYFnZ3WShp/mkWZOeWTK3J4rRK9QPj6S1dZ3pYQfU=;
 b=ilARaIwhGPSNkZI4dTSSpmSgDQuwx41U2H0gtinuG/gecmyJblZxAHkUF+2kc2htDK
 4jbQlq/AefJ8eDUw7ltYrB4QoYIVQW7/kuEikWVr/3kzNlCikjiZiWVFEpwFgNVSLSd7
 XFXNaVQXFTuT2cgwfzyz0N0xb2geE8zhyYR4FcVDRqT2Rj2yYLjF6+o+raQlgjgCLPBm
 Oxji7+w5EWKdappVkLdzOdTnUKbSWnxeuQdUb6H0hwwzkw+Egv+dZiXfxp4foiIC8NZT
 lhDc7RG6cOpSeW5JuOMPQOypOb6rK6BH/gOxvdO4dNEa8KqlllYTBWhilUSZSJFB0S4i
 SJVg==
X-Gm-Message-State: AOJu0YyOmTOFOT6nD5QInqmYA3pHXYjyFr1WM2G3fw6caXcEDYUiEScH
 2lN6Fz9G+mnvQBGyRW5wvh4qB14DVfPqsvXKSYialcb56YclaHLFQ5jveqkFU+Z0/Q==
X-Gm-Gg: AeBDietVu+WYH9mJzDKuXaCYXutSSwXQhORBCldQyc56/g8TUTZ6ohiqaSDAm8+OTzT
 IYLEfLf6I8r7mUljjLE7ohWiHX4gx2nOKHfSrZJuJnO5f7u2fdRv4RXgsJmauSuNK7jnW7heeSR
 xYLOiIXRG7VfhT7crkl83l1XKrSYBktjAN7R81lskO5882+fFNcZZaElQaiS57uV3+ofB925USx
 hwLPcgVKckBPvog4c/0H7tmCb0/DXuhW28lEm9iCzu2XToo3lpzKNF7B/SbR7EfB4sVSsbSEbas
 3BhJKVdVBjGwV9zQeh4NL6Js6Qef/muEfsSFPN0x/rYs2Xkwc/RJxuAUNvnx9O7J4e1s8xAhbzx
 viTGdMBLfOXmHqbMca+x2R5sQco0lxoge8Qrj3PSDNX3aeI9aOZcCa8+WrjMKLqmh1dPDXMPcop
 L4rOF/G0n7utKTbUyVz94pTj8GXrCCQjEAQShR1wFjImv4WknNwbiK
X-Received: by 2002:a17:903:32c9:b0:2b2:5723:12c3 with SMTP id
 d9443c01a7336-2b2d5a6477bmr40601095ad.43.1775843457691; 
 Fri, 10 Apr 2026 10:50:57 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4dabf08sm34598885ad.11.2026.04.10.10.50.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:50:56 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sat, 11 Apr 2026 02:50:02 +0900
Message-ID: <20260410175031.16921-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Fixes : https://github.com/linux-test-project/ltp/issues/1262

include/lapi and include/lapi/syscalls lack Makefiles, so 'make check'
does not work in these directories. Add minimal leaf Makefiles.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 include/lapi/Makefile          | 8 ++++++++
 include/lapi/syscalls/Makefile | 8 ++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 include/lapi/Makefile
 create mode 100644 include/lapi/syscalls/Makefile

diff --git a/include/lapi/Makefile b/include/lapi/Makefile
new file mode 100644
index 000000000..83ef85c77
--- /dev/null
+++ b/include/lapi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+
+top_srcdir              ?= ../../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/include/lapi/syscalls/Makefile b/include/lapi/syscalls/Makefile
new file mode 100644
index 000000000..e46c90ef5
--- /dev/null
+++ b/include/lapi/syscalls/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+
+top_srcdir              ?= ../../../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
