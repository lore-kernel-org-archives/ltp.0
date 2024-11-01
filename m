Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DA8E6B27C
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B44663CD78B
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:13:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9CA13CD6D7
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF52D641103
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 899E421CB2
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaS6rHt8S6oZ3Q0hfzNPyvKl2ELX6TgmmlCOav8eHkE=;
 b=WD7IjPnML1PjXpit0Ute82eQzAmDih/08j/W23wqWUt1ddTN0SQaLrvjGvrmW1vCzkVzwD
 rJH1f62LHtvllR+JTT9ZemEjT60k9bdhLoBPBNaIiwg6xaDLgJOvULg9Z3bevkPFNX5GnF
 f+c+EH5iWj77UYt6ZOxfXMVEQ16PmIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaS6rHt8S6oZ3Q0hfzNPyvKl2ELX6TgmmlCOav8eHkE=;
 b=mBHFZNsvoJ+birSI9SgjfCkHyn7c1GEEMQPiAULoHjqdwW5YoXIlF42SQtDuxE/Pd7SdVm
 QTEop/58JRdl3wAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaS6rHt8S6oZ3Q0hfzNPyvKl2ELX6TgmmlCOav8eHkE=;
 b=WD7IjPnML1PjXpit0Ute82eQzAmDih/08j/W23wqWUt1ddTN0SQaLrvjGvrmW1vCzkVzwD
 rJH1f62LHtvllR+JTT9ZemEjT60k9bdhLoBPBNaIiwg6xaDLgJOvULg9Z3bevkPFNX5GnF
 f+c+EH5iWj77UYt6ZOxfXMVEQ16PmIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaS6rHt8S6oZ3Q0hfzNPyvKl2ELX6TgmmlCOav8eHkE=;
 b=mBHFZNsvoJ+birSI9SgjfCkHyn7c1GEEMQPiAULoHjqdwW5YoXIlF42SQtDuxE/Pd7SdVm
 QTEop/58JRdl3wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7716C13ACC
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sADYHJHhJGf1BAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 14:11:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:11:06 +0100
Message-ID: <20241101141111.104803-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241101141111.104803-1-mdoucha@suse.cz>
References: <20241101141111.104803-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] Move preadv()/pwritev() backup definitions to LAPI
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

Merge existing LAPI definitions of preadv2()/pwritev2() to lapi/uio.h
and add preadv()/pwritev() definitions from test code. Also fix minor
bugs in return value type and offset handling.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/pwritev2.h                       | 26 -----------------
 include/lapi/{preadv2.h => uio.h}             | 29 ++++++++++++++++++-
 testcases/kernel/syscalls/preadv/preadv.h     | 22 --------------
 testcases/kernel/syscalls/preadv/preadv01.c   |  2 +-
 testcases/kernel/syscalls/preadv/preadv02.c   |  2 +-
 testcases/kernel/syscalls/preadv/preadv03.c   |  2 +-
 testcases/kernel/syscalls/preadv2/preadv201.c |  2 +-
 testcases/kernel/syscalls/preadv2/preadv202.c |  2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
 testcases/kernel/syscalls/pwritev/pwritev.h   | 22 --------------
 testcases/kernel/syscalls/pwritev/pwritev01.c |  2 +-
 testcases/kernel/syscalls/pwritev/pwritev02.c |  2 +-
 testcases/kernel/syscalls/pwritev/pwritev03.c |  2 +-
 .../kernel/syscalls/pwritev2/pwritev201.c     |  2 +-
 .../kernel/syscalls/pwritev2/pwritev202.c     |  2 +-
 15 files changed, 39 insertions(+), 82 deletions(-)
 delete mode 100644 include/lapi/pwritev2.h
 rename include/lapi/{preadv2.h => uio.h} (51%)
 delete mode 100644 testcases/kernel/syscalls/preadv/preadv.h
 delete mode 100644 testcases/kernel/syscalls/pwritev/pwritev.h

diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
deleted file mode 100644
index 48b53f463..000000000
--- a/include/lapi/pwritev2.h
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
- */
-
-#ifndef LAPI_PWRITEV2_H__
-#define LAPI_PWRITEV2_H__
-
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_PWRITEV2)
-
-/* LO_HI_LONG taken from glibc */
-# define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
-
-static inline ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt,
-                               off_t offset, int flags)
-{
-	return tst_syscall(__NR_pwritev2, fd, iov, iovcnt,
-			   LO_HI_LONG(offset), flags);
-}
-#endif
-
-#endif /* LAPI_PWRITEV2_H__ */
diff --git a/include/lapi/preadv2.h b/include/lapi/uio.h
similarity index 51%
rename from include/lapi/preadv2.h
rename to include/lapi/uio.h
index db89547e2..a78103d99 100644
--- a/include/lapi/preadv2.h
+++ b/include/lapi/uio.h
@@ -14,11 +14,27 @@
 # define RWF_NOWAIT 0x00000008
 #endif
 
-#if !defined(HAVE_PREADV2)
 
 /* LO_HI_LONG taken from glibc */
 # define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
 
+#if !defined(HAVE_PREADV)
+static inline ssize_t preadv(int fd, const struct iovec *iov, int iovcnt,
+	off_t offset)
+{
+	return tst_syscall(__NR_preadv, fd, iov, iovcnt, LO_HI_LONG(offset));
+}
+#endif
+
+#if !defined(HAVE_PWRITEV)
+static inline ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt,
+	off_t offset)
+{
+	return tst_syscall(__NR_pwritev, fd, iov, iovcnt, LO_HI_LONG(offset));
+}
+#endif
+
+#if !defined(HAVE_PREADV2)
 static inline ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt,
                               off_t offset, int flags)
 {
@@ -27,4 +43,15 @@ static inline ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt,
 }
 #endif
 
+#if !defined(HAVE_PWRITEV2)
+static inline ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt,
+                               off_t offset, int flags)
+{
+	return tst_syscall(__NR_pwritev2, fd, iov, iovcnt,
+			   LO_HI_LONG(offset), flags);
+}
+#endif
+
+#undef LO_HI_LONG
+
 #endif /* LAPI_PREADV2_H__ */
diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
deleted file mode 100644
index c715715b1..000000000
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- *
- * Copyright (c) 2015 Fujitsu Ltd.
- * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- * Copyright (c) Linux Test Project, 2016-2023
- */
-
-#ifndef PREADV_H
-#define PREADV_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_PREADV)
-int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
-{
-	return tst_syscall(__NR_preadv, fd, iov, iovcnt, offset);
-}
-#endif
-
-#endif /* RREADV_H */
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 871b3ab42..d5e5bd95f 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -20,7 +20,7 @@
 #include <sys/uio.h>
 
 #include "tst_test.h"
-#include "preadv.h"
+#include "lapi/uio.h"
 
 #define CHUNK           64
 
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 9977a4f48..19b194314 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -23,7 +23,7 @@
 #include <sys/uio.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "preadv.h"
+#include "lapi/uio.h"
 
 #define CHUNK           64
 
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 558d85050..997e7a07c 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -22,7 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include "tst_test.h"
-#include "preadv.h"
+#include "lapi/uio.h"
 
 #define MNTPOINT	"mntpoint"
 #define FNAME	MNTPOINT"/file"
diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
index 110977290..50f5a2e01 100644
--- a/testcases/kernel/syscalls/preadv2/preadv201.c
+++ b/testcases/kernel/syscalls/preadv2/preadv201.c
@@ -20,7 +20,7 @@
 #include <sys/uio.h>
 
 #include "tst_test.h"
-#include "lapi/preadv2.h"
+#include "lapi/uio.h"
 
 #define CHUNK           64
 
diff --git a/testcases/kernel/syscalls/preadv2/preadv202.c b/testcases/kernel/syscalls/preadv2/preadv202.c
index 4e1e82ebd..fd3b7c9d7 100644
--- a/testcases/kernel/syscalls/preadv2/preadv202.c
+++ b/testcases/kernel/syscalls/preadv2/preadv202.c
@@ -25,7 +25,7 @@
 #include <unistd.h>
 
 #include "tst_test.h"
-#include "lapi/preadv2.h"
+#include "lapi/uio.h"
 
 #define CHUNK           64
 
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index c87deb674..42b265680 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -45,7 +45,7 @@
 
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
-#include "lapi/preadv2.h"
+#include "lapi/uio.h"
 
 #define CHUNK_SZ 4123
 #define CHUNKS 60
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
deleted file mode 100644
index e657dc7e6..000000000
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- *
- * Copyright (c) 2015 Fujitsu Ltd.
- * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- * Copyright (c) Linux Test Project, 2016-2023
- */
-
-#ifndef PWRITEV_H
-#define PWRITEV_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_PWRITEV)
-int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
-{
-	return tst_syscall(__NR_pwritev, fd, iov, iovcnt, offset);
-}
-#endif
-
-#endif /* PWRITEV_H */
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index f5fce81f2..1a4f672bf 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -18,7 +18,7 @@
 #include <string.h>
 #include <sys/uio.h>
 #include "tst_test.h"
-#include "pwritev.h"
+#include "lapi/uio.h"
 #include "tst_safe_prw.h"
 
 #define	CHUNK		64
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 59a286847..25eb242f5 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -22,7 +22,7 @@
 #include <sys/uio.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "pwritev.h"
+#include "lapi/uio.h"
 
 #define CHUNK           64
 
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 1bf9d5731..81ccee9be 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -22,7 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include "tst_test.h"
-#include "pwritev.h"
+#include "lapi/uio.h"
 #include "tst_safe_prw.h"
 
 #define MNTPOINT	"mntpoint"
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
index 987412ba8..ae9047cdd 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
@@ -22,7 +22,7 @@
 #include <sys/uio.h>
 
 #include "tst_test.h"
-#include "lapi/pwritev2.h"
+#include "lapi/uio.h"
 #include "tst_safe_prw.h"
 
 #define CHUNK	64
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev202.c b/testcases/kernel/syscalls/pwritev2/pwritev202.c
index 5a1c4c6b6..e4d80070d 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev202.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev202.c
@@ -26,7 +26,7 @@
 #include <unistd.h>
 
 #include "tst_test.h"
-#include "lapi/pwritev2.h"
+#include "lapi/uio.h"
 
 #define CHUNK	64
 
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
