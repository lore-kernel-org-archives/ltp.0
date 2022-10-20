Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40FAC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCDAA3CB19F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:08:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E8F13CAFB4
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1348B601392
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B3DF225A3;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666271324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDypSQedbS8aWtiA2vxzr1cfMlMxgijsogZWd/77lm0=;
 b=vi+dgfO4mPxaN2MO+OzMwWB85toH0EYbWIoXOfuryqYjHfZqE8s6i/UQBSYXqwze4dgZdW
 wYYMaEX3IE8jQ/He5lq8JwjepLUXLdZ9uYWc6V3fU7vWLvvwXoUr4rZD/WEeU10fOflDzN
 rKdWLESUi1R1CPPorVFgsjx5dgLtwEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666271324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDypSQedbS8aWtiA2vxzr1cfMlMxgijsogZWd/77lm0=;
 b=L51ioMKwfbbJK+OX4ov37enixou5NspG+Vu6vnC8uB9BYZc9Mk34sTHIP9zugL6kadPq6H
 VhC2Y+nkgGFMhdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6E313AF5;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oCI0HVxIUWNLOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Oct 2022 13:08:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 20 Oct 2022 15:08:42 +0200
Message-Id: <20221020130843.15147-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020130843.15147-1-mdoucha@suse.cz>
References: <20221020130843.15147-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags() helper
 function
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

Since FAN_ALL_INIT_FLAGS constant is deprecated, the kernel has added
new fanotify feature flags and there is no other way to check
for their support, we need to manually check which init flags needed
by our tests are available.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Fixed check for FAN_REPORT_NAME
- Added longer patch description

Thanks for pointing out the flag dependency between FAN_REPORT_NAME and
FAN_REPORT_DIR_FID. I must have misread the documentation on that one.
Since this appears to be the only flag with a dependency for now, let's
keep the special handling simple. If the kernel adds more flags that are
invalid on their own, we should handle that using a table.

These flag support checks will be needed in multiple tests so it's better
to have one common function that'll do them in one call than to copy-paste
multiple setup steps from one test to another.

Though it'd be great if kernel itself would provide a syscall that returns
all supported fanotify init, mark or mask flags in one call.

 testcases/kernel/syscalls/fanotify/fanotify.h | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 51078103e..f3ac1630f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -213,6 +213,32 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
 	return fanotify_init_flags_supported_on_fs(flags, NULL);
 }
 
+/*
+ * Check support of given init flags one by one and return those which are
+ * supported.
+ */
+static inline unsigned int fanotify_get_supported_init_flags(unsigned int flags,
+	const char *fname)
+{
+	unsigned int flg, arg, ret = 0;
+
+	for (flg = 1; flg; flg <<= 1) {
+		if (!(flags & flg))
+			continue;
+
+		arg = flg;
+
+		// FAN_REPORT_NAME is invalid without FAN_REPORT_DIR_FID
+		if (flg == FAN_REPORT_NAME)
+			arg |= FAN_REPORT_DIR_FID;
+
+		if (!fanotify_init_flags_supported_on_fs(arg, fname))
+			ret |= flg;
+	}
+
+	return ret;
+}
+
 typedef void (*tst_res_func_t)(const char *file, const int lineno,
 			       int ttype, const char *fmt, ...);
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
