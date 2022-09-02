Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F69FC6FA82
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 20:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6EED3CA8B0
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 22:45:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 970CC3C97BB
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 22:45:49 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2712600CF8
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 22:45:48 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 by13-20020a056a00400d00b0052ec5a1cd4dso1573468pfb.21
 for <ltp@lists.linux.it>; Fri, 02 Sep 2022 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=PAZ9RJF/NZydCbSHmj/pgygB21FhWpw8Y+PRDCtou6A=;
 b=HTLYN8951/Zyn2LQhV1xY6mU2zJwL9ZrHEocLOR3EK+kvu+9/NJDiHLOk48SjTj5F/
 4Mm+TY87hHNWWMO9zZ1geKoT4/K+tsxeyZn/Jtq/14cxyF9kIssGYA1UesVc9MlGPgXT
 6f5NeFjRW2pRNoB7llqiWEveEyZ7Fi0rcuBdCgN9JJFa9Zph15SRrLc6xkkh9TlZHgB8
 A1Ir+LfgEUalkR50mhQr7BCdo1qVWlHGN9C7PAwrzehyQke+SRrmlITqdnKjNZx26s4k
 YNbtDoWJeQRZ+Z5wigZUFXLat+eN9ACIZkG/o4XqrI1zWuTmC/+7kzPg2w2VL3nlDRwx
 4YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=PAZ9RJF/NZydCbSHmj/pgygB21FhWpw8Y+PRDCtou6A=;
 b=Tow1oFqTFbWjOgZD1HvAbEdCG9J0tNVf5dT43PXdLyFgAtMc2Bg1KZ+zhVudG2jNoL
 adHyGiNhfgN/dVilucNe8swb3WuFGqXxrz06IcQvnE1ylRariz1sVOC/fZweuz59xMBn
 GgCTGRWJDF0exsNTCglkXsZPhIJNpRMdf4q5zItXl9s8nXjavvb9TuklxKEuDqulyjMe
 2dhBH+JgVPnzTEk4CxhmnhwvmtHjx0t91sNdwXLSp0uV5o6LJY35fMK4AlgQM7p1QHMX
 1HKByLY0DRnEtCe257H/K7bLvAQXoKcApQuvT5ENFy8AjzdmVSJnrJk5N3+ajKfm8x2G
 fB4g==
X-Gm-Message-State: ACgBeo3cAskIpOXBGEtpVqIvwQWUBytqyndADmIrE6pTK2dhobBpWAeJ
 gL6uwcvZXv/TCjbqmZx0KEirlXz0JBosv/qq8L3zLY7u1yunlaYZvKiKCTCeqSQtzAZ+a4wip0K
 96V2UimyEyHNWq5kf+WtHlDAUyUFkClL+JxWGU4bzGPpSuNizb7pSFztk
X-Google-Smtp-Source: AA6agR6ktEAPK36i3JlSGjo4V8i4MHsAKyEG62rWH4au8P4lSE/uiwspb6j3Oqe/xM2soz82/jpR9DoHDJY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e80c:b0:174:e386:c5b7 with SMTP id
 u12-20020a170902e80c00b00174e386c5b7mr23452832plg.84.1662151546754; Fri, 02
 Sep 2022 13:45:46 -0700 (PDT)
Date: Fri,  2 Sep 2022 20:45:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902204539.1035669-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Revert "m4: Remove check for io_set_eventfd"
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This reverts commit 5ca0d16d66c42fbfa483c180de4c881de7f182cc.

Android has libaio headers but is missing some functions including
io_set_eventfd.  Without these checks it will fail to compile.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 m4/ltp-eventfd.m4                             | 11 ++++++++++-
 testcases/kernel/syscalls/eventfd/eventfd01.c | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
index ecd7e951d..5d729a33d 100644
--- a/m4/ltp-eventfd.m4
+++ b/m4/ltp-eventfd.m4
@@ -1,6 +1,6 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Red Hat Inc., 2008
-dnl Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
+dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 dnl Author: Masatake YAMATO <yamato@redhat.com>
 
 AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
@@ -10,5 +10,14 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
 	if test "x$have_libaio" = "xyes" -a "x$have_aio" = "xyes"; then
 		AC_DEFINE(HAVE_LIBAIO, 1, [Define to 1 if you have libaio and it's headers installed.])
 		AC_SUBST(AIO_LIBS, "-laio")
+
+		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
+		AC_TRY_LINK([#include <stdio.h>
+                             #include <libaio.h>
+		            ],
+		            [io_set_eventfd(NULL, 0); return 0;],
+		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
+						AC_MSG_RESULT(yes)],
+		            [AC_MSG_RESULT(no)])
 	fi
 ])
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 3180ea159..242e170e2 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -1,6 +1,5 @@
 /*
  *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
- *   Copyright (c) Linux Test Project, 2008-2022
  *
  *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
  *   Original copyright message:
@@ -473,6 +472,7 @@ static void child_inherit_test(int fd)
 	}
 }
 
+#ifdef HAVE_IO_SET_EVENTFD
 /*
  * Test whether counter overflow is detected and handled correctly.
  *
@@ -648,6 +648,22 @@ static void overflow_read_test(int evfd)
 	}
 	cleanup_overflow(fd, ctx);
 }
+#else
+static void overflow_select_test(int evfd)
+{
+	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
+}
+
+static void overflow_poll_test(int evfd)
+{
+	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
+}
+
+static void overflow_read_test(int evfd)
+{
+	tst_resm(TCONF, "eventfd support is not available in AIO subsystem");
+}
+#endif
 
 int main(int argc, char **argv)
 {
-- 
2.37.2.789.g6183377224-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
