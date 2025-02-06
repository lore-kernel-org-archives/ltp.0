Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AD1C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 09:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA3C13C29EC
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 10:50:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 331DB3C12C2
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 10:50:34 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F277065F21C
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 10:50:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738835432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B/vHz4Pif5VXZEnu91dy6zglfxXZB/acWexoct0M4ms=;
 b=YmVvLKxZDzQ7K+HktyvwuAvUlxvau6zEmHc938X/lYpC03aek59xnJEiyBGmLrdNNxmxj1
 PUvqOaaopqrTemqFU6n4Umzu/bo9x+b/nlYgFarP+WzB8TCfFT6N39n9LyNLJKIo97ewqC
 0nTOQTaFcQ1hv8zbWfcptjUWr7NeBxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-qaFJSD3APr6ZE06gtmdw8g-1; Thu,
 06 Feb 2025 04:50:30 -0500
X-MC-Unique: qaFJSD3APr6ZE06gtmdw8g-1
X-Mimecast-MFC-AGG-ID: qaFJSD3APr6ZE06gtmdw8g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91D3D1956096
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 09:50:29 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5D6C1800570
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 09:50:28 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 10:49:26 +0100
Message-ID: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n-dbxuW0_Keeb2fzW3usRwTJTVFkt_OqK8UCzA-uB90_1738835429
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mallinfo02: introduce LTP_VAR_USED to avoid
 optimization
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

gcc 15 is a bit more clever and noticed that 'buf' isn't used
for anything so it optimized it out, including call to malloc.
So, there's also no mmap() call behind it and test fails,
because nothing was allocated.

Introduce LTP_VAR_USED macro, that makes compiler aware of the
variable and doesn't optimize it out.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_common.h                               | 2 ++
 testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index b14bbae04077..3de826acd0ec 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -13,6 +13,8 @@
 #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
 #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
 
+#define LTP_VAR_USED(p) asm volatile("" :: "m"(p)); p
+
 #ifndef ARRAY_SIZE
 # define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
index 90cf4fcb3b89..51783fc22b80 100644
--- a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
+++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
@@ -26,7 +26,7 @@ void test_mallinfo2(void)
 	char *buf;
 	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
 
-	buf = malloc(size);
+	LTP_VAR_USED(buf) = malloc(size);
 
 	if (!buf)
 		tst_brk(TCONF, "Current system can not malloc 2G space, skip it");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
