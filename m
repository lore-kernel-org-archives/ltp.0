Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2EAC07548
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 13:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3FF03CE485
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 14:03:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E610B3C62ED
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 14:03:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 67A0B609698
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 14:03:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3AC9204D9;
 Wed, 15 Nov 2023 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700053421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LlPq5tsE0zc0xFwjLeH33R+3ZWKqzx7CSE6i7nuxdyU=;
 b=elSUNCYvm0EfceFMkL07zhr3uJYlX3FYnx29tyFp/Ud7yfpOnuz2EsWhegbWDkAW01Od0h
 ZIPzUwPV3gMr6rAwbrtGwu/+h5mEUHTqb3t2y89STeoA9HGHkY7e1i0l/cla9Mx28oU6mD
 IyEg+3UmEjf9HjB5D+Ppg+nk9ht60fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700053421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LlPq5tsE0zc0xFwjLeH33R+3ZWKqzx7CSE6i7nuxdyU=;
 b=R9NnvB9nFHKYzyJub+Jlw0pBhY9g4R3WYOocpxo62vN13rVIIvcHaxcFG0soU+Fgs9xeko
 gqAgvs9LDSD3tHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8811A13587;
 Wed, 15 Nov 2023 13:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DBunH63BVGXiLAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 Nov 2023 13:03:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 Nov 2023 14:03:40 +0100
Message-Id: <20231115130340.14228-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.20 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.10)[95.66%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix off-by-one error in pidns05
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

Since we count nested processes from zero, we need to check that nested
level value is not bigger than MAX_DEPTH - 1. This patch also remove
shared pointer which counts number of levels and replace it with a
regular scalar value.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/pidns/pidns05.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index 0e7739aaa..7843fe7a9 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -24,7 +24,7 @@ static struct tst_clone_args clone_args = {
 };
 static pid_t pid_max;
 
-static void child_func(int *level)
+static void child_func(const int level)
 {
 	pid_t cpid, ppid;
 
@@ -34,15 +34,13 @@ static void child_func(int *level)
 	TST_EXP_EQ_LI(cpid, 1);
 	TST_EXP_EQ_LI(ppid, 0);
 
-	if (*level >= MAX_DEPTH) {
+	if (level >= MAX_DEPTH - 1) {
 		TST_CHECKPOINT_WAKE(0);
 		return;
 	}
 
-	(*level)++;
-
 	if (!SAFE_CLONE(&clone_args)) {
-		child_func(level);
+		child_func(level + 1);
 		return;
 	}
 
@@ -81,14 +79,13 @@ static void setup(void)
 static void run(void)
 {
 	int i, status, children;
-	int level = 0;
 	pid_t pids_new[MAX_DEPTH];
 	pid_t pids[MAX_DEPTH];
 	pid_t pid;
 
 	pid = SAFE_CLONE(&clone_args);
 	if (!pid) {
-		child_func(&level);
+		child_func(0);
 		return;
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
