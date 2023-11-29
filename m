Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1078C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 11:55:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02E8B3CDAB7
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 12:55:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1823E3CD952
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E58F1A007AA
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 076621FCE7;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701258885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbGxSqoE2/Q+sSv+CfQEM8nsZWKbkA/2RZr0GPERNFw=;
 b=uCzvyFwM295rLmuKEhf27w34R/oo5FAs1jzqLNPfL64usfquCQzjnBs5KLyGWJE2Fc36Jr
 4++FIk3/f2gXBL6Y0nL8KnecP7Bix3mbvxsCl1LqchdVr9aWqaLM1OfNsXP38cFlC+x+Ob
 y388LIDv6w66/8hJ2Gu4kPyad3700L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701258885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbGxSqoE2/Q+sSv+CfQEM8nsZWKbkA/2RZr0GPERNFw=;
 b=7FA36UO1VCUsXHOIvRJQ5nMNiOIJ4YjaNDPO9X+OV9kxuUODTQ0v9C2VCrY3LnmhMAGLTP
 T56u2xPe6Jx91TBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE46F13B45;
 Wed, 29 Nov 2023 11:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id SwvjOYQmZ2VMfwAAn2gu4w
 (envelope-from <jack@suse.cz>); Wed, 29 Nov 2023 11:54:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A041DA07E3; Wed, 29 Nov 2023 12:54:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 12:54:30 +0100
Message-Id: <20231129115440.19100-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129114617.12660-1-jack@suse.cz>
References: <20231129114617.12660-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] fanotify: Provide fanotify_mark_supported_on_fs()
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Provide helper checking whether a mark is supported on a filesystem
since some marks need not be available on all filesystems (e.g. btrfs
subvolumes). Also convert REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL() and
its only user to use this new function.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 11 ++++++++---
 testcases/kernel/syscalls/fanotify/fanotify23.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index ee74c2fffbd5..f28da1a5ee55 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -226,6 +226,11 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
 	return fanotify_init_flags_supported_on_fs(flags, NULL);
 }
 
+static inline int fanotify_mark_supported_on_fs(uint64_t flag, const char *fname)
+{
+	return fanotify_flags_supported_on_fs(FAN_CLASS_CONTENT, flag, FAN_ACCESS, fname);
+}
+
 #define TST_FANOTIFY_INIT_KNOWN_FLAGS                                      \
 	(FAN_REPORT_DFID_NAME_TARGET | FAN_REPORT_TID | FAN_REPORT_PIDFD | \
 	FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | FAN_CLASS_PRE_CONTENT)
@@ -333,9 +338,9 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 	return 0;
 }
 
-#define REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type) \
+#define REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(mark_type, fname) \
 	fanotify_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
-		fanotify_mark_supported_by_kernel(mark_type))
+		fanotify_mark_supported_on_fs(mark_type, fname))
 
 #define REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(handle_type) \
 	fanotify_flags_err_msg(#handle_type, __FILE__, __LINE__, tst_brk_, \
@@ -343,7 +348,7 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 
 #define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
 	if (mark_type)							\
-		REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type);	\
+		REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(mark_type, fname);	\
 	if (init_flags)							\
 		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
 	fanotify_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index fb812c51e34e..5a03503e952a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -230,7 +230,7 @@ static void setup(void)
 {
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
-	REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(FAN_MARK_EVICTABLE);
+	REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_EVICTABLE, ".");
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
 						FAN_ATTRIB, ".");
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
