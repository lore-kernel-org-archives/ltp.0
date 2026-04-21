Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C48DF8FA9A
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 16:09:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 998073E53C8
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 18:09:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE643C18AB
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 18:08:58 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1B57600058
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 18:08:54 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82cf636dac8so1891634b3a.3
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776787733; x=1777392533; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgY88SDUC0vrQ7GG1ckPXnu/+eW08RZsUIs5FXvJfZw=;
 b=V+FPirjWx6eNataShXwkKLObt5UGoG+fqqptqkEe7XhFewOt6qCMqkdTXI3aYO9ZIQ
 YYOO6nyT6OgvYI3CXxEI4Fmy6KQK+4N3xHT5jHNbnOkzzm56U+/I4DdALUJx77RcAqhG
 +gBbOxQA2ZeOUu60+Ef6UVqN1K9smJdQYrTGkAqGS2b770sx8T7SORrqZAuKljI8SW5I
 P/I0aIro7j99sSo9V25JUkq/NQDdQ+QArCWJwkeISzMe0PvQUPsdacF9aMJrjberNqRH
 JMJ7XL/QPWZnq+njqgzdbAECamXs07ztYqtERBmmVdHZ5OafSZwQrc3/GveIjaxFQCfI
 GVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787733; x=1777392533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TgY88SDUC0vrQ7GG1ckPXnu/+eW08RZsUIs5FXvJfZw=;
 b=DW7aUvPItYsBaMSQSEvLb9KUvs6/El5WvjWxwkllQBTswnsncak+XbOpzf1g2ZaIBE
 74Jw6KrlOZUOOcFXl7RIy7OvYF74XqfTBGrE0Kga7gGP6m2GQRRYbfFR6eBuTmxZZxzz
 viHRZibC2pQRNc/UdEbvRK5v6sVhebWWcbTFJ9HOmGUPfXm0bUMhEGgzpkwgdtFlMhoR
 oZSxIQRd6BMw+TTOMdCc1s9iaOdg5QF5lS+vGpWZR2LblzsmfxZXoJtc2SGETyRAm2lc
 XfpmoJeZg9GJt0ipxX0ZCyy+I8JTiMIeFdmp9g0EVOYu7Esqpic+xqV7agL5Uae2oook
 I10w==
X-Gm-Message-State: AOJu0YxTxxmsZEMafLtjsiQYMiLrhDKD8Yb5c9/6VuOpiZloyLt1I3bf
 3BrB1hCAM2HxajL44rAd3Q74P2OumooMmk7eDbcmkvHfaIAB2iRz9Vg=
X-Gm-Gg: AeBDieuu4YMY5mHKDIgFGRyehIHXZ4jGmrxqYP+KLxYEM+WJ/mqBtJQ5efKP61oIY7L
 gvElk22ygZksNGZcTqEwfyExrIv0srGlF/4hI4k64nsgCYpg7NDfALw9Y31McVyqSjYyAo3sQ6A
 jKi3qm83Kh/aow/HKAhKuRLpHAck96eOvm3SQzKrPBwLEgi3tQHjR7dDQ1pTnUORAGwPDWqs3CK
 elPPMasxunxoMjO10gdOiDjAkaQRdA4gwFVm5V54yUf+1ZK9M3J5qlDczkVFEUVtUL5lylWDQnm
 syoORjrJypWnXzzD8KkTFSsTtMh7SwVLG816wv5VKEHfYqJBoArnd/GYc/mQfjqvwDt5tNKoxVB
 /YuMKQMe1jV2ba6G52XXxbk6JZgOjU7ijQmhuzcavXesQMt+GgTmPbwQnS6a/ptXfjVlcP0BxAN
 8fm0RwATx4XJlLARD7jK0hbKtGLNZr1P9feZa97xruVGytWFoKEmV2r80=
X-Received: by 2002:a05:6a00:1307:b0:82a:6b97:34ae with SMTP id
 d2e1a72fcca58-82f8c8fb893mr18605989b3a.32.1776787732961; 
 Tue, 21 Apr 2026 09:08:52 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec0092bsm15300618b3a.50.2026.04.21.09.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:08:52 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz,
	wangli.ahau@gmail.com
Date: Wed, 22 Apr 2026 01:08:16 +0900
Message-ID: <20260421160828.4483-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417113453.GA409289@pevik>
References: <20260417113453.GA409289@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] include/lapi: add leaf Makefile
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Convert include/Makefile to use generic_trunk_target.mk and
add minimal leaf Makefile in include/lapi.

Fixes: https://github.com/linux-test-project/ltp/issues/1262

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v2:
- Switch include/Makefile to trunk and remove lapi/syscalls/Makefile
- Link to v1 : https://lore.kernel.org/ltp/20260410175031.16921-1-always.starving0@gmail.com
---
 include/Makefile      |  2 +-
 include/lapi/Makefile | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/Makefile

diff --git a/include/Makefile b/include/Makefile
index 6b31b046e..84cd4ed6e 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean

 vpath %.h $(abs_srcdir)

-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/include/lapi/Makefile b/include/lapi/Makefile
new file mode 100644
index 000000000..f265f856d
--- /dev/null
+++ b/include/lapi/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (c) Linux Test Project, 2026
+# Ngie Cooper, July 2009
+
+top_srcdir              ?= ../../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
