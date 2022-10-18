Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9873DC433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 03:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCF093CB022
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 05:22:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 599F23C54F7
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:22:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C45691400B8B
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 05:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666063331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7chzHP3kKL4/3A2867IZD7Jfz2++6+nXUf/pDhySaDc=;
 b=XYRVux73cDpaBe5/I044ywdA2DpUqk9A94uACQhJlUX2+EakQln/Fog1RxGrHd51D3RsqC
 7hO1criObY/USlsyNMiDAX1zeGFC10+U29zg93BWOAaMsPNLpIm8JgJR+dt0FdJGojyvjK
 Nr/hobKPjvJF82s2OMDyeztKnpgX2sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-Ea9-ZjP1O7iWKDrBNwLAmQ-1; Mon, 17 Oct 2022 23:22:08 -0400
X-MC-Unique: Ea9-ZjP1O7iWKDrBNwLAmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1E0A857F92;
 Tue, 18 Oct 2022 03:22:07 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F16D2166B41;
 Tue, 18 Oct 2022 03:22:05 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 18 Oct 2022 11:22:03 +0800
Message-Id: <20221018032203.3429895-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pthread_barrier_init: remove the restrict limit
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
Cc: rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The restrict keyword tells the compiler that a given pointer
does not alias any other pointer in the same context. But this
is only supported by C99.

To make older platforms compilinng LTP successful, we have to cancel
that limitation in function definition.

Fix error: https://github.com/linux-test-project/ltp/actions/runs/3263823142/jobs/5363481739

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
      I also considering adding "-std=gun99" for compiling the whole library,
      but not sure if this could bring a bigger potential impact on LTP.

 include/tst_safe_pthread.h | 4 ++--
 lib/safe_pthread.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
index cc6da2de8..8fb553929 100644
--- a/include/tst_safe_pthread.h
+++ b/include/tst_safe_pthread.h
@@ -41,8 +41,8 @@ int safe_pthread_barrier_destroy(const char *file, const int lineno,
 	safe_pthread_barrier_destroy(__FILE__, __LINE__, barrier);
 
 int safe_pthread_barrier_init(const char *file, const int lineno,
-			      pthread_barrier_t *restrict barrier,
-			      const pthread_barrierattr_t *restrict attr,
+			      pthread_barrier_t *barrier,
+			      const pthread_barrierattr_t *attr,
 			      unsigned count);
 #define SAFE_PTHREAD_BARRIER_INIT(barrier, attr, count) \
 	safe_pthread_barrier_init(__FILE__, __LINE__, barrier, attr, count);
diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
index d7bfee4cc..d70bb8707 100644
--- a/lib/safe_pthread.c
+++ b/lib/safe_pthread.c
@@ -90,8 +90,8 @@ int safe_pthread_cancel(const char *file, const int lineno,
 }
 
 int safe_pthread_barrier_init(const char *file, const int lineno,
-			      pthread_barrier_t *restrict barrier,
-			      const pthread_barrierattr_t *restrict attr,
+			      pthread_barrier_t *barrier,
+			      const pthread_barrierattr_t *attr,
 			      unsigned count)
 {
 	int rval;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
