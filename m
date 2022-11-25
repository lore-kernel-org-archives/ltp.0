Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525AC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:52:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 944113CC884
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:52:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6043A3C010E
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:52:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9385A1A00F3D
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669373529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zOCRrkC7pjy69SrbjhYuk5RXJhbm24AjpiD/h5r9Ohk=;
 b=b07r/59Fd6IiUYboqva/fAy18F1EOwk4OSdzYVcHgbmGpbadQ0COXV0DWZCrD4ZWM/yEPb
 8/lAjBzg0lhe/f+jG7KRr9JatXpjTWlvXFgoxaosIyBF+PUwnDHsWlqZMBYNCaSMWvvAVY
 K3Rf4Bv3ZbHzLEyXaXq39YgnXPSgLEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-ee6X18_jO_i-zRGWLeTC-A-1; Fri, 25 Nov 2022 05:52:06 -0500
X-MC-Unique: ee6X18_jO_i-zRGWLeTC-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEB4185A5A6;
 Fri, 25 Nov 2022 10:52:05 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 514092024CBE;
 Fri, 25 Nov 2022 10:52:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 25 Nov 2022 11:52:01 +0100
Message-Id: <20221125105201.59048-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] security/dirtyc0w_shmem: Fix remaining cases where
 UFFD_FEATURE_MINOR_SHMEM is absent
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
checkpoint happy, otherwise our parent process will run into a timeout.
Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
the UFFD_API ioctl: if the kernel knows about the feature but doesn't
support it, it will be masked off.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index cb2e9df0c..c117c6f39 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -24,12 +24,12 @@
 #include <linux/userfaultfd.h>
 #endif
 
-#ifdef UFFD_FEATURE_MINOR_SHMEM
-
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
+
+#ifdef UFFD_FEATURE_MINOR_SHMEM
 #include "lapi/syscalls.h"
 
 #define TMP_DIR "tmp_dirtyc0w_shmem"
@@ -162,6 +162,10 @@ retry:
 			"Could not create userfault file descriptor");
 	}
 
+	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
+		tst_brk(TCONF,
+			"System does not have userfaultfd minor fault support for shmem");
+
 	uffdio_register.range.start = (unsigned long) map;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
@@ -236,6 +240,10 @@ int main(void)
 	return 0;
 }
 #else /* UFFD_FEATURE_MINOR_SHMEM */
-#include "tst_test.h"
-TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
+int main(void)
+{
+	tst_reinit();
+	TST_CHECKPOINT_WAKE(0);
+	tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem");
+}
 #endif /* UFFD_FEATURE_MINOR_SHMEM */
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
