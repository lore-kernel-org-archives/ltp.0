Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF4DEDE9A8
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 11:45:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B48833CE70B
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 13:45:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E33253CB23E
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:45:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17EFC1400E73
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:45:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F5982184E
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694691923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EWhxU4cbIfOWeeghGonhMM8jYgs6S53lG3o2aNNBJac=;
 b=CXWrKDDomuJ84OP1vqFaKK6l358IeYVyM7xubUKuAc8U+mDKE3b5yerBHXok7wJKc9hgnf
 HIsBNiHWgFFjR8DYPn5ZIKYRygRAlWQo1fbGv6PSYPz0qg3v+gzDlrOkJb1hBwrPQBODQT
 Jok+w1J+Y4jElyfnqRp3yHGCz6seBfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694691923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EWhxU4cbIfOWeeghGonhMM8jYgs6S53lG3o2aNNBJac=;
 b=edVsewtTG7dC7ojY6zBalnEy79HgcH/K/8lkYwnGV8xyjLBkISt9JsFbpe+bqBYXM0c97m
 6U2Yz0jmu532jzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D511B139DB
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YoKjKVLyAmURGQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:45:22 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Sep 2023 17:15:18 +0530
Message-ID: <20230914114520.5212-1-akumar@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Add SAFE_MSYNC() macro to LTP library
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 include/tst_safe_macros.h |  6 ++++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 0cf3d7878..c899c4f2c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -86,6 +86,12 @@ void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
 #define SAFE_MUNMAP(addr, length) \
 	safe_munmap(__FILE__, __LINE__, NULL, (addr), (length))
 
+int safe_msync(const char *file, const int lineno, void *addr,
+				size_t length, int flags);
+
+#define SAFE_MSYNC(addr, length, flags) \
+	safe_msync(__FILE__, __LINE__, (addr), (length), (flags))
+
 #define SAFE_OPEN(pathname, oflags, ...) \
 	safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
 	    ##__VA_ARGS__)
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c4cdc87e7..7f28d43e5 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -591,3 +591,22 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
 		tst_brk_(file, lineno, TBROK, "%s failed (%d)", argv[0], rval);
 	}
 }
+
+int safe_msync(const char *file, const int lineno, void *addr,
+				size_t length, int flags)
+{
+	int rval;
+
+	rval = msync(addr, length, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"msync(%p, %zu, %d) failed", addr, length, flags);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid msync(%p, %zu, %d) return value %d",
+			addr, length, flags, rval);
+	}
+
+	return rval;
+}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
