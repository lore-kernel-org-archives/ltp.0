Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EFEC021B3
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 12:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4656A3C06C9
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 13:55:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3489D3C29BB
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:55:06 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 561D6142F20C
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:55:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC14E21D33;
 Fri, 21 Feb 2025 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740142503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TKZVVpVYCbN3WFJw0Hqa0h0ZOTer4AIi+KoNDIjW1o=;
 b=y9MoCT9tvRZ5C6zE5PDd8PzPtd9a4UUDi1cTjq7k6dy19gkZDzFxp0Xgaqqg0TbEFCpOYP
 5cBjmonPnXruHzxWbiYj81LNWXuuKVnr4ORDfz4YwXZ52VVdt4PElbv901MdF+vulAB/1H
 dd+3hVPhExtcetCF/TfUrvVJebBYkZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740142503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TKZVVpVYCbN3WFJw0Hqa0h0ZOTer4AIi+KoNDIjW1o=;
 b=Y+UC4qtcQHEu56W9vxmNQ+FKl1wG3YxLcl/X6SGv3k4WqINH/n8izTSQVllCURgvxeb+nl
 1hGNTtNyK51w3hCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y9MoCT9t;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y+UC4qtc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740142503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TKZVVpVYCbN3WFJw0Hqa0h0ZOTer4AIi+KoNDIjW1o=;
 b=y9MoCT9tvRZ5C6zE5PDd8PzPtd9a4UUDi1cTjq7k6dy19gkZDzFxp0Xgaqqg0TbEFCpOYP
 5cBjmonPnXruHzxWbiYj81LNWXuuKVnr4ORDfz4YwXZ52VVdt4PElbv901MdF+vulAB/1H
 dd+3hVPhExtcetCF/TfUrvVJebBYkZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740142503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5TKZVVpVYCbN3WFJw0Hqa0h0ZOTer4AIi+KoNDIjW1o=;
 b=Y+UC4qtcQHEu56W9vxmNQ+FKl1wG3YxLcl/X6SGv3k4WqINH/n8izTSQVllCURgvxeb+nl
 1hGNTtNyK51w3hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C22013806;
 Fri, 21 Feb 2025 12:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ltc9I6d3uGdMaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 12:55:03 +0000
Date: Fri, 21 Feb 2025 13:54:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250221125458.GA2784225@pevik>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250219082954.23552-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250219082954.23552-1-wegao@suse.com>
X-Rspamd-Queue-Id: BC14E21D33
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mount_setattr02.c: Check mount_setattr
 attr.propagation
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

nit: You did not change commit message subject (we talked about it).

> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
NOTE: this '[Description]' should no longer be added.

See:
https://github.com/linux-test-project/ltp/commit/a3e27df34d6cb49477c9bd6f9bbaa1ce4de155f9
(it updated also examples in doc)

and follow ups
https://github.com/linux-test-project/ltp/commit/63eceaa2a83bca41997edcd649eb62272622a100
https://github.com/linux-test-project/ltp/commit/824f66ca72fc7505a31c30792334905b646c9d37
> + *
> + * Basic mount_setattr() test.
nit: here is better a blank line.
> + * Test basic propagation mount attributes are set correctly.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/statvfs.h>
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "tst_safe_stdio.h"
> +
> +#define DIRA "/DIRA_PROPAGATION_CHECK"

Also, I found a way to test into TMPDIR. There is no need to touch a real root.
It works even on separate /tmp.

If you agree, I merge with following diff.
https://github.com/pevik/ltp/blob/wei/mount_setattr02.v2.fixes/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c

With changes below.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

+++ testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
@@ -4,9 +4,8 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mount_setattr() test.
+ *
  * Test basic propagation mount attributes are set correctly.
  */
 
@@ -17,9 +16,9 @@
 #include "lapi/fsmount.h"
 #include "tst_safe_stdio.h"
 
-#define DIRA "/DIRA_PROPAGATION_CHECK"
+static char *tmpdir;
 
-static int dir_created, mounted;
+static int mounted;
 
 static bool is_shared_mount(const char *path)
 {
@@ -52,19 +51,15 @@ static bool is_shared_mount(const char *path)
 static void cleanup(void)
 {
 	if (mounted)
-		SAFE_UMOUNT(DIRA);
-
-	if (dir_created)
-		SAFE_RMDIR(DIRA);
+		SAFE_UMOUNT(tmpdir);
 }
 
 static void setup(void)
 {
-	SAFE_MKDIR(DIRA, 0777);
+	tmpdir = tst_tmpdir_path();
 	SAFE_UNSHARE(CLONE_NEWNS);
-	dir_created = 1;
 	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
-	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
+	SAFE_MOUNT("testing", tmpdir, "tmpfs", MS_NOATIME | MS_NODEV, "");
 	mounted = 1;
 }
 
@@ -75,24 +70,24 @@ static void run(void)
 		.attr_clr       = MOUNT_ATTR__ATIME,
 	};
 
-	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
-	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
 
 	attr.propagation = -1;
-	TST_EXP_FAIL_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)), EINVAL);
-	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+	TST_EXP_FAIL_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)), EINVAL);
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
 
 	attr.propagation = MS_SHARED;
-	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
-	TST_EXP_EQ_LI(is_shared_mount(DIRA), 1);
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 1);
 
 	attr.propagation = MS_PRIVATE;
-	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
-	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
 
 	attr.propagation = MS_SLAVE;
-	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
-	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
+	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
+	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
 }
 
 static struct tst_test test = {
@@ -100,4 +95,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.needs_tmpdir = 1,
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
