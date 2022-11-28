Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7398BC46467
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:19:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0BF83CC64D
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:19:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFEF83CC66B
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A7AED14001EB
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669634325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZK9aDW5xPVA35fVgnvuUX9snELpNn+P7w27uwudXcs=;
 b=G9TpKNKmYGBuumlX7En3b0fjio1nYwoyHSbMe3CLMYPq4J37rPxcd2yMsqFAiJUA8yuBFo
 q+Q5raXUKvtcwhwA7m5TW6+wWnAyWypLSvEMDWIKZczm3OKMyUhiwYlJiWmS7tWYCOOnxv
 tphv4QyrVtJjxM+NeV3E5geAP7AjvGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-IoLJT-8RN3mhS_4dFiXTEQ-1; Mon, 28 Nov 2022 06:18:41 -0500
X-MC-Unique: IoLJT-8RN3mhS_4dFiXTEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FB94801585;
 Mon, 28 Nov 2022 11:18:41 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFC4C15BA4;
 Mon, 28 Nov 2022 11:18:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 28 Nov 2022 12:18:32 +0100
Message-Id: <20221128111833.98937-3-david@redhat.com>
In-Reply-To: <20221128111833.98937-1-david@redhat.com>
References: <20221128111833.98937-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] security/dirtyc0w_shmem: Fix compile-time
 absence of UFFD_FEATURE_MINOR_SHMEM
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

Without UFFD_FEATURE_MINOR_SHMEM, we'd currently let the parent run into
a timeout because we don't make the checkpoint happy, failing the
testcase instead of skipping it as TCONF.

Let's make compilation always work by including include/lapi/userfaultfd.h.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Fixes: a46f8956f ("security/dirtyc0w_shmem: Add new test for CVE-2022-2590")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../security/dirtyc0w_shmem/dirtyc0w_shmem_child.c   | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index 61799a504..9c2b03994 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -20,17 +20,11 @@
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 
-#ifdef HAVE_LINUX_USERFAULTFD_H
-#include <linux/userfaultfd.h>
-#endif
-
-#ifdef UFFD_FEATURE_MINOR_SHMEM
-
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_pthread.h"
-#include "lapi/syscalls.h"
+#include "lapi/userfaultfd.h"
 
 #define TMP_DIR "tmp_dirtyc0w_shmem"
 #define TEST_FILE TMP_DIR"/testfile"
@@ -238,7 +232,3 @@ int main(void)
 
 	return 0;
 }
-#else /* UFFD_FEATURE_MINOR_SHMEM */
-#include "tst_test.h"
-TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
-#endif /* UFFD_FEATURE_MINOR_SHMEM */
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
