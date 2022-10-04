Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D85DC433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 08:31:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05C8E3CADD3
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 10:31:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A578F3C4F5C
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 10:31:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A6BE1001153
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 10:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664872274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oi5R+kSV+5dCuYt6Y6D5y/Pute1LOU3e8HnvqAOisXM=;
 b=KiThMBUX6ZZaxFmFWTu1nIAcL72O9EYTgQbA76EZ53MQeiLBK01wijNK9ZpSAmYH5/QlPC
 xZVF7LBpkc0MuiMOfVpGJbdhtmCNsHYd4RxGwuq1nJwIo5PWOtvPGFygVL2gln2kQdqNCI
 CikqoDRhmtvq3EyGNvgIXrISmHg9EKA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-LNmfh08DPdaeALj0m2amxQ-1; Tue, 04 Oct 2022 04:31:11 -0400
X-MC-Unique: LNmfh08DPdaeALj0m2amxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AC4C3C0F420;
 Tue,  4 Oct 2022 08:31:11 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.193.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC9E40C6EC2;
 Tue,  4 Oct 2022 08:31:10 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  4 Oct 2022 10:31:06 +0200
Message-Id: <938c864ee6bb82ffdee9371bd802642ffedc606c.1664872194.git.jstancek@redhat.com>
In-Reply-To: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: introduce safe_write() retry
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

Turn safe_write() len_strict parameter into 3-way switch, introducing
one additional mode of operation "retry". On short writes, this
resumes write() with remainder of the buffer.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/safe_macros_fn.h    | 11 ++++++++--
 lib/safe_macros.c           | 42 ++++++++++++++++++++++++++++---------
 lib/tests/tst_safe_macros.c |  6 +++---
 3 files changed, 44 insertions(+), 15 deletions(-)

I can send follow-up to update all call sites too.

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df952811b94..8eb03edd81ba 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -24,6 +24,13 @@
 #include <unistd.h>
 #include <dirent.h>
 
+/* supported values for safe_write() len_strict parameter */
+enum safe_write_opts {
+        SAFE_WRITE_ANY = 0,	// no length strictness, short writes are ok
+        SAFE_WRITE_ALL = 1,	// strict length, short writes raise TBROK
+        SAFE_WRITE_RETRY = 2,	// retry/resume after short write
+};
+
 char* safe_basename(const char *file, const int lineno,
                     void (*cleanup_fn)(void), char *path);
 
@@ -111,8 +118,8 @@ int safe_symlink(const char *file, const int lineno,
                  const char *newpath);
 
 ssize_t safe_write(const char *file, const int lineno,
-                   void (cleanup_fn)(void), char len_strict, int fildes,
-                   const void *buf, size_t nbyte);
+                   void (cleanup_fn)(void), enum safe_write_opts len_strict,
+                   int fildes, const void *buf, size_t nbyte);
 
 long safe_strtol(const char *file, const int lineno,
                  void (cleanup_fn)(void), char *str, long min, long max);
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 16e582bc976b..eac31f4ce3ff 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -524,20 +524,42 @@ int safe_symlink(const char *file, const int lineno,
 }
 
 ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
-                   char len_strict, int fildes, const void *buf, size_t nbyte)
+                   enum safe_write_opts len_strict, int fildes, const void *buf,
+                   size_t nbyte)
 {
 	ssize_t rval;
+	const void *wbuf = buf;
+	size_t len = nbyte;
+	int iter = 0;
+
+	do {
+		iter++;
+		rval = write(fildes, wbuf, len);
+		if (rval == -1) {
+			if (len_strict == SAFE_WRITE_RETRY)
+				tst_resm_(file, lineno, TINFO,
+					"write() wrote %zu bytes in %d calls",
+					nbyte-len, iter);
+			tst_brkm_(file, lineno, TBROK | TERRNO,
+				cleanup_fn, "write(%d,%p,%zu) failed",
+				fildes, buf, nbyte);
+		}
 
-	rval = write(fildes, buf, nbyte);
+		if (len_strict == SAFE_WRITE_ANY)
+			return rval;
 
-	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
-		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-			"write(%d,%p,%zu) failed", fildes, buf, nbyte);
-	} else if (rval < 0) {
-		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-			"Invalid write(%d,%p,%zu) return value %zd", fildes,
-			buf, nbyte, rval);
-	}
+		if (len_strict == SAFE_WRITE_ALL) {
+			if ((size_t)rval != nbyte)
+				tst_brkm_(file, lineno, TBROK | TERRNO,
+					cleanup_fn, "short write(%d,%p,%zu) "
+					"return value %zd",
+					fildes, buf, nbyte, rval);
+			return rval;
+		}
+
+		wbuf += rval;
+		len -= rval;
+	} while (len > 0);
 
 	return rval;
 }
diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
index b5809f40d10e..5c427ee16832 100644
--- a/lib/tests/tst_safe_macros.c
+++ b/lib/tests/tst_safe_macros.c
@@ -31,9 +31,9 @@ int main(int argc LTP_ATTRIBUTE_UNUSED, char **argv)
 	printf("buf: %s\n", buf);
 	SAFE_READ(cleanup, 1, fd, buf, 9);
 	printf("buf: %s\n", buf);
-	SAFE_WRITE(cleanup, 0, -1, buf, 9);
-	SAFE_WRITE(NULL, 0, fd, buf, 9);
-	SAFE_WRITE(NULL, 1, fd, buf, 9);
+	SAFE_WRITE(cleanup, SAFE_WRITE_ANY, -1, buf, 9);
+	SAFE_WRITE(NULL, SAFE_WRITE_ANY, fd, buf, 9);
+	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, buf, 9);
 	SAFE_PIPE(NULL, fds);
 
 	return 0;
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
