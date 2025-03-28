Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0123AC28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 14:26:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 730A73CA464
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 15:26:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB4303C023C
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:25:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2936F1400518
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:25:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8449C1F38F;
 Fri, 28 Mar 2025 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743171942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=YdZwdSKPBgsgNBGtWJ/wf07k8FJOVBDNda0eSUDteayw71GT3hUQ6l9T3JTZCaOHy33DNz
 yzxY1U2VJWf70fJST+DJNIg/K2ovFjduTw6khDgk7kPN9iVNP+TAkgAu28FhHIRKyH9JQF
 devGeawWhyfiio0GGHOh5MRVHBuA70o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743171942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=uijry9Gfbri73LjlsNu5CSuzl16yJEIZXCJN2w7JtC618CzmaInNaYVQwbTts/T6smgycj
 Vs6n7DBn/GREUVCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743171942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=YdZwdSKPBgsgNBGtWJ/wf07k8FJOVBDNda0eSUDteayw71GT3hUQ6l9T3JTZCaOHy33DNz
 yzxY1U2VJWf70fJST+DJNIg/K2ovFjduTw6khDgk7kPN9iVNP+TAkgAu28FhHIRKyH9JQF
 devGeawWhyfiio0GGHOh5MRVHBuA70o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743171942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4/6NmN12zMhARy09p/3zhEqby9RGArkleaXIvP/l5g=;
 b=uijry9Gfbri73LjlsNu5CSuzl16yJEIZXCJN2w7JtC618CzmaInNaYVQwbTts/T6smgycj
 Vs6n7DBn/GREUVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F9DE13927;
 Fri, 28 Mar 2025 14:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAO4FWax5mfndgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Mar 2025 14:25:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Mar 2025 15:24:54 +0100
MIME-Version: 1.0
Message-Id: <20250328-landlock_unix_socket-v3-2-e2643f65b25e@suse.com>
References: <20250328-landlock_unix_socket-v3-0-e2643f65b25e@suse.com>
In-Reply-To: <20250328-landlock_unix_socket-v3-0-e2643f65b25e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743171941; l=2317;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uDQWYCSUB2odNfq6v5J8I71qWSjXqr/wEcMg55NMTaM=;
 b=ssUBF0NovddFTivseIImzziex3Mzr6iqwqWhjS4UbeAGRvyaxnH6jy1gMkmgp+ifSSPne2TFw
 m8xQao5bFEjCkzD9PGK7N5ky0RXZNyRfcromyDUgt2FX+ZAUlrcoOfN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] landlock02: support landlock ABI v6
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
