Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D3EFA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 11:32:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77363CA9E5
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:32:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E96893CA9B6
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:32:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9093A600463
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 12:32:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C279D3372C;
 Mon, 31 Oct 2022 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1667215932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncS1wgEj8DhUjGklKB82fRO/UgGa6ty2jhvj3+b0cG4=;
 b=eeCHS7rhD03/2l+SjZCDS3vwolOj4KZIPn9H6mZtFHq/LJX14SbmxtX1M0jv3iInlUGeDr
 M9mrwAlVXlCmy5N58dQCQk2X/N6g5FufLGjxF7iQHAtP2ShqBtN35Kx5TSMfL3DHaN108f
 hOWpl6hN2AHLhLdw4dIbyvOzhCYHpes=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C0413AAD;
 Mon, 31 Oct 2022 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WIJEGDyyX2ObHQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 31 Oct 2022 11:32:12 +0000
To: ltp@lists.linux.it
Date: Mon, 31 Oct 2022 12:30:45 +0100
Message-Id: <20221031113046.9218-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221031113046.9218-1-andrea.cervesato@suse.com>
References: <20221031113046.9218-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Add SAFE_SETHOSTNAME macro
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Add safe_sethostname missing definition inside header file

 include/safe_net_fn.h  |  3 +++
 include/tst_safe_net.h |  3 +++
 lib/safe_net.c         | 17 +++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/safe_net_fn.h b/include/safe_net_fn.h
index ff81b1337..6c63cb2cf 100644
--- a/include/safe_net_fn.h
+++ b/include/safe_net_fn.h
@@ -73,6 +73,9 @@ int safe_getsockname(const char *file, const int lineno,
 int safe_gethostname(const char *file, const int lineno,
 		     char *name, size_t size);
 
+int safe_sethostname(const char *file, const int lineno,
+		     const char *name, size_t size);
+
 int tst_getsockport(const char *file, const int lineno, int sockfd);
 
 unsigned short tst_get_unused_port(const char *file, const int lineno,
diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index e85b79a3e..98f0256fd 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -68,6 +68,9 @@
 #define SAFE_GETHOSTNAME(name, size) \
 	safe_gethostname(__FILE__, __LINE__, name, size)
 
+#define SAFE_SETHOSTNAME(name, size) \
+	safe_sethostname(__FILE__, __LINE__, name, size)
+
 #define TST_GETSOCKPORT(sockfd) \
 	tst_getsockport(__FILE__, __LINE__, sockfd)
 
diff --git a/lib/safe_net.c b/lib/safe_net.c
index 1717f0745..5dec0de11 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -469,6 +469,23 @@ int safe_gethostname(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_sethostname(const char *file, const int lineno,
+		     const char *name, size_t size)
+{
+	int rval = sethostname(name, size);
+
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"sethostname(%p, %zu) failed", name, size);
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid sethostname(%p, %zu) return value %d", name,
+			size, rval);
+	}
+
+	return rval;
+}
+
 /*
  * @return port in network byte order.
  */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
