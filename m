Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29681E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 06:52:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 439DA3C1E15
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 07:52:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE8673C1C38
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:51:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B15706158FA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:51:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9E701F385;
 Thu,  9 Jan 2025 06:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736405500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EGQBTAexAEG8avz7LnZUCxuKij4bk1+kGhXUrJwCq4I=;
 b=dUdxQTwLJuH66Oc14wjizY7fzkGgFVXEzwlPnPzMVP56ibTFJZ7pctI6VR5gQ2bQZ3J7Fe
 k8oBA2pBpMw1i3kUxktsT1Ip5wcgJb+3Wf2NS/3qOcHeJiFKubobGuqgG34LTzWSFife3E
 bl1grtGuTwGR3LvL6PAKfxW8OvsiTaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736405500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EGQBTAexAEG8avz7LnZUCxuKij4bk1+kGhXUrJwCq4I=;
 b=L6TZnrNC7MrKKJSlvmFSt2pcZJ8XwHOpv/F+0MjEzEIwvQFqzvntcw5wWEpJzeGKKn4Bpg
 IPivtwgb5tTRtPAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dUdxQTwL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L6TZnrNC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736405500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EGQBTAexAEG8avz7LnZUCxuKij4bk1+kGhXUrJwCq4I=;
 b=dUdxQTwLJuH66Oc14wjizY7fzkGgFVXEzwlPnPzMVP56ibTFJZ7pctI6VR5gQ2bQZ3J7Fe
 k8oBA2pBpMw1i3kUxktsT1Ip5wcgJb+3Wf2NS/3qOcHeJiFKubobGuqgG34LTzWSFife3E
 bl1grtGuTwGR3LvL6PAKfxW8OvsiTaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736405500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EGQBTAexAEG8avz7LnZUCxuKij4bk1+kGhXUrJwCq4I=;
 b=L6TZnrNC7MrKKJSlvmFSt2pcZJ8XwHOpv/F+0MjEzEIwvQFqzvntcw5wWEpJzeGKKn4Bpg
 IPivtwgb5tTRtPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B29E139AB;
 Thu,  9 Jan 2025 06:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pxJLHPxxf2cMTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 06:51:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 07:51:29 +0100
Message-ID: <20250109065129.169932-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: B9E701F385
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify22: Add 76486b104168 tag
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

New tag for commit from v6.13-rc1 which fixes problem from v6.12-rc1.

Closes: https://github.com/linux-test-project/ltp/issues/1206
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Kernel 6.13-rc6 has been released, it should be safe to add the tag.
We can wait till 6.13 final release, but this tag should get into
upcoming LTP release.

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify22.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 19d437b945..1c72101369 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -325,6 +325,7 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "124e7c61deb2"},
+		{"linux-git", "76486b104168"},
 		{}
 	},
 	.needs_cmds = (const char *[]) {
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
