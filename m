Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D54C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 14:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EB013C62DD
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 16:07:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998823C4FC3
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A97581A0113D
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 16:07:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E5F321B4B;
 Thu, 16 Jun 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655388444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nm5XaWtMEP21fajmQlZKoMN/8KBg6agXljqdhPjsLcg=;
 b=pJyImK3ljGonEtWCLbauIXjB5AkGRpTmSqTndsespdX20R85okW6W23TpCw/oOmqnY/SQb
 XSGQhGXVZnJIA7c18JSpeS7JqzaU/s/y5UowPK6qQh4KfzfwgLI8/du6OqLu91yoTCN2JR
 dJ0GY8i0irXpg4V6LICDiE3lyS0OSpk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 016B113A70;
 Thu, 16 Jun 2022 14:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oHB5ORs5q2IlJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Jun 2022 14:07:23 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Jun 2022 16:07:11 +0200
Message-Id: <20220616140717.23708-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616140717.23708-1-andrea.cervesato@suse.com>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] Add more safe macros for mqueue API
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

Added SAFE_MQ_UNLINK and SAFE_MQ_CLOSE in tst_safe_posix_ipc.h

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_posix_ipc.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
index b60c12c9e..3650209ae 100644
--- a/include/tst_safe_posix_ipc.h
+++ b/include/tst_safe_posix_ipc.h
@@ -11,6 +11,10 @@
 
 #define SAFE_MQ_OPEN(pathname, oflags, ...) \
 	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
+#define SAFE_MQ_CLOSE(__mqdes) \
+	safe_mq_close(__FILE__, __LINE__, (__mqdes))
+#define SAFE_MQ_UNLINK(name) \
+	safe_mq_unlink(__FILE__, __LINE__, (name))
 
 static inline int safe_mq_open(const char *file, const int lineno,
 			       const char *pathname, int oflags, ...)
@@ -46,4 +50,34 @@ static inline int safe_mq_open(const char *file, const int lineno,
 	return rval;
 }
 
+static inline int safe_mq_close(const char *file, const int lineno,
+				mqd_t __mqdes)
+{
+	int rval;
+
+	rval = mq_close(__mqdes);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mq_close(%d) failed", __mqdes);
+	}
+
+	return rval;
+}
+
+static inline int safe_mq_unlink(const char *file, const int lineno,
+				const char* name)
+{
+	int rval;
+
+	rval = mq_unlink(name);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mq_unlink(%s) failed", name);
+	}
+
+	return rval;
+}
+
 #endif /* TST_SAFE_POSIX_IPC_H__ */
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
