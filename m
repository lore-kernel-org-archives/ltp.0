Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47485CE8D75
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:24:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6A503C2F68
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:24:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E6D3C2F5B
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:20 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A668F25796A
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1860208B0
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZD6JDOt6r0i4XDpMTpnb2O0Du/sJX67+tw9V01jWGY=;
 b=mVLH/ce6tYWZ/WXVIvszflC9OvYfG/xhL9br4UGByVwc1UMc5YhQKCO03aWFlppgE8u+Jl
 qf0izoeS32kVx60fOSiGhEZw2KlnI7O49NcHr0Q31SoXwKVJ5h+wPaPi9SX09/NS4VkiEQ
 eGk9SjG0JNnEOYU50l9zlxir2XfSZg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZD6JDOt6r0i4XDpMTpnb2O0Du/sJX67+tw9V01jWGY=;
 b=1eCAp1O/+fvBGVNJA5eTiz3ohWq/YViN1OVQiW1g4WrtIrrQOJGOMIEMcWzQG1mLucacDm
 IPL8KX6C5byUNiDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mVLH/ce6";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1eCAp1O/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZD6JDOt6r0i4XDpMTpnb2O0Du/sJX67+tw9V01jWGY=;
 b=mVLH/ce6tYWZ/WXVIvszflC9OvYfG/xhL9br4UGByVwc1UMc5YhQKCO03aWFlppgE8u+Jl
 qf0izoeS32kVx60fOSiGhEZw2KlnI7O49NcHr0Q31SoXwKVJ5h+wPaPi9SX09/NS4VkiEQ
 eGk9SjG0JNnEOYU50l9zlxir2XfSZg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZD6JDOt6r0i4XDpMTpnb2O0Du/sJX67+tw9V01jWGY=;
 b=1eCAp1O/+fvBGVNJA5eTiz3ohWq/YViN1OVQiW1g4WrtIrrQOJGOMIEMcWzQG1mLucacDm
 IPL8KX6C5byUNiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9FC13AE1
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKSNMJX762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:09 +0200
MIME-Version: 1.0
Message-Id: <20240919-landlock_network-v1-3-9c997f03bd0a@suse.com>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
In-Reply-To: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=1067;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=8oCFW7oEByWajBDhzNvKgHupfFv5MGOodlF8IJKdDHc=;
 b=/fCohyz5mm2LfQmIvE47j+WAajZsed4e67/BpQgAXtxqVbF0jLR3FNJe6RGUxkjmOiiu1Baii
 2i8Hb6xzjIQAXujHX1s+J9LI/ch/9p7Rtu2bcVqMZ1UFHB52SDO99Ao
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E1860208B0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] Fix landlock06 creating multiple ruleset
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock06.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index f04df2ff1..139eac904 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -42,8 +42,6 @@ static void run(void)
 
 static void setup(void)
 {
-	int ruleset_fd;
-
 	if (verify_landlock_is_enabled() < 5)
 		tst_brk(TCONF, "LANDLOCK_ACCESS_FS_IOCTL_DEV is not supported");
 
@@ -56,17 +54,12 @@ static void setup(void)
 
 	ruleset_attr->data.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
-
 	apply_landlock_fs_layer(
 		ruleset_attr,
 		path_beneath_attr,
 		MNTPOINT,
 		LANDLOCK_ACCESS_FS_IOCTL_DEV
 	);
-
-	SAFE_CLOSE(ruleset_fd);
 }
 
 static void cleanup(void)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
