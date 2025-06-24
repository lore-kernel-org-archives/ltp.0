Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86667C77B7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 15:20:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511A63CCABE
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 17:20:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3F863CCAB6
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E54B01000D86
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8EB211F444
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqx/Ay4Vgsm8hVNk7yQA2l9KlyxMv6Ad/LzRY1iHYHk=;
 b=VMkmLOVFckwpZKJFqMU14kuq0JmrP2UZ6OO3rDfBy0Ro0GpPrQSGEgKsWJGotc+vt2f7Sv
 FB6iVxGtXQNFZmZjBdI8nB9Y6ydZNC22LkxVahJlUz8hmDT1B5FR8ADpJjIuzz21zurKEm
 F1/4n9wee1xRyGPBBQuOTz42RdRJqpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqx/Ay4Vgsm8hVNk7yQA2l9KlyxMv6Ad/LzRY1iHYHk=;
 b=k+VYjEolQpMm3VjKxqDLybHJr2T9jr7so1JqFVBul02nmdrk0KMekN5YwKTqWi/im3Qeq8
 UubHMfIIWkxgsMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqx/Ay4Vgsm8hVNk7yQA2l9KlyxMv6Ad/LzRY1iHYHk=;
 b=DT5tdqNKM21p3aMJFHrU00k9ZExCfRzkSCZ9vbdzdT4CjnS+YP1C0fIQM+RWBvzgyG39ZP
 Yp2URcF808XFcWlM2O7GbShM6hFl+TMbNPjxeUzIEEJk0qu2d9nkRgkB6zikN8MQV4FN72
 Akfy1Q50UUQgqAm6yhnhZo8VQxWPov8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqx/Ay4Vgsm8hVNk7yQA2l9KlyxMv6Ad/LzRY1iHYHk=;
 b=WtOBCbfL7KQaUrWCK+YQK+jqNkajrbhpmuQCgBle1SsVDUxJ+V5KG4DPi8qDffjNELOhFQ
 QaMvvNWBTaLLg1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72A3513A9C
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eGwZG/nBWmh7DAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Jun 2025 17:19:16 +0200
Message-ID: <20250624151918.32145-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624151918.32145-1-mdoucha@suse.cz>
References: <20250624151918.32145-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] open13: Verify that dup() will preserve O_PATH
 flag
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

Verify that calling dup() on a file descriptor opened with O_PATH
will return another file descriptor that is not usable for standard
I/O operations.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/open/open13.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index e30e99ec3..0ac501913 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -31,7 +31,7 @@
 
 #define TESTFILE	"testfile"
 
-static int path_fd = -1;
+static int path_fd = -1, dup_fd = -1;
 
 static int verify_read(int fd);
 static int verify_write(int fd);
@@ -64,6 +64,7 @@ static void setup(void)
 	path_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
 	SAFE_CLOSE(path_fd);
 	path_fd = SAFE_OPEN(TESTFILE, O_PATH);
+	dup_fd = SAFE_DUP(path_fd);
 }
 
 static void run(void)
@@ -71,8 +72,10 @@ static void run(void)
 	int i;
 
 	for (i = 0; testcases[i].func; i++) {
-		TST_EXP_FAIL(testcases[i].func(path_fd), EBADF, "%s()",
-			testcases[i].name);
+		TST_EXP_FAIL(testcases[i].func(path_fd), EBADF,
+			"%s() on original FD", testcases[i].name);
+		TST_EXP_FAIL(testcases[i].func(dup_fd), EBADF,
+			"%s() on duplicated FD", testcases[i].name);
 	}
 }
 
@@ -129,6 +132,9 @@ static void cleanup(void)
 {
 	if (path_fd >= 0)
 		SAFE_CLOSE(path_fd);
+
+	if (dup_fd >= 0)
+		SAFE_CLOSE(dup_fd);
 }
 
 static struct tst_test test = {
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
