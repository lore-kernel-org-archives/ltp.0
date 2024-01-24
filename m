Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE078C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 12:21:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E2743CFA8C
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:21:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81BCB3C0362
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:21:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AD2F100288E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:21:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFBB61F7F0;
 Wed, 24 Jan 2024 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706098894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qYNXxfgt5p2om42vdkkOWPtRoLBYu5Am5ZJ6dMUmNRg=;
 b=avRnh0YrZdqdWGkFEIJI9XJvdjRlWDRt5V7VVfgXtqJOjhxEvLZXEpl1A1L4gicO0bPOuj
 0OhKDkxNh6HxQvtqbLCVRcxzgPOAjruwB4D6ue0AQkzjwvOWeOnToI7ZHR8PmDznNC+0YZ
 feAPJXhzipjfOyAyJcztHWx4XVjkWXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706098894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qYNXxfgt5p2om42vdkkOWPtRoLBYu5Am5ZJ6dMUmNRg=;
 b=hr6nT2aY8V4sEKXFLLvQxr6nkq6d7vYxCmK0YZzNKTwOylHsP1EZd3w3mn3OEseuN2LqqK
 7p1Zn03s6yk6YhBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706098893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qYNXxfgt5p2om42vdkkOWPtRoLBYu5Am5ZJ6dMUmNRg=;
 b=cydQN8zJs59N3gURBzrqzTEVQu1JDAm7Suaz2QAyQryTCjyVbFWtsQJcvGXE4Wk+Z8l94C
 fMBAZ962GTO/gkLQV1eH2Jahcv4FUjdmHJR7uTklFnsygTqwJei3eNZGKdIADJC4tiwLFn
 HUUrHsnhU/JtiRVDWSd6BJCS0+wSOfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706098893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qYNXxfgt5p2om42vdkkOWPtRoLBYu5Am5ZJ6dMUmNRg=;
 b=6nK9zItcr4gJmnNUGpBXalBgUW/9UtRiroxwnyXEXlV+YFd74hRh3+zMRkKDNqJ+3fCLwj
 43EesXA8gmfR0FBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93DB41333E;
 Wed, 24 Jan 2024 12:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rfhMIs0AsWVTMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 12:21:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jan 2024 13:21:30 +0100
Message-ID: <20240124122130.288374-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cydQN8zJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6nK9zItc
X-Spamd-Result: default: False [-1.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,gmail.com,suse.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFBB61F7F0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify: Handle EOPNOTSUPP as TCONF
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
Cc: Jan Kara <jack@suse.cz>, Dominique Leuenberger <dleuenberger@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Found on kernel 6.7 (Tumbleweed) on exfat:

tst_test.c:1669: TINFO: === Testing on exfat ===
tst_test.c:1117: TINFO: Formatting /dev/loop1 with exfat opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop1 to /tmp/LTP_fanoL9KLE/mntpoint fstyp=exfat flags=0
fanotify14.c:246: TINFO: Test case 0: fanotify_init(FAN_CLASS_CONTENT | FAN_REPORT_FID, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 1: fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 2: fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)
fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with INODE_EVENTS
fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 3: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY)
fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
fanotify14.c:283: TINFO: Testing FAN_MARK_MOUNT with INODE_EVENTS
fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 4: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 5: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 6: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
fanotify14.c:260: TPASS: fanotify_init(tc->init.flags, O_RDONLY) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, O_RDONLY)
fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with FAN_RENAME
fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : EINVAL (22)
fanotify14.c:246: TINFO: Test case 9: fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)
fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
fanotify14.c:283: TINFO: Testing FAN_MARK_ONLYDIR with FAN_OPEN
fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : ENOTDIR (20)
fanotify14.c:298: TPASS: Adding an inode mark on directory did not fail with ENOTDIR error as on non-dir inode
fanotify14.c:246: TINFO: Test case 10: fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_DFID_NAME_TARGET, O_RDONLY)
fanotify14.c:263: TPASS: fanotify_init(tc->init.flags, O_RDONLY) returned fd 5
fanotify14.c:283: TINFO: Testing FAN_MARK_INODE with FAN_DELETE
fanotify14.c:285: TPASS: fanotify_mark(fanotify_fd, 0x00000001 | tc->mark.flags, tc->mask.flags, dirfd, path) : ENOTDIR (20)
fanotify14.c:298: TPASS: Adding an inode mark on directory did not fail with ENOTDIR error as on non-dir inode
fanotify14.c:303: TBROK: fanotify_mark(5, 0x101, 0x200, ..., mntpoint/file1) unsupported: EOPNOTSUPP (95)

Reported-by: Dominique Leuenberger <dleuenberger@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I wonder, if this is a bug or not.

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index e0d178bcc..dd1f5c84c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -47,9 +47,15 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
 
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) failed",
-			 fd, flags, mask, pathname);
+		if (errno == EOPNOTSUPP) {
+			tst_brk_(file, lineno, TCONF | TERRNO,
+					 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) unsupported",
+					 fd, flags, mask, pathname);
+		} else {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+					 "fanotify_mark(%d, 0x%x, 0x%lx, ..., %s) failed",
+					 fd, flags, mask, pathname);
+		}
 	}
 
 	if (rval < -1) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
