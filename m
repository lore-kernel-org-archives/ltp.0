Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A821DC433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 06:14:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ABE13C970F
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 07:14:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BCDB3C96C0
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 308D020015B
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6D2EE2190B;
 Thu, 27 Jan 2022 06:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643263987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Em7u5q4Ek3BfNbo2rYhS8/QrS1/B0XyCjc/uHKk4NIk=;
 b=uHWNro7jjYnBdHSXF+V0reqPNWze9adFUkS8sSdRrJ1kdPBxVeMerZlD1OvnVHLRxvAJFS
 NiLatnbZ85ywQ5/2bNiavbpQ67/ejP0o+DFLY2B8nzTfIEig8vtdIDCBCF5+RuGRhCs3/n
 V9YlXlk8CpHfEM4fDyI2DEOwjPARHXY=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 3EE50A3B81;
 Thu, 27 Jan 2022 06:13:07 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 06:12:21 +0000
Message-Id: <20220127061225.23368-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127061225.23368-1-rpalethorpe@suse.com>
References: <20220127061225.23368-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] API: Add tst_reap_child
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

Add a simple way to wait for a specific child process. This makes
sense when you want to wait for a child while others continue to run
in the background.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_test.h |  6 ++++++
 lib/tst_test.c     | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 450ddf086..8faf19141 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -106,6 +106,12 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
  */
 void tst_reap_children(void);
 
+/*
+ * Wait for one child and exit with TBROK if it returns a non-zero
+ * exit status
+ */
+void tst_reap_child(pid_t child);
+
 struct tst_option {
 	char *optstr;
 	char **arg;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 844756fbd..156a1e4b3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -416,6 +416,28 @@ void tst_reap_children(void)
 	}
 }
 
+void tst_reap_child(const pid_t pid)
+{
+	int status;
+
+	for (;;) {
+		const pid_t ret_pid = waitpid(pid, &status, 0);
+
+		if (ret_pid > 0) {
+			check_child_status(ret_pid, status);
+			continue;
+		}
+
+		if (errno == ECHILD)
+			break;
+
+		if (errno == EINTR)
+			continue;
+
+		tst_brk(TBROK | TERRNO, "waitpid(%d, ...) failed", pid);
+	}
+}
+
 
 pid_t safe_fork(const char *filename, unsigned int lineno)
 {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
