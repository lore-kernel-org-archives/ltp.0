Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B09C07CB1
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 15:40:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46CEF3CDC2B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 16:40:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766763CDB56
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 16:40:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63A51100061D
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 16:40:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 489A421B54;
 Mon, 27 Nov 2023 15:40:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 399AD13440;
 Mon, 27 Nov 2023 15:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kP0KDmi4ZGWPVQAAn2gu4w
 (envelope-from <jack@suse.cz>); Mon, 27 Nov 2023 15:40:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A789BA07CB; Mon, 27 Nov 2023 16:40:23 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 Nov 2023 16:40:13 +0100
Message-Id: <20231127154013.2625-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [12.89 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_COUNT_THREE(0.00)[3];
 DMARC_NA(1.20)[suse.cz]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 489A421B54
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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
Cc: Jan Kara <jack@suse.cz>, pvorel@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When LTP test is run with CWD in btrfs subvolume, tests like fanotify16
fail with:

fanotify.h:169: TBROK: fanotify_mark (3, FAN_MARK_ADD, ..., AT_FDCWD, ".") failed: EXDEV (18)

This is because fanotify_events_supported_by_kernel() try to place a
mark onto CWD and that is forbidden for btrfs subvolumes. Change
fanotify_events_supported_by_kernel() to use "/" instead of "." which
has higher chances of working for btrfs.

Also update the error message to provide a bit more info.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 32b510cdc178..f2fe0c05b449 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -161,12 +161,13 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,
 
 	fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
 
-	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
+	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, "/") < 0) {
 		if (errno == EINVAL) {
 			rval = -1;
 		} else {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, \".\") failed", fd);
+				"fanotify_mark (%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, \".\") failed",
+				fd, mark_flags, (unsigned long long)mask);
 		}
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
