Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD608C77B7E
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 08:09:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630893CD1C0
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 10:09:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BE183CAFCE
 for <ltp@lists.linux.it>; Thu, 25 May 2023 10:09:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36482600A96
 for <ltp@lists.linux.it>; Thu, 25 May 2023 10:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1d2gmuyHGk4lIiyG+HAy7Q78S5IXj2pNdzgKkQkEEdk=;
 b=bf3gezoXVn/uONy/Ve7PI2ACweyUoDjCyF+Viovh+oQGV/RBBsSMYjDgdf1Jge7n7OMDSM
 H3vJ3zhKBoIJTbO4eN/cLTu6UB8wUO1EIKv7RQb/eCkksxVe8JJSSF4bVamjHtMtOaYda6
 l/HBHpp30Carv/3v248yWR+so7wlzgE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-gevAnKMlO7GiwqW9i90Rkg-1; Thu, 25 May 2023 04:09:37 -0400
X-MC-Unique: gevAnKMlO7GiwqW9i90Rkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB9C1C12F89
 for <ltp@lists.linux.it>; Thu, 25 May 2023 08:09:36 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC7241121314
 for <ltp@lists.linux.it>; Thu, 25 May 2023 08:09:35 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 25 May 2023 16:09:33 +0800
Message-Id: <20230525080934.54793-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] FILE_PRINTF|SCANF: changing TWARN to TINFO
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

There is no necessity to generate TWARN in unsafe marcos.
As we do have SAFE_FILE_PRINTF to break test on TBROK when
needed, so we should unify the behavior for LTP macro.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/safe_file_ops.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index f803691d8..63ae2dbbe 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -76,7 +76,7 @@ int file_scanf(const char *file, const int lineno,
 	f = fopen(path, "r");
 
 	if (f == NULL) {
-		tst_resm_(file, lineno, TWARN, "Failed to open FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to open FILE '%s'",
 			path);
 		return 1;
 	}
@@ -88,20 +88,20 @@ int file_scanf(const char *file, const int lineno,
 	va_end(va);
 
 	if (ret == EOF) {
-		tst_resm_(file, lineno, TWARN,
+		tst_resm_(file, lineno, TINFO,
 			"The FILE '%s' ended prematurely", path);
 		goto err;
 	}
 
 	if (ret != exp_convs) {
-		tst_resm_(file, lineno, TWARN,
+		tst_resm_(file, lineno, TINFO,
 			"Expected %i conversions got %i FILE '%s'",
 			exp_convs, ret, path);
 		goto err;
 	}
 
 	if (fclose(f)) {
-		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to close FILE '%s'",
 			path);
 		return 1;
 	}
@@ -110,7 +110,7 @@ int file_scanf(const char *file, const int lineno,
 
 err:
 	if (fclose(f)) {
-		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to close FILE '%s'",
 			path);
 	}
 
@@ -218,7 +218,7 @@ int file_printf(const char *file, const int lineno,
 	f = fopen(path, "w");
 
 	if (f == NULL) {
-		tst_resm_(file, lineno, TWARN, "Failed to open FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to open FILE '%s'",
 			path);
 		return 1;
 	}
@@ -226,7 +226,7 @@ int file_printf(const char *file, const int lineno,
 	va_start(va, fmt);
 
 	if (vfprintf(f, fmt, va) < 0) {
-		tst_resm_(file, lineno, TWARN, "Failed to print to FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to print to FILE '%s'",
 			path);
 		goto err;
 	}
@@ -234,7 +234,7 @@ int file_printf(const char *file, const int lineno,
 	va_end(va);
 
 	if (fclose(f)) {
-		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to close FILE '%s'",
 			path);
 		return 1;
 	}
@@ -243,7 +243,7 @@ int file_printf(const char *file, const int lineno,
 
 err:
 	if (fclose(f)) {
-		tst_resm_(file, lineno, TWARN, "Failed to close FILE '%s'",
+		tst_resm_(file, lineno, TINFO, "Failed to close FILE '%s'",
 			path);
 	}
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
