Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC37C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C62713CD9D8
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:38:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252763CD5EF
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B4ED4603445
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D290F1FCDA;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C338613B49;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id NxdXL8dXaGVXKAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:37:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 57D91A07EA; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 10:37:06 +0100
Message-Id: <20231130093711.20171-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231130093533.10036-1-jack@suse.cz>
References: <20231130093533.10036-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: D290F1FCDA
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] fanotify: Provide
 fanotify_mark_supported_on_fs()
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
index 3b8838e8dd68..597ed96e0313 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -229,6 +229,11 @@ static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
 	return fanotify_init_flags_supported_on_fs(flags, NULL);
 }
 
+static inline int fanotify_mark_supported_on_fs(uint64_t flag, const char *fname)
+{
+	return fanotify_flags_supported_on_fs(FAN_CLASS_NOTIF, flag, FAN_ACCESS, fname);
+}
+
 #define TST_FANOTIFY_INIT_KNOWN_FLAGS                                      \
 	(FAN_REPORT_DFID_NAME_TARGET | FAN_REPORT_TID | FAN_REPORT_PIDFD | \
 	FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | FAN_CLASS_PRE_CONTENT)
@@ -336,9 +341,9 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 	return 0;
 }
 
-#define REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type) \
+#define REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(mark_type, fname) \
 	fanotify_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
-		fanotify_mark_supported_by_kernel(mark_type))
+		fanotify_mark_supported_on_fs(mark_type, fname))
 
 #define REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(handle_type) \
 	fanotify_flags_err_msg(#handle_type, __FILE__, __LINE__, tst_brk_, \
@@ -346,7 +351,7 @@ static inline int fanotify_handle_supported_by_kernel(int flag)
 
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
