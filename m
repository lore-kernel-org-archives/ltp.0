Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2448EC142A
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 10:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE603DA362
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 11:55:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4CC43C7831
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:55:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 259F5200929
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:55:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6532A3F90D;
 Tue,  3 Mar 2026 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772535311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nqLMVxOquFFfjHW4MN1jG6VSr9pjxg8HjtxxQNf3AuU=;
 b=3P/7z/MbkWPsmW6UjhCx1xuSbAYUjWojnunYlOQxTAG3dR2psSNNbHIcq1Cthij6/jdsi9
 O34oj55nlVhhQJ9H27KZfkQX4DbMaTZ/n7RwlcyC1TkqaC5VxngtC3jwJrx2dbrS6K+NkK
 f1z4KiVFbqeLXToD2nseSgFrKK/6Dq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772535311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nqLMVxOquFFfjHW4MN1jG6VSr9pjxg8HjtxxQNf3AuU=;
 b=7oqHyMeVz0ELqAs5jKT0QW4Jr1hKydqT1ai+Zq7Mx24R8AW8Ib3PstZVI9a/mRZ9DsjrKN
 0BC8tfRK/mcW6xDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772535311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nqLMVxOquFFfjHW4MN1jG6VSr9pjxg8HjtxxQNf3AuU=;
 b=3P/7z/MbkWPsmW6UjhCx1xuSbAYUjWojnunYlOQxTAG3dR2psSNNbHIcq1Cthij6/jdsi9
 O34oj55nlVhhQJ9H27KZfkQX4DbMaTZ/n7RwlcyC1TkqaC5VxngtC3jwJrx2dbrS6K+NkK
 f1z4KiVFbqeLXToD2nseSgFrKK/6Dq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772535311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nqLMVxOquFFfjHW4MN1jG6VSr9pjxg8HjtxxQNf3AuU=;
 b=7oqHyMeVz0ELqAs5jKT0QW4Jr1hKydqT1ai+Zq7Mx24R8AW8Ib3PstZVI9a/mRZ9DsjrKN
 0BC8tfRK/mcW6xDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B8743EA6C;
 Tue,  3 Mar 2026 10:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 73AmFg++pmllKwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 03 Mar 2026 10:55:11 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Mar 2026 11:55:09 +0100
Message-ID: <20260303105510.14305-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_CC(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify25: Trace oom_kill_process() instead of
 load_module()
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
Cc: Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The load_module() function is available only if the kernel was built
with CONFIG_MODULES enabled. Trace a function that's unconditionally
available instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reported-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify25.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
index c982f3225..db52e6a87 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify25.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
@@ -24,10 +24,10 @@ static const struct traceconfig {
 	const char *filename;
 	const char *wdata;
 } trace_cmds[] = {
-	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
-	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
-	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
-	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
+	{EVENTS_SYSFILE, "p:ltp_oom_kill_process_0 oom_kill_process"},
+	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "1"},
+	{MNTPOINT "/events/kprobes/ltp_oom_kill_process_0/enable", "0"},
+	{EVENTS_SYSFILE, "-:ltp_oom_kill_process_0"},
 	{}
 };
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
