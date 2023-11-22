Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F3EC61D9B
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 14:50:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5675F3CE0C3
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 15:50:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176DA3CE086
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D7AC208DED
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D61D2186F;
 Wed, 22 Nov 2023 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700664587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfNqtpkSJnP58+bK3cKbASWlDFa4dC95De+gPa1kUKA=;
 b=WgKHcMuSWO8CApWBu/OVowYhw30SSBsi2Po1tcx+wOThAQmhvFRO6efVRgNaq9CffZ0gA9
 hJ1MT1HIE4t03UrVk6/p+SnPeGkheyddqLlIox3ZHGXDwYd+j1stQyJPNgMaUGqXz2P9F8
 ctk12nOm9fAGmyFTV6yyJ75RFNIGckk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700664587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfNqtpkSJnP58+bK3cKbASWlDFa4dC95De+gPa1kUKA=;
 b=hcCH47hQJf9+a0TDWy2JT2bD+imSNtIFfNJE4dXXmbzaec0YvmdXKwJkOeZyCAr2wfkCWO
 pEgJQ6pNiMJwtODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B7CC139FD;
 Wed, 22 Nov 2023 14:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sInpBAsVXmWiEgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Nov 2023 14:49:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Nov 2023 15:49:43 +0100
Message-Id: <20231122144944.23993-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231122144944.23993-1-andrea.cervesato@suse.de>
References: <20231122144944.23993-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.10)[64.96%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] Add tst_gettid wrapper around gettid syscall
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
index 774c845ce..951138abc 100644
--- a/include/tst_pid.h
+++ b/include/tst_pid.h
@@ -50,4 +50,12 @@ static inline int tst_get_free_pids(void (*cleanup_fn)(void))
  */
 pid_t tst_getpid(void);
 
+/*
+ * Direct gettid() syscall. Some glibc versions cache gettid() return value
+ * which can cause confusing issues for example in processes created by
+ * direct clone() syscall (without using the glibc wrapper). Use this function
+ * whenever the current process may be a thread of the main test process.
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
