Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CACDC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46EEE3CD937
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:37:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B8F03C8960
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4C96207CD4
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D94471FCDC;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C41A113B4A;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id FxemL8dXaGVYKAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:37:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 50F33A07E6; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 10:37:05 +0100
Message-Id: <20231130093711.20171-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231130093533.10036-1-jack@suse.cz>
References: <20231130093533.10036-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: D94471FCDC
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] fanotify: Print more details on error from
 fanotify_flags_supported_on_fs()
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

Print more details about failing calls from
fanotify_flags_supported_on_fs().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index f34440e0bd41..3b8838e8dd68 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -195,7 +195,9 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
 		if (errno == ENOSYS)
 			tst_brk(TCONF, "fanotify not configured in kernel");
 		if (errno != EINVAL)
-			tst_brk(TBROK | TERRNO, "fanotify_init() failed");
+			tst_brk(TBROK | TERRNO,
+				"fanotify_init(%x, O_RDONLY) failed",
+				init_flags);
 		return -1;
 	}
 
@@ -204,8 +206,9 @@ static inline int fanotify_flags_supported_on_fs(unsigned int init_flags,
 			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
 		} else if (errno != EINVAL) {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, %s) failed",
-				fd, fname);
+				"fanotify_mark (%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, %s) failed",
+				fd, mark_flags, (unsigned long long)event_flags,
+				fname);
 		} else {
 			rval = -1;
 		}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
