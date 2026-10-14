Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180EACC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 14:21:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4D4E3EA7A6
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7553E2050
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 16:20:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D43E1A00996
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 16:20:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8708122243;
 Wed, 14 Oct 2026 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791987639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcGCEnJQsQ3g9qwuEvjPPyM1sNIgc13ceyIGh5YjTZA=;
 b=IFzP5KDk8ubZpOGIH9roRVBgMUT5vkC4M2jxxQoxDrGF8LAFXKbtUMmDNcma4uEtYXi3r5
 HOFPw4R3kxQ49QNSRkTTxPy6JyTWvpezpiXwz/k3IoXVdmG9hGH3IRNGCT3CsxFYfduJDd
 iH5WAlBvqylU8MujiIa/sTs/CYjS7dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791987639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcGCEnJQsQ3g9qwuEvjPPyM1sNIgc13ceyIGh5YjTZA=;
 b=KMVMb/bMa+xPtOPkKLX6Ftpls2X0v76aZidQwrbE5C2KVxpn1zxYuJb4seMgIOzloOAgJM
 yGrrAAMyZrgR8GDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rvD8VXi9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KqhAqaNT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791987638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcGCEnJQsQ3g9qwuEvjPPyM1sNIgc13ceyIGh5YjTZA=;
 b=rvD8VXi9aCklo4RLBXLfk7UhL2fLd2a1o+HcZmYBmVwFp0CtsnXFp3hC8Atz++AEjdKef9
 W6ZPvQy6TRbc1PN+LVBMd0QzGYY44YZJGv2Pm5iJJi+nJ45vPtvysygVGQZ7HBcwSgrqTW
 R0GNvPENIe/f4yOKn/xQzhlmy5dXlOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791987638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcGCEnJQsQ3g9qwuEvjPPyM1sNIgc13ceyIGh5YjTZA=;
 b=KqhAqaNTVqkZJtAwo+IXSiGZzkm7cXX5INl80ZaoE7NpVPUv7v4fveLGvj7IpUaLj9zKc4
 yt/78C/Z5dEszqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EACA1368E;
 Wed, 14 Oct 2026 14:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XNemCraPz2rWdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 Oct 2026 14:20:38 +0000
Date: Wed, 14 Oct 2026 16:20:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <as-PxIfrUCyPZjQd@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-14-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-14-57cceb68f927@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 8708122243
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 14/16] fchroot11: test failfs entry
 with no_new_privs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Verify that an unprivileged process may enter failfs when it
> committed to no_new_privs, since setuid binaries then pose no
> confused deputy risk anymore. The test also verifies that a process
> which entered failfs counts as chrooted: it can no longer create a
> user namespace with unshare() to regain CAP_SYS_CHROOT.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/staging                               |  1 +
>  testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
>  testcases/kernel/syscalls/fchroot/fchroot11.c | 70 +++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/runtest/staging b/runtest/staging
> index 9ec2a7897..137e3f99a 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -10,3 +10,4 @@ fchroot07 fchroot07
>  fchroot08 fchroot08
>  fchroot09 fchroot09
>  fchroot10 fchroot10
> +fchroot11 fchroot11
> diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
> index 53a1fa1d0..650ef2690 100644
> --- a/testcases/kernel/syscalls/fchroot/.gitignore
> +++ b/testcases/kernel/syscalls/fchroot/.gitignore
> @@ -9,3 +9,4 @@ fchroot07_child
>  fchroot08
>  fchroot09
>  fchroot10
> +fchroot11
> diff --git a/testcases/kernel/syscalls/fchroot/fchroot11.c b/testcases/kernel/syscalls/fchroot/fchroot11.c
> new file mode 100644
> index 000000000..85401e5fe
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchroot/fchroot11.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test unprivileged :manpage:`fchroot(2)` into failfs with no_new_privs
> + * set.
> + *
> + * An unprivileged process may enter failfs when it committed to
> + * no_new_privs, since setuid binaries then pose no confused deputy risk
> + * anymore. The test also verifies that a process which entered failfs
> + * counts as chrooted: it can no longer create a user namespace with
> + * :manpage:`unshare(2)` to regain ``CAP_SYS_CHROOT``.
> + *
> + * The user namespace check requires ``CONFIG_USER_NS``, which is enforced
> + * with ``.needs_kconfigs``.
> + *
> + * Root is required to drop to an unprivileged user in the forked child.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <pwd.h>
> +#include <sched.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/prctl.h"
> +#include "lapi/sched.h"
> +#include "lapi/syscalls.h"
> +
> +static struct passwd *ltpuser;
> +
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
> +		ltpuser->pw_uid);
> +
> +	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"unprivileged fchroot() with no_new_privs");
> +
> +	TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
> +		"absolute lookup after entering failfs");

AFAIK there is no /etc/passwd on Android. Maybe we should use /dev/zero
instead?

> +	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
> +		"user namespace creation blocked by the failfs root");
> +
> +	exit(0);

Here as well, no need for the exit(0).

> +}
> +
> +static void setup(void)
> +{
> +	ltpuser = SAFE_GETPWNAM("nobody");
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS=y",
> +		NULL,
> +	}
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
