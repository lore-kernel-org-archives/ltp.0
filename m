Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265B4C54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 21:24:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34C1D3D0CA9
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 22:24:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 287E93CC7C6
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:24:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A3551A00A20
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:24:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B127D339AB;
 Tue,  5 Mar 2024 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709673850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7YE9Y4C3IuWnj7HqAW7U5gyHYLGq/FxGqEp2S68mNE=;
 b=iWIvTm7AoKlWwVyoelBKgXCNKT98VTuOyiN11l0fv9esMtTBwdDJFLlTWQeRGj+U4PDFOy
 LRavWuc4oDB50o/vxLXETnCZ5EJ6Jq0ZiWcrwHNZ+kQua7f1+gMbx+nlJfP1QmrJ+u24yB
 MzoaMpIHPR0sJtpKI7qg2m27sCgQwI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709673850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7YE9Y4C3IuWnj7HqAW7U5gyHYLGq/FxGqEp2S68mNE=;
 b=dI523G9MmI5SVAFfliDcPtzET25yR+UdeesiVGxIAk2A9J3LQ0FTwz9YmLgl7G7WpzHHfH
 axjmlIptssSYc8DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709673850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7YE9Y4C3IuWnj7HqAW7U5gyHYLGq/FxGqEp2S68mNE=;
 b=iWIvTm7AoKlWwVyoelBKgXCNKT98VTuOyiN11l0fv9esMtTBwdDJFLlTWQeRGj+U4PDFOy
 LRavWuc4oDB50o/vxLXETnCZ5EJ6Jq0ZiWcrwHNZ+kQua7f1+gMbx+nlJfP1QmrJ+u24yB
 MzoaMpIHPR0sJtpKI7qg2m27sCgQwI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709673850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7YE9Y4C3IuWnj7HqAW7U5gyHYLGq/FxGqEp2S68mNE=;
 b=dI523G9MmI5SVAFfliDcPtzET25yR+UdeesiVGxIAk2A9J3LQ0FTwz9YmLgl7G7WpzHHfH
 axjmlIptssSYc8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A58D813A5B;
 Tue,  5 Mar 2024 21:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8olGKHqN52UHTAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 05 Mar 2024 21:24:10 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Mar 2024 22:24:07 +0100
Message-ID: <20240305212410.18978-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
References: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.68 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[53.86%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getxattr04,
 05: Change to docparse comment and typo fixes
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/getxattr/getxattr04.c |  6 ++++--
 testcases/kernel/syscalls/getxattr/getxattr05.c | 14 ++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index e64f2a1f1..451e04d90 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -4,13 +4,15 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * This is a regression test for the race between getting an existing
  * xattr and setting/removing a large xattr.  This bug leads to that
  * getxattr() fails to get an existing xattr and returns ENOATTR in xfs
  * filesystem.
  *
- * Thie bug has been fixed in:
+ * This bug has been fixed in:
  *
  * commit 5a93790d4e2df73e30c965ec6e49be82fc3ccfce
  * Author: Brian Foster <bfoster@redhat.com>
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index f12e2f813..069e2b3f9 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -4,12 +4,14 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
- * 1) Witout a user namespace, getxattr(2) should get same data when
- *    acquiring the value of system.posix_acl_access twice.
- * 2) With/Without mapped root UID in a user namespaces, getxattr(2) should
- *    get same data when acquiring the value of system.posix_acl_access twice.
+/*\
+ * [Description]
+ *
+ * This test verifies that:
+ * - Without a user namespace, getxattr(2) should get same data when
+ *   acquiring the value of system.posix_acl_access twice.
+ * - With/Without mapped root UID in a user namespaces, getxattr(2) should
+ *   get same data when acquiring the value of system.posix_acl_access twice.
  *
  * This issue included by getxattr05 has been fixed in kernel:
  * '82c9a927bc5d ("getxattr: use correct xattr length")'
-- 
2.43.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
