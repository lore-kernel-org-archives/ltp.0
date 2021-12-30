Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3949C433F5
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 10:38:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CCB63C31A4
	for <ltp@archiver.kernel.org>; Thu, 30 Dec 2021 11:38:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 427663C0BA7
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E84231400763
 for <ltp@lists.linux.it>; Thu, 30 Dec 2021 11:37:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F279D21127;
 Thu, 30 Dec 2021 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640860657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7oYMcMq3AxVjKeJ4gZHR34a7EHX31DVcznJNMNrJS0=;
 b=c694BEX2q8pTW7EBeei3WLTrS2lGQnTsBMO3RHLwHuRRvAILVkHhQDqWiWcF/wn0UZoOb/
 Qc1EcRNilXWcRgHKO+jlRBOFQdwwnyffqphAc70+6BlmvBTM8F05klfTVymXk0wY2sqrK7
 Pf8zyfVA26eDIKmz4pTqBaCZBgfnsTY=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id B8E25A3B83;
 Thu, 30 Dec 2021 10:37:36 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 30 Dec 2021 10:37:14 +0000
Message-Id: <20211230103718.369-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211220131043.18894-1-rpalethorpe@suse.com>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/5] API/cgroup: Add safe_cgroup_lines_scanf
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Similar to file_lines_scanf. Allows us to read a particular key-value
pair from a controller file. Can replace kselftest's cg_read_key_*
when converting tests.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

V2:
* Use all filesystems
* Add new EXP macro
* Switch to strtok_r
* Increase the margin of error for exfat and ext234
* Write to the file instead of reading to populate the page cache
  (allows it to work on tmpfs)

 include/tst_cgroup.h | 12 +++++++++++-
 lib/tst_cgroup.c     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 632050e86..561216296 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -188,9 +188,19 @@ void safe_cgroup_printf(const char *const file, const int lineno,
 void safe_cgroup_scanf(const char *file, const int lineno,
 		       const struct tst_cgroup_group *const cg,
 		       const char *const file_name,
-		       const char *fmt, ...)
+		       const char *const fmt, ...)
 		       __attribute__ ((format (scanf, 5, 6), nonnull));
 
+#define SAFE_CGROUP_LINES_SCANF(cg, file_name, fmt, ...)		\
+	safe_cgroup_lines_scanf(__FILE__, __LINE__,			\
+				(cg), (file_name), (fmt), __VA_ARGS__)
+
+void safe_cgroup_lines_scanf(const char *const file, const int lineno,
+			     const struct tst_cgroup_group *const cg,
+			     const char *const file_name,
+			     const char *const fmt, ...)
+			__attribute__ ((format (scanf, 5, 6), nonnull));
+
 #define SAFE_CGROUP_OCCURSIN(cg, file_name, needle)		\
 	safe_cgroup_occursin(__FILE__, __LINE__,		\
 			     (cg), (file_name), (needle))
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index c08ff2f20..c78f28112 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1161,6 +1161,39 @@ void safe_cgroup_scanf(const char *const file, const int lineno,
 		 file_name, buf, fmt, ret, conv_cnt);
 }
 
+void safe_cgroup_lines_scanf(const char *const file, const int lineno,
+			     const struct tst_cgroup_group *const cg,
+			     const char *const file_name,
+			     const char *const fmt, ...)
+{
+	va_list va;
+	char buf[BUFSIZ];
+	ssize_t len = safe_cgroup_read(file, lineno,
+				       cg, file_name, buf, sizeof(buf));
+	const int conv_cnt = tst_count_scanf_conversions(fmt);
+	int ret = 0;
+	char *line, *buf_ptr;
+
+	if (len < 1)
+		return;
+
+	line = strtok_r(buf, "\n", &buf_ptr);
+	while (line && ret != conv_cnt) {
+		va_start(va, fmt);
+		ret = vsscanf(line, fmt, va);
+		va_end(va);
+
+		line = strtok_r(NULL, "\n", &buf_ptr);
+	}
+
+	if (conv_cnt == ret)
+		return;
+
+	tst_brk_(file, lineno, TBROK,
+		 "'%s': vsscanf('%s', '%s', ..): Less conversions than expected: %d != %d",
+		 file_name, buf, fmt, ret, conv_cnt);
+}
+
 int safe_cgroup_occursin(const char *const file, const int lineno,
 			 const struct tst_cgroup_group *const cg,
 			 const char *const file_name,
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
