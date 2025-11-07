Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADBECCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:32:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92C313CEF7D
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:32:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B17483CEF60
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:30:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F041600F0A
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:30:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62FE1211F4;
 Fri,  7 Nov 2025 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHRFq6+yWvdHPTpdKrcMT075Z9ae80qv27EAtA5J6f0=;
 b=Kf5+kW+LHsUGOXtKDe9OqadTmLdro6MnRUF1gd8ZnIOmxxhLmVyq+hBSk/u+sRtsysQ2vC
 TDz7Blm8EzRfiDV5F/rNN7y8M6diZistgzKSoo7E7Kd9XEiy770SrOv+GHQr/k0EvKoHg+
 bB6OP6BmzCyWc7zQ9ispBJnPlowJCSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHRFq6+yWvdHPTpdKrcMT075Z9ae80qv27EAtA5J6f0=;
 b=zvgINtJ/xUSyf2Dgm9lhaOyPKNlgrrWwSTqcOnw5PdhgAkcZ01NqmP0Q7jBQ/gi6NG8n3q
 jfzXIziSGIIVN6BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHRFq6+yWvdHPTpdKrcMT075Z9ae80qv27EAtA5J6f0=;
 b=Kf5+kW+LHsUGOXtKDe9OqadTmLdro6MnRUF1gd8ZnIOmxxhLmVyq+hBSk/u+sRtsysQ2vC
 TDz7Blm8EzRfiDV5F/rNN7y8M6diZistgzKSoo7E7Kd9XEiy770SrOv+GHQr/k0EvKoHg+
 bB6OP6BmzCyWc7zQ9ispBJnPlowJCSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHRFq6+yWvdHPTpdKrcMT075Z9ae80qv27EAtA5J6f0=;
 b=zvgINtJ/xUSyf2Dgm9lhaOyPKNlgrrWwSTqcOnw5PdhgAkcZ01NqmP0Q7jBQ/gi6NG8n3q
 jfzXIziSGIIVN6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37273132DD;
 Fri,  7 Nov 2025 10:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GCTzBxnKDWlKQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:29:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 11:29:39 +0100
Message-ID: <20251107102939.1111074-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102939.1111074-1-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/8] tst_test.c: Change fork_testrun() return type to
 void
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

Return code is not used any more.

Fixes: a1f82704c2 ("lib/tst_test.c: Fix tst_brk() handling")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8098b3a010..e115ce689d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1880,7 +1880,7 @@ void tst_set_runtime(int runtime)
 	heartbeat();
 }
 
-static int fork_testrun(void)
+static void fork_testrun(void)
 {
 	int status;
 
@@ -1911,8 +1911,8 @@ static int fork_testrun(void)
 	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
 	if (tst_test->taint_check && tst_taint_check()) {
-		tst_res(TFAIL, "Kernel is now tainted.");
-		return TFAIL;
+		tst_res(TFAIL, "Kernel is now tainted");
+		return;
 	}
 
 	if (tst_test->forks_child && kill(-test_pid, SIGKILL) == 0)
@@ -1922,7 +1922,7 @@ static int fork_testrun(void)
 		tst_brk(TBROK, "Child returned with %i", WEXITSTATUS(status));
 
 	if (context->abort_flag)
-		return 0;
+		return;
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "
@@ -1932,8 +1932,6 @@ static int fork_testrun(void)
 
 	if (WIFSIGNALED(status))
 		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
-
-	return 0;
 }
 
 static struct tst_fs *lookup_fs_desc(const char *fs_type, int all_filesystems)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
