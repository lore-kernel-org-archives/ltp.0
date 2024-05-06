Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE45C4345F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 05:32:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2DA33C88B2
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 07:32:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B93543C13BF
 for <ltp@lists.linux.it>; Mon,  6 May 2024 07:32:15 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 095141BCF414
 for <ltp@lists.linux.it>; Mon,  6 May 2024 07:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714973533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DCFikHseyUqrJ2Wmlv9qXkz98vJ825wkTNU76uMJp+c=;
 b=B4+BB/LtLBh9668oS0lcgIrFhNQRNAmG1Ylkh81r9I5XQpHczWVNa/uzqE8crNB3u9ydDT
 vCSHftTksDi5WtLpkj1NhGtj6FkSZ7IP4kDr0+oxaGKVKIi95RyOSn+16Ur10VduLBkcdY
 VXc20ODGfzKxB6nEUGnCp+B0y00AydI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-ck1iHSg2PmOW1N9chJYNFg-1; Mon,
 06 May 2024 01:32:11 -0400
X-MC-Unique: ck1iHSg2PmOW1N9chJYNFg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8038E380673B
 for <ltp@lists.linux.it>; Mon,  6 May 2024 05:32:11 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92DFE492BC7
 for <ltp@lists.linux.it>; Mon,  6 May 2024 05:32:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 May 2024 13:32:06 +0800
Message-ID: <20240506053207.12308-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch v3 1/2] lib: add SAFE_CALLOC macro
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 53aceb5ca..f228b99e1 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -75,6 +75,11 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd);
 #define SAFE_MALLOC(size) \
 	safe_malloc(__FILE__, __LINE__, NULL, (size))
 
+void *safe_calloc(const char *file, const int lineno, size_t nmemb, size_t size);
+
+#define SAFE_CALLOC(nmemb, size) \
+	safe_calloc(__FILE__, __LINE__, (nmemb), (size))
+
 void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
 
 #define SAFE_REALLOC(ptr, size) \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c6e6b15dc..39b8cc924 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -546,6 +546,20 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd)
 	return rval;
 }
 
+void *safe_calloc(const char *file, const int lineno, size_t nmemb, size_t size)
+{
+	void *rval;
+
+	rval = calloc(nmemb, size);
+
+	if (rval == NULL) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"calloc(%zu, %zu) failed", nmemb, size);
+	}
+
+	return rval;
+}
+
 void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size)
 {
 	void *ret;
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
