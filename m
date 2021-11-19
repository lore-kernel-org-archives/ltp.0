Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F59C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD29A61108
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD29A61108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07A1F3C89A9
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:47:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44C3A3C89AF
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:18 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D22D21A0149E
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:17 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 262A29F6A0;
 Fri, 19 Nov 2021 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307977; bh=izi3kpVW5OxO49WRtTMAcgCVn/LaC7+txiEie9uqcm4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=K4U+IkBovUfez2FJXntopq7a7Po6DBMNyZ76dUu+jG/MRZGuF1s8oKQfFmFbu4AlP
 fHZpj1E+OmCKQh8V225XtASgFl+gKwXOXXF5At4UfJHMP012U6xp/O4GJEGByoKcZl
 oWPqzp66fo4CmOHOSTtwbGG1j6IJCciHnSqP5kIc=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:59 +0100
Message-Id: <20211119074602.857595-10-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/12] posix/conformance/interfaces/pthread_*_destroy:
 Suppress nonnull warning
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

These two tests are specifically testing passing NULL to the functions,
so we supress the error message at least for gcc.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/pthread_condattr_destroy/4-1.c      | 3 +++
 .../conformance/interfaces/pthread_mutexattr_destroy/4-1.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/4-1.c
index d0aa32f8a..6205d8d29 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_condattr_destroy/4-1.c
@@ -15,6 +15,9 @@
  *
  */
 
+/* This test explicitly tries to pass null to a parameter, that should not be NULL */
+#pragma GCC diagnostic ignored "-Wnonnull"
+
 #include <pthread.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/4-1.c
index 094739030..cad698012 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_destroy/4-1.c
@@ -15,6 +15,9 @@
  *
  */
 
+/* This test explicitly tries to pass null to a parameter, that should not be NULL */
+#pragma GCC diagnostic ignored "-Wnonnull"
+
 #include <pthread.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
