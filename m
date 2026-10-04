Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB581CA5FF0
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 21:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB04E3E4E5B
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 23:16:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1063E4EC5
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:51 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ADBD9600217
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:49 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so10239065e9.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791148549; x=1791753349; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=il18zckknTsRrp/LZvUjs5fHriWkcIritnGGw7icPBk=;
 b=RHujHQrY+tGjqkJJGCLoQ/HRQzoBq5q7UPDIYypYwReDgMWSVhCZGsDXVuwhaMPp+m
 jMVrpQWfUXp/N9BQfbn/fDDQXITwkHIhEQINkRHhO5MDX9he5kR2sR9vRkdxNCCIFtEe
 Skh8UjL8Xea4fYbuUMLrsX/BshgT8Oak2Qp7kAIqfM+Pz3Q5LLuCDw1R22Lw63z86rfF
 8qeos/sENUfxEF/HiPt9S52b80PaSQNsXvHSW63tmxg2G6qHNTuqBSb0OVrv/YZM4JoX
 D3js6JFXg0R3OqKosfgyQi5aCPjgvBI33Kv3CtnfvdMRaAFHVCfikhluY50ZQ4W4bbof
 e1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791148549; x=1791753349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=il18zckknTsRrp/LZvUjs5fHriWkcIritnGGw7icPBk=;
 b=ay9PE9E6lQFRhK5a7NKK7Nmkssj+cxgqlBjFtZXbkdicTBTmiTDJrCgA9DsBUyP29X
 SjNHqoyWpyvSKObklF9FugKhZgYB4WB0Cpov7W+fsOAXqj86YWF+WyfSE1uPWrWO0coZ
 pmyzfk10pneHo6MCxjfmV/FiGYqTPvxRIcdZcWNTj3gtMYEglNCjjjh8HvS6LOUdAXQV
 HcuvwcOvWdmelPB8NpaOWQ06hJwGBLMF+z6LpjlF3ywSpVPLKkFc9QCIH+fFGxV9Io1U
 lC6R68iTycjkzGkRhNryTtmB02DWaKPExUv4ML/CcVfxTHcOse5H04cN5S0cAdZeeoaX
 Fanw==
X-Gm-Message-State: AFuF++mXV74aQms9W5ooeQETIT5zrVEePN/hoiMtMhArJbuS1fVqn9EW
 eWzR94h+wcO1Qr1nZsepRITHGiIuj50y1x9w4wXI6FpVdZzRofAbUMjwn2saLu1iz2k=
X-Gm-Gg: AYBFou0w9/Vcozrhbuj796CySZgS47jyNBooXdrHpFAbON/EfycWdaQG2OVwdbNHCSt
 P89CYQNUdPSbeOf0joUvEi+59OhfKTfLpCSURiBr0H60ySWQ6Sv7JLiqbfgupfOHQ/TGNq/xHKQ
 LeMZwI6R8tS1BUqYvfMM3S27W6y2iZCck/qq3qiSHfY0+HqVBM1yMkjccvsDxXB7x+3DmbmRvcy
 X5dbJMJkg8hVzrkFTaTnl2/2t2wEm7RGQkWqieWl45DTvTph8cf2Sx6ySGFjvhUEHX1bHC+ejS1
 hdUGl6FVq9nDTbNMimh+R9CF2trScLOx8250GbbFzS8o/OqB0CkPMc30a/69uVWjD7vEUttYXo/
 JWILproEsSL65IHz22iZW01BMBkFrQ5bIRuNvyf79RcJMe5xDV5PSqmku5EwVw8OEIzYduXYUUD
 IIFc6nNvUI1wTxW/Tw94YK7LE6l+3uZG4sfQY/9bondHDC7MVVtxKnykrkIMLljvs0vouFRw75B
 dDgAcs+EWh1FJS0BML101q3WWXXamPFdbG8gewkgM7+yA0GhihQggtRhXvSO1z4SDzz5NtFZePB
 AbUuMtZCyIPqR/xZKRZVO+8=
X-Received: by 2002:a05:600c:b8d:b0:49e:8377:c880 with SMTP id
 5b1f17b1804b1-4a0276b40a9mr140689495e9.33.1791148548656; 
 Sun, 04 Oct 2026 14:15:48 -0700 (PDT)
Received: from pradeep-susarla-LTP.tail3351fa.ts.net
 (cmbg-20-b2-v4wan-174372-cust280.vm17.cable.virginm.net. [80.3.67.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03950375dsm115151725e9.1.2026.10.04.14.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 14:15:47 -0700 (PDT)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 22:15:33 +0100
Message-ID: <20261004211535.7307-2-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004211535.7307-1-pradeep.susarla@gmail.com>
References: <20261004211535.7307-1-pradeep.susarla@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] hugetlb: Migrate test library to libs/
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
Cc: Li Wang <liwang@redhat.com>, pradeep.susarla@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Move the hugetlb test helper library out of the per-suite lib/ directory
into the global libs/ location and adopt the tse_ (extended, non-core
library) naming used for the other libraries under libs/:

  testcases/kernel/mem/hugetlb/lib/hugetlb.h -> include/tse_hugetlb.h
  testcases/kernel/mem/hugetlb/lib/hugetlb.c -> libs/hugetlb/tse_hugetlb.c

The hand-rolled per-suite library build (lib/Makefile and Makefile.inc)
is dropped in favour of the standard LTPLIBS mechanism: each hugetlb test
directory now sets "LTPLIBS = hugetlb" and links -lltphugetlb, and the
library is built as libs/hugetlb/libltphugetlb.a.

No functional changes intended.

Part of #1276.

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>
---
 .../lib/hugetlb.h => include/tse_hugetlb.h    | 11 +++---
 libs/hugetlb/Makefile                         | 11 ++++++
 .../hugetlb.c => libs/hugetlb/tse_hugetlb.c   |  2 +-
 testcases/kernel/mem/hugetlb/Makefile         | 21 ++---------
 testcases/kernel/mem/hugetlb/Makefile.inc     | 35 -------------------
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  4 ++-
 .../hugetlb/hugefallocate/hugefallocate01.c   |  2 +-
 .../hugetlb/hugefallocate/hugefallocate02.c   |  2 +-
 .../kernel/mem/hugetlb/hugefork/Makefile      |  4 ++-
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  2 +-
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/Makefile      |  4 ++-
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap36.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap37.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap38.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap41.c  |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/Makefile     |  4 ++-
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/Makefile    |  4 ++-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmdt/Makefile     |  4 ++-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/Makefile    |  4 ++-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     |  2 +-
 testcases/kernel/mem/hugetlb/lib/Makefile     | 10 ------
 68 files changed, 95 insertions(+), 133 deletions(-)
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.h => include/tse_hugetlb.h (87%)
 create mode 100644 libs/hugetlb/Makefile
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.c => libs/hugetlb/tse_hugetlb.c (99%)
 delete mode 100644 testcases/kernel/mem/hugetlb/Makefile.inc
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/Makefile

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/include/tse_hugetlb.h
similarity index 87%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.h
rename to include/tse_hugetlb.h
index 6b5d3a0..09e4213 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/include/tse_hugetlb.h
@@ -1,16 +1,15 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- *
  * Copyright (c) Linux Test Project, 2004-2025
  * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
- * hugetlb.h - common definitions for the hugepage tests
+ * Common definitions for the hugepage tests
  */
 
-#ifndef __HUGETLB_H
-#define __HUGETLB_H
+#ifndef TSE_HUGETLB_H
+#define TSE_HUGETLB_H
 
 #include <stdlib.h>
 #include <sys/ipc.h>
@@ -59,4 +58,4 @@ int do_readback(void *p, size_t size, char *desc);
 
 void update_shm_size(size_t *shm_size);
 
-#endif /* hugetlb.h */
+#endif /* TSE_HUGETLB_H */
diff --git a/libs/hugetlb/Makefile b/libs/hugetlb/Makefile
new file mode 100644
index 0000000..9a0d008
--- /dev/null
+++ b/libs/hugetlb/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines Corp., 2001
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= libltphugetlb.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/libs/hugetlb/tse_hugetlb.c
similarity index 99%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.c
rename to libs/hugetlb/tse_hugetlb.c
index ac97a06..c8722f5 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/libs/hugetlb/tse_hugetlb.c
@@ -10,7 +10,7 @@
 #include <sys/shm.h>
 #include <sys/time.h>
 #include <pwd.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 key_t shmkey;
 
diff --git a/testcases/kernel/mem/hugetlb/Makefile b/testcases/kernel/mem/hugetlb/Makefile
index 82ae533..d38ed7a 100644
--- a/testcases/kernel/mem/hugetlb/Makefile
+++ b/testcases/kernel/mem/hugetlb/Makefile
@@ -1,25 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) International Business Machines Corp., 2001
 
 top_srcdir		?= ../../../..
 
-include	$(top_srcdir)/include/mk/env_pre.mk
-
-LIBDIR			:= lib
-LIB			:= $(LIBDIR)/libhugetlb.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+include $(top_srcdir)/include/mk/env_pre.mk
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
deleted file mode 100644
index b272e62..0000000
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-#    kernel/mem/hugetlb testcase suite common definitions Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-# DO NOT USE THIS FILE FOR hugetlb / lib!!!
-LIBIPCDIR		:= ../lib
-LIBIPC			:= $(LIBIPCDIR)/libhugetlb.a
-
-$(LIBIPCDIR):
-	mkdir -p "$@"
-$(LIBIPC): $(LIBIPCDIR)
-	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
-LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
-LDLIBS			+= -lhugetlb
-MAKE_DEPS		+= $(LIBIPC)
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
index 77ebb0a..720063c 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
@@ -4,7 +4,9 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index 53fef3d..5801fbe 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index 1f7c4dc..abc9068 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -16,7 +16,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MAX_PAGES_TO_USE 5
diff --git a/testcases/kernel/mem/hugetlb/hugefork/Makefile b/testcases/kernel/mem/hugetlb/hugefork/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugefork/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 9998f90..478c47a 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -19,7 +19,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define C1		0x1234ABCD
 #define C2		~0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
index cafeaa2..1d66e67 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -11,7 +11,7 @@
  */
 
 #include "tst_safe_sysv_ipc.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static int shmid = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6e72e70..6e72c13 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -4,8 +4,10 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index de51333..557892e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -26,7 +26,7 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static long *addr;
 static int  fildes;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 611ae70..919e5ad 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -29,7 +29,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define LOW_ADDR       0x80000000
 #define LOW_ADDR2      0x90000000
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f52747e..6a79a5d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -28,7 +28,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static char TEMPFILE[MAXPATHLEN];
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 526eacb..e5fce66 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -17,7 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 64325d6..fc2cee8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -26,7 +26,7 @@
 #define _GNU_SOURCE
 #include <pthread.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/mmap.h"
 
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 5a965e1..d11ee5f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_stdio.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index 07fd70b..e208116 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -26,7 +26,7 @@
 #include <sys/wait.h>
 #include <signal.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define WITH_OVERCOMMIT 0
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 10f6467..684d62b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 5b5577a..ebb9328 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 087e8c6..d88bf9f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -17,7 +17,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define P0 "ffffffff"
 #define IOSZ 4096
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 36acd5b..07142f6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 3f496ea..d7c81c2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -21,7 +21,7 @@
 #include <sys/types.h>
 #include <lapi/mmap.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index 663616a..b0ca782 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -21,7 +21,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 7796ac7..9b33be9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -22,7 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
 	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index ec9d6c3..cda422c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
index 33d2fa4..c2cbcfe 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -27,7 +27,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define MAP_LENGTH	(4UL * hpage_size)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index 1e179f2..b87afc4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -26,7 +26,7 @@
 #include <stdlib.h>
 #include <sys/mman.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
index 2cec85b..548c48a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -25,7 +25,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT	0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index 313efb4..9f898f0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -9,7 +9,7 @@
  * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define FLAGS_DESC(x) .flags = x, .flags_str = #x
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index 3792cff..bb8ad4e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -11,7 +11,7 @@
  * were not corrupted by the other threads.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define THREADS 5
 #define NR_HUGEPAGES 6
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index 78e4a3b..93899df 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -12,7 +12,7 @@
  * iterations.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define NR_HUGEPAGES 2
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index 86157d2..2960ac4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define RANDOM_CONSTANT 0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 9e23c25..4eb35a9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 7d9fd0b..d010e8b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index cd60d74..3982451 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index f79258d..b4695f2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 48cedd1..369799c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -10,7 +10,7 @@
  * mapping. Otherwise, reserve count will be overflowed.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index f049745..39b0329 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -12,7 +12,7 @@
  * shared mmap data.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define C1 0x1234ABCD
 #define C2 0xFEDC9876
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index f00780c..b8c20d5 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 57367b6..652f108 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -10,7 +10,7 @@
  * seen to other mapping or not?
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 36ad603..a234894 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -19,7 +19,7 @@
 
 #include <stdio.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define GIGANTIC_MIN_ORDER 10
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index ae70c2b..e966c0e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -20,7 +20,7 @@
 
 #define _GNU_SOURCE
 #include "lapi/mmap.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_stdio.h"
 #include <errno.h>
 #include <inttypes.h>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
index 1a44745..9f28e9e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
@@ -16,7 +16,7 @@
 #define _GNU_SOURCE
 
 #include "tst_test.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/mman.h"
 #include "lapi/mmap.h"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
index bba95ed..616cba2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
@@ -27,7 +27,7 @@
 
 #include <signal.h>
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static int page_size;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
index e125669..dcbf505 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
@@ -24,7 +24,7 @@
 #include <sys/mman.h>
 #include <errno.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
index edc7458..3b398d5 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap38.c
@@ -21,7 +21,7 @@
 
 #include <signal.h>
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
index d59811d..be488fb 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap41.c
@@ -27,7 +27,7 @@
 #include <sys/wait.h>
 
 #include "tst_test.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define CONST	0xdeadbeefL
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 3a50e6b..9dde63c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -27,7 +27,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define CASE0 10 /* values to write into the shared */
 #define CASE1 20 /* memory location.                */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index e79d682..1245d5c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -26,7 +26,7 @@
 #include <pwd.h>
 #include <limits.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #ifdef TST_ABI64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 9de9257..3f71b05 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -31,7 +31,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 74d34d8..57a8882 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -19,7 +19,7 @@
  * 	test must be run at root
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 41d4a95..7f40054 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -26,7 +26,7 @@
  *
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static long page_size;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index bd4437b..c932409 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -10,7 +10,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define N_ATTACH	4U
 #define NEWMODE		0066
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 82126f5..076ff8b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -26,7 +26,7 @@
 
 #include <pwd.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/syscalls.h"
 
 static size_t shm_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index ec46406..c28fdeb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -36,7 +36,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 0b9515f..d9e7a7a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -30,7 +30,7 @@
 
 #include <setjmp.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
index 261c5de..e34360f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 6273565..d10c972 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -13,7 +13,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index bbd968c..4efe956 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -12,7 +12,7 @@
  *	04/2004 - Updated by Robbie Williamson
  */
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 0e9c7d5..bb93923 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -12,7 +12,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 3363196..c6e6a63 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -14,7 +14,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
index ca93ae6..690add2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -12,7 +12,7 @@
  * works correctly by validating the data written to segment.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 
 #define NR_HUGEPAGES 4
diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
deleted file mode 100644
index 45606b1..0000000
--- a/testcases/kernel/mem/hugetlb/lib/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INTERNAL_LIB		:= libhugetlb.a
-
-include $(top_srcdir)/include/mk/lib.mk
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
