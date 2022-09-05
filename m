Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA8ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 19:41:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3D963CA9C9
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 21:41:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCCD3CA92D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 21:41:39 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE8471A00A52
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 21:41:38 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-345753b152fso4497307b3.7
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date; bh=MkhDI3CKMAYeWUcdpwQg0nSCkNBJA/e+pe4vnUg81rE=;
 b=T4B5/hhOS9p3SXMK5/wsnVMUvEo2QULOuvIO2MTi5ksUJqwBy4k1kkMafnXjrhuO93
 VcQKzE1hsMXhxkBWYO5uiFxH1cxU/tMTR8BqHYxHINqn9p3KimO0FSZX6WJZKMuODn6I
 FuK0csozp4s5RHISVoWSIRAIpqFXYro97kvle9eZKRk6DApidVIqyfSaGSiJLVj4amah
 vql10vUPuouXbPXXiZeX4nl2L1t3Xan033T2jzda/JxTsIu1kKELn9gzSprCySh3F0ZX
 tuL9QntioSa1TRO0rJedLRSdesycDsDQj3UPkTW4k+ryFLS2C9VBPh0xL8btDa1Dr0zG
 TYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date;
 bh=MkhDI3CKMAYeWUcdpwQg0nSCkNBJA/e+pe4vnUg81rE=;
 b=rdw91ghoNcJ9wWwaJK2EZkcxrswvCFDr5mUj8uCOz60wt6KVrM/Gxj8T/armpEOTLo
 MaXVbvzlutEOQqqfPGjgIZMWMT37NIstH8dVeYL6QoRHRyJqgXzw/svL22rM5saLQnvo
 MjDQxSm0ZqrvH1e82zMgDVIltUw4JKCx88EPVeXpx5rwjHiywcl8LFV+YbpU4WPh622E
 wFkLUBEHVIrj1pkNF3nGzlLNptuucKWrrWj0NB/GsHDINTIJV5gw2kjszBDqkNuGNSjp
 qxj2YSxeVTx6+gab8l9ttLH3NkAfTRWrP4G1d4K579NbFP013mqmsW816Ltw7KM5qhwQ
 aHAg==
X-Gm-Message-State: ACgBeo3dKxv1syUtHoVeR2SSKaecdCj3wtBqvomrIz2o1N7x387nCQDn
 6QKRFJf5bPTpLvam8eb42tC0pMJFeVznGvTl3Y4/rSEDRnM6mR1WmJLnklwkSS58yOxG4Xh8Bve
 9sSLx4X04I/iM+w9RcifTysxFZ3FuTEv9ORgQa/yflg0DQKoi3UCiJL5r
X-Google-Smtp-Source: AA6agR6dadU8+mfK8/hjzjDEiAf6dwRQ4+2I81mHWUE7XANIBO01C7uoXn+rpVnVv0Vmzt89H0Kbi6L67oc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:f201:0:b0:6a7:a6ee:6054 with SMTP id
 i1-20020a25f201000000b006a7a6ee6054mr9274727ybe.564.1662406897662; Mon, 05
 Sep 2022 12:41:37 -0700 (PDT)
Date: Mon,  5 Sep 2022 19:41:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905194135.2352027-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Revert "m4: Remove check for io_set_eventfd"
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
 m4/ltp-eventfd.m4                             |  9 +++++++++
 testcases/kernel/syscalls/eventfd/eventfd01.c | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
index ecd7e951d..1e0ec688a 100644
--- a/m4/ltp-eventfd.m4
+++ b/m4/ltp-eventfd.m4
@@ -10,5 +10,14 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
 	if test "x$have_libaio" = "xyes" -a "x$have_aio" = "xyes"; then
 		AC_DEFINE(HAVE_LIBAIO, 1, [Define to 1 if you have libaio and it's headers installed.])
 		AC_SUBST(AIO_LIBS, "-laio")
+
+		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
+		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdio.h>
+		                                  #include <libaio.h>
+		                                ]],
+		                                [[io_set_eventfd(NULL, 0); return 0;]])],
+		               [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
+		                AC_MSG_RESULT(yes)],
+		               [AC_MSG_RESULT(no)])
 	fi
 ])
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 3180ea159..c24aa3197 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -473,6 +473,7 @@ static void child_inherit_test(int fd)
 	}
 }
 
+#ifdef HAVE_IO_SET_EVENTFD
 /*
  * Test whether counter overflow is detected and handled correctly.
  *
@@ -648,6 +649,22 @@ static void overflow_read_test(int evfd)
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
