Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A59C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:38:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DE163CA206
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:38:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C7E3C9B47
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:37:32 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D441F1000374
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:37:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E997D211CC;
 Fri, 28 Mar 2025 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743151051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=iG6tj0eEJWZwR/nSOQXV4AITb1fMf+U81ZwqgJ2lSNdfZMEQPtxRhLEH3ynpt9VPp6rHnw
 i9zVZ/EGzG3ntSPAtoI8Vl1D/ie4q/W+1JYC7J7XZwobpVlf4YCQ4p3oH5oYK1ZyGK81MP
 7t20u+6dsRK+DtUOLlXSIN24pYSmcpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743151051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=cz1Gn2by81BTvn/11dzDl2DITOc/t8dL6qdTdNf0mrjNinqCgELAxkTfvRjBcPawQ+Fh+U
 va4QzJuZGoeYG5Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nITWMFVQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="x/lrXKXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743151050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=nITWMFVQSZqfCtD6rYoKXwDwUxNmErkrrtapux50HY+Ucr8zI4cx4TGpzPAY4NsO25eBtw
 diD+vPu6nkwult7XFk4Vtble71chIuj25bCfiEvlq/EmLyRA6UBmmDhMSwmmMIPIezaJqJ
 +7AnoiggcJvzGQ2Rh18Zg0eV1z+X7rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743151050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=x/lrXKXTcIegS7fCu+i+gOG6EDRAmxVkKHjL7+LpOpaxF5HT6drxEZvqjqX9hHetqCKqTF
 BzH3V5XOOHF2rlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68D913927;
 Fri, 28 Mar 2025 08:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMnSLspf5mcEBQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Mar 2025 08:37:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Mar 2025 09:36:58 +0100
MIME-Version: 1.0
Message-Id: <20250328-landlock_unix_socket-v2-2-dd3072962c42@suse.com>
References: <20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com>
In-Reply-To: <20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743151050; l=2317;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uDQWYCSUB2odNfq6v5J8I71qWSjXqr/wEcMg55NMTaM=;
 b=qmPypA7HTjZQV297kA1KwQ26eVVgka//gmA5d+HdBm8TgWRtXarRViN7nfVNAYdKkc5vx2Jmu
 BnAX4l89gGuAEdSHn/hWW0nXAe87FZP9U1xHidIQEc7FRco8ZPxFbEb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E997D211CC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] landlock02: support landlock ABI v6
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock02.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 60010f554b001156f3feb30283bb5c22a5fea1fc..37dc72d32c633a2f249c5a9ef879b6d288a63259 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -20,6 +20,7 @@
 
 static struct tst_landlock_ruleset_attr_abi1 *attr_abi1;
 static struct tst_landlock_ruleset_attr_abi4 *attr_abi4;
+static struct tst_landlock_ruleset_attr_abi6 *attr_abi6;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
 static struct landlock_net_port_attr *net_port_attr;
@@ -144,15 +145,19 @@ static void setup(void)
 {
 	abi_current = verify_landlock_is_enabled();
 
-	attr_abi1->handled_access_fs =
-		attr_abi4->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	attr_abi1->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	attr_abi4->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	attr_abi6->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	if (abi_current < 4) {
 		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
 			attr_abi1, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
-	} else {
+	} else if (abi_current < 6) {
 		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
 			attr_abi4, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
+	} else {
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
+			attr_abi6, sizeof(struct tst_landlock_ruleset_attr_abi6), 0));
 	}
 }
 
@@ -171,6 +176,7 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&attr_abi1, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&attr_abi4, .size = sizeof(struct tst_landlock_ruleset_attr_abi4)},
+		{&attr_abi6, .size = sizeof(struct tst_landlock_ruleset_attr_abi6)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
 		{},

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
