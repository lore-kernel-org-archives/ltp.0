Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70985C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 15:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 065EE3C9C74
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 16:19:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECBCD3C0722
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:19:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22D35603441
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:19:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF242116B;
 Tue, 18 Feb 2025 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739891944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKZiPPJvUpCMuPllFtxXjchk8s+YxG6Aq6mXFlCyEvk=;
 b=UGAMMceqbZVH/kYeiqBWSujLPyHGphPxlVq6XNjEH2t9O/8ekWiJ6F6CK3nWfDA1isnS7f
 8YlDOjApaQ7DAYw1UbqV7n6vA797IqVjlsufYD8EbgAzAD73PSy2e0o3eW87DVz44BBEEM
 bblSr5U9le9qQVsVezIbAoLhuoo/MnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739891944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKZiPPJvUpCMuPllFtxXjchk8s+YxG6Aq6mXFlCyEvk=;
 b=F7z1vr+spHoFjcrc0U+7WN5gPzHCF9GIQfij2ykk5vGfDevMXNY6Az0Ed/WjV/+ImCWZTN
 C9LIGaYwAGN2t0Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UGAMMceq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F7z1vr+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739891944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKZiPPJvUpCMuPllFtxXjchk8s+YxG6Aq6mXFlCyEvk=;
 b=UGAMMceqbZVH/kYeiqBWSujLPyHGphPxlVq6XNjEH2t9O/8ekWiJ6F6CK3nWfDA1isnS7f
 8YlDOjApaQ7DAYw1UbqV7n6vA797IqVjlsufYD8EbgAzAD73PSy2e0o3eW87DVz44BBEEM
 bblSr5U9le9qQVsVezIbAoLhuoo/MnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739891944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKZiPPJvUpCMuPllFtxXjchk8s+YxG6Aq6mXFlCyEvk=;
 b=F7z1vr+spHoFjcrc0U+7WN5gPzHCF9GIQfij2ykk5vGfDevMXNY6Az0Ed/WjV/+ImCWZTN
 C9LIGaYwAGN2t0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15CBB13A1D;
 Tue, 18 Feb 2025 15:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aKMeA+iktGe3cwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 15:19:04 +0000
Date: Tue, 18 Feb 2025 16:18:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250218151858.GA2492575@pevik>
References: <20250217020423.31602-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217020423.31602-1-wegao@suse.com>
X-Rspamd-Queue-Id: 4AF242116B
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
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

nit: I guess you want to replace dot with space in subject.

> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic mount_setattr() test.
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

Is it necessary to to use directory under root?

...
> +static void cleanup(void)
> +{

I guess this is due result of:
SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
There should be either a proper detection whether this works or 

../../../../include/lapi/fsmount.h:113: TCONF: syscall(442) __NR_mount_setattr not supported on your arch
mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: EBUSY (16)


> +	SAFE_RMDIR(DIRA);

When running on old kernel (e.g. SLES based 4.12) it fails due TCONF:

../../../../include/lapi/fsmount.h:197: TCONF: Test not supported on kernel version < v5.2
mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: ENOENT (2)

There should be a flag to remove dir only when it was created.

> +
nit: please remove this new line (I have to keep asking this :( ).
> +}
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
I wonder if this needed for detecting new mount API support. Because second
SAFE_MOUNT also runs code which detects code unsupported:

../../../../include/lapi/fsmount.h:113: TCONF: syscall(442) __NR_mount_setattr not supported on your arch
mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: EBUSY (16)

But I have no idea what would be needed to be done to cleanup result of the
first SAFE_MOUNT().

> +
> +	SAFE_MKDIR(DIRA, 0777);
> +}
> +
> +static void run(void)
> +{
> +
and here new line.
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> +	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
Do these 2 needs to be in the run()? How about move them to setup()?

static int dir_created, mounted;

static void setup(void)
{
	fsopen_supported_by_kernel();

	SAFE_MKDIR(DIRA, 0777);
	dir_created = 1;
	SAFE_UNSHARE(CLONE_NEWNS);
	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
	mounted = 1;
}

static void cleanup(void)
{
	if (mounted)
		SAFE_UMOUNT(DIRA);

	if (dir_created)
		SAFE_RMDIR(DIRA);
}

+ I later create generic helper from is_shared_mount().

Kind regards,
Petr

> +
> +	struct mount_attr attr = {
> +		.attr_set       = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
> +		.attr_clr       = MOUNT_ATTR__ATIME,
> +	};
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +
> +	attr.propagation = -1;
> +	TST_EXP_FAIL_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)), EINVAL);
> +	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +
> +	attr.propagation = MS_SHARED;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(DIRA), 1);
> +
> +	attr.propagation = MS_PRIVATE;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +
> +	attr.propagation = MS_SLAVE;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +
> +	SAFE_UMOUNT(DIRA);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
