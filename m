Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C476FCDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 15:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E0873CF531
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 17:08:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78B433CD0FD
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7311D603110
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AAD41F854;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697814470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZtQmEQ+Pb4xdj53XoMnqXgkoOmZ0qMMuQJjQgjpzqg=;
 b=ze8ojVP3/2FZuyhrXzaHIMNlOeLEBxuMcO2qE8wZOUFEPhyMR3xszPWWhdbBP93dmF/GN0
 ZWyObWGhO307j5sh+nhKqia/LWaDPl2UWKkZ8uPyqo4Pky8qVAG3WO+1gND3VbWz/QUZ8z
 r3isQhQA3198oD3VZ4VKRFnMjxpm0rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697814470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZtQmEQ+Pb4xdj53XoMnqXgkoOmZ0qMMuQJjQgjpzqg=;
 b=hCJDdy2iEnyEcZdqwCJPeJ79RYmIMy0DKq6fYJQrEjh4j7McG7aAnhD84XKHeOlW7zpPRs
 YiwlL8qL31cgDeBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44646139C2;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +N7/D8aXMmW6WgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Oct 2023 15:07:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Date: Fri, 20 Oct 2023 17:06:02 +0200
Message-ID: <20231020150749.21165-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020150749.21165-1-mdoucha@suse.cz>
References: <20231020150749.21165-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FREEMAIL_TO(0.00)[gmail.com,suse.cz,lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add fanotify_get_supported_init_flags() helper
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

Changes since v2:
- Added a table of flag dependencies so that each individual flag is tested
  together with all additional required flags

The helper function also checks that it wasn't called with a new uknown
flag which might require dependency table update. In that case, the test
will fail and advise the developer to review documentation and update
the dependency table.

 testcases/kernel/syscalls/fanotify/fanotify.h | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 75a081dc9..78424a350 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -217,6 +217,49 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
 	return fanotify_init_flags_supported_on_fs(flags, NULL);
 }
 
+#define TST_FANOTIFY_INIT_KNOWN_FLAGS                                      \
+	(FAN_REPORT_DFID_NAME_TARGET | FAN_REPORT_TID | FAN_REPORT_PIDFD | \
+	FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | FAN_CLASS_PRE_CONTENT)
+
+/*
+ * Check support of given init flags one by one and return those which are
+ * supported.
+ */
+static inline unsigned int fanotify_get_supported_init_flags(unsigned int flags,
+	const char *fname)
+{
+	unsigned int i, flg, arg, ret = 0;
+	static const struct { unsigned int flag, deps; } deplist[] = {
+		{FAN_REPORT_NAME, FAN_REPORT_DIR_FID},
+		{FAN_REPORT_TARGET_FID, FAN_REPORT_DFID_NAME_FID},
+		{0, 0}
+	};
+
+	if (flags & ~TST_FANOTIFY_INIT_KNOWN_FLAGS) {
+		tst_brk(TBROK, "fanotify_init() feature check called with unknown flags %x, please update flag dependency table if needed",
+			flags & ~TST_FANOTIFY_INIT_KNOWN_FLAGS);
+	}
+
+	for (flg = 1; flg; flg <<= 1) {
+		if (!(flags & flg))
+			continue;
+
+		arg = flg;
+
+		for (i = 0; deplist[i].flag; i++) {
+			if (deplist[i].flag == flg) {
+				arg |= deplist[i].deps;
+				break;
+			}
+		}
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
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
