Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90893C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312663C5EF3
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:55:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFFB13C537F
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C8131600126
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:54:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 330041F7F9;
 Tue, 27 May 2025 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=rbMUuLmOrWQzJi/RmFKsUnzvUHb9UGH/uYyVL9xT+yMtGEr/MdMnICGP0YuXFmbiMvDCMi
 RqCB7bB8camyonaSLDUeu5F+2blhXEuJjt6HIBxSSOAEQb268yOukAc6B47BSmEl5geoAz
 208xZCMiKV1k8X0/8J9W0WrBjjAqx50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=QBI4K5Jb0z4NlAViE31SgI5LkBjB5/JCQSrfodsEPoCYU/X7qs+m4iYI711H7+l49AJU6w
 OKqjLX24lfeUArBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748343289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=rbMUuLmOrWQzJi/RmFKsUnzvUHb9UGH/uYyVL9xT+yMtGEr/MdMnICGP0YuXFmbiMvDCMi
 RqCB7bB8camyonaSLDUeu5F+2blhXEuJjt6HIBxSSOAEQb268yOukAc6B47BSmEl5geoAz
 208xZCMiKV1k8X0/8J9W0WrBjjAqx50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748343289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=QBI4K5Jb0z4NlAViE31SgI5LkBjB5/JCQSrfodsEPoCYU/X7qs+m4iYI711H7+l49AJU6w
 OKqjLX24lfeUArBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E85F31388B;
 Tue, 27 May 2025 10:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sNG3NPiZNWihdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 May 2025 10:54:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 12:54:38 +0200
MIME-Version: 1.0
Message-Id: <20250527-landlock_unix_socket-v4-2-80d3d579094b@suse.com>
References: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
In-Reply-To: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748343288; l=2317;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uDQWYCSUB2odNfq6v5J8I71qWSjXqr/wEcMg55NMTaM=;
 b=tbcI/HhZkWukgfCyBgCBxH/LPgQPMQbvhi2omAzGI+2jW0nViDY3FMoCDb0sMg5dpJTfp+yCd
 TSv/o6DTMeQCWcGDxGIUOyfbmL8hSaMnwjrsTxMWFHI1p88enxBRtbf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] landlock02: support landlock ABI v6
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
