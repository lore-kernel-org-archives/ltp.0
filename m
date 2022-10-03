Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605BC433F5
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 12:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C53633C9410
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 14:49:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4B9D3C4F4A
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 14:49:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C56676008E7
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 14:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664801338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MZDlk+YQk3Dc6fyjxS2YdjzFGJ6ixzCLtbB+hQV8hM4=;
 b=SoVj2Pn2RdtJ6chhNKuSYgKVwe5nxrUAaJrC0PUKJuio7ZnTxiRWzq8qHHHdSZOKnVh4Jo
 YAU5Xj90fHMVjDW8VGZqUruWW7wbpmqILk9gcp3uW8x7eFuadcXmszdq+AE2hvdjO+kLFI
 1KOt9OV/apq4R5cH3v1G+7F8gMamiH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-xyciRLpYPiOF7dcmpg0c3Q-1; Mon, 03 Oct 2022 08:48:56 -0400
X-MC-Unique: xyciRLpYPiOF7dcmpg0c3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A33185A794
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 12:48:56 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 333F6492B04
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 12:48:56 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Oct 2022 14:48:46 +0200
Message-Id: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: introduce safe_write_fully()
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

In case there is a short (but otherwise successful) write(),
safe_write_fully() repeats write() and attempts to resume
with the remainder of the buffer.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 81c4b0844267..caee0e9cf842 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -645,4 +645,9 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
 #define SAFE_SYSINFO(info) \
 	safe_sysinfo(__FILE__, __LINE__, (info))
 
+ssize_t safe_write_fully(const char *file, const int lineno,
+	int fildes, const void *buf, size_t nbyte);
+#define SAFE_WRITE_FULLY(fildes, buf, nbyte) \
+	safe_write_fully(__FILE__, __LINE__, (fildes), (buf), (nbyte))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c4cdc87e7346..e4d4ef4269a4 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -591,3 +591,22 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
 		tst_brk_(file, lineno, TBROK, "%s failed (%d)", argv[0], rval);
 	}
 }
+
+ssize_t safe_write_fully(const char *file, const int lineno,
+	int fildes, const void *buf, size_t nbyte)
+{
+	ssize_t rval;
+	size_t len = nbyte;
+
+	do {
+		rval = write(fildes, buf, len);
+		if (rval == -1) {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				"write(%d,%p,%zu) failed", fildes, buf, len);
+		}
+		buf += rval;
+		len -= rval;
+	} while (len > 0);
+
+	return nbyte;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
