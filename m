Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E941EE57F3
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 10:23:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617903CB930
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:23:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F4DF3CB4FF
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 723FB602986
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 84E6D1FD7D;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694168596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWpWyN/u87HICjd86hfJXPgKxiIL053ojRdMTssnEdc=;
 b=WWxUfqCmBqtNqSSkyUBWMaL6w98plDzvkW+pLATkHmUkocAuQ4V4rzFyN1/pZddB7KNcJn
 QrOXexsPteQo325ORWApDbUkbg68ZFOupWTFgdMyTQxWBkpBzzT8szdfVAZo/TLyltTm6Y
 d8QTuIqUB+I3UNul1QJdaW35jZoJTwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694168596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWpWyN/u87HICjd86hfJXPgKxiIL053ojRdMTssnEdc=;
 b=KC2UxDLORdtgX3nQ31lMftknjqxt6xNksMrBl/KbGDP2v47OegcOG/InzmbxsG8SylAdH2
 fxPptvFbS4mfp5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64F4F131FD;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8JsRFxT2+mRFcwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 10:23:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 12:23:14 +0200
Message-Id: <20230908102315.8163-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908102315.8163-1-andrea.cervesato@suse.de>
References: <20230908102315.8163-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add tst_gettid wrapper around gettid syscall
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_pid.h | 8 ++++++++
 lib/tst_pid.c     | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/include/tst_pid.h b/include/tst_pid.h
index 774c845ce..6958d5d23 100644
--- a/include/tst_pid.h
+++ b/include/tst_pid.h
@@ -50,4 +50,12 @@ static inline int tst_get_free_pids(void (*cleanup_fn)(void))
  */
 pid_t tst_getpid(void);
 
+/*
+ * Direct gettid() syscall. Some glibc versions cache gettid() return value
+ * which can cause confusing issues for example in processes created by
+ * direct clone() syscall (without using the glibc wrapper). Use this function
+ * whenever the current process may be a child of the main test process.
+ */
+pid_t tst_gettid(void);
+
 #endif /* TST_PID_H__ */
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index cfaa5db36..4e9dc7a52 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -166,3 +166,8 @@ pid_t tst_getpid(void)
 {
 	return syscall(SYS_getpid);
 }
+
+pid_t tst_gettid(void)
+{
+	return syscall(SYS_gettid);
+}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
