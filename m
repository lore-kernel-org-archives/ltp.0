Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E443C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 06:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3014D3CE65A
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:32:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 947073CB5E1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:32:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B23FA6096AF
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:32:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBAA9208D5;
 Wed, 20 Mar 2024 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710916358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG5Xi2Y5Mqoik0XBv/wLh+0J7g5z+iZYwOctVIVLP8Q=;
 b=KGT4akKV3eTI3rd2MfWvOqWrijNZfe1RhdDTH+ctEnPfhfz7BJW6r+I4rpqb2x4EzJ+V3S
 E4Jf+6bjontwooOtTvp/Es2PIlIC3No+uSI+YCVBYwRdkp18fBKFjy/rXX0XjG5h9jraSB
 EIQgYJqwnIRXX/MZA40Ii505XXR49h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710916358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG5Xi2Y5Mqoik0XBv/wLh+0J7g5z+iZYwOctVIVLP8Q=;
 b=oBgnF/DySV2UWdbRrg5zq93m33y10eCf/5m8GPPYU+rZeskPxUmJdYWi1kn8Gj/LYSY1Er
 wa1C2RvFeVizKCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710916357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG5Xi2Y5Mqoik0XBv/wLh+0J7g5z+iZYwOctVIVLP8Q=;
 b=VUATbEj2TGgEG6i/jVUydq5IY7mQWLrnyZAxnu06F65VB4eux2wjyMhtkrNLjixQOIlkjk
 LMzUf3NpoPdrNYLAl9M2iNG394YkdjqrMG0Ek2m7gDEutCBhs9jqGE/MSA/rQxQkabrqLA
 g9qTTtRiFp2LfHhpZkW53glmbAUf88E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710916357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG5Xi2Y5Mqoik0XBv/wLh+0J7g5z+iZYwOctVIVLP8Q=;
 b=HVoJz3Axfp2etcdMYCVs5WL9QAAJSAMtHIcj5iMyw8zb4Uj5jSRkKBwxRV4SWOutjSkM7F
 l9yIIdVO4nqsiyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC7EB13808;
 Wed, 20 Mar 2024 06:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WKgTLQWD+mU+GwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 06:32:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 07:32:17 +0100
Message-ID: <20240320063218.449072-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320063218.449072-1-pvorel@suse.cz>
References: <20240320063218.449072-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VUATbEj2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HVoJz3Ax
X-Spamd-Result: default: False [1.34 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_CC(0.00)[linux.ibm.com,suse.cz,redhat.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.15)[95.90%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EBAA9208D5
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Mete Durlu <meted@linux.ibm.com>

When SElinux is in enforcing state and SEpolicies disallow anonymous
pipe usage with fanotify_mark(), related fanotify14 testcases fail with
EACCES instead of EINVAL. Accept both errnos when SElinux is in
enforcing state to correctly evaluate test results.

Replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL when testing
fanotify_mark() as it returns -1 on failure and 0 on success not a file
descriptor.

Co-developed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is a replacement of Mete's v2 fanotify14: fix anonymous pipe testcases:
https://lore.kernel.org/ltp/20240312120829.178305-2-meted@linux.ibm.com/

Kind regards,
Petr

 .../kernel/syscalls/fanotify/fanotify14.c     | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d02d81495..b554af22a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -30,6 +30,7 @@
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
+#include "tst_selinux.h"
 
 #define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
@@ -47,6 +48,7 @@ static int pipes[2] = {-1, -1};
 static int fanotify_fd;
 static int ignore_mark_unsupported;
 static int filesystem_mark_unsupported;
+static int se_enforcing;
 static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
@@ -283,9 +285,18 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Testing %s with %s",
 		tc->mark.desc, tc->mask.desc);
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
-					 tc->mask.flags, dirfd, path),
-					 tc->expected_errno);
+
+	if (tc->pfd && se_enforcing) {
+		const int exp_errs[] = {tc->expected_errno, EACCES};
+
+		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+				 tc->mask.flags, dirfd, path),
+				 exp_errs);
+	} else {
+		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+						 tc->mask.flags, dirfd, path),
+						 tc->expected_errno);
+	}
 
 	/*
 	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
@@ -334,6 +345,8 @@ static void do_setup(void)
 	SAFE_FILE_PRINTF(FILE1, "0");
 	/* Create anonymous pipes to place marks on */
 	SAFE_PIPE2(pipes, O_CLOEXEC);
+
+	se_enforcing = tst_selinux_enforcing();
 }
 
 static void do_cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
