Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE784C54798
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 23:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D5F3D0856
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 00:36:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8A63CF176
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 00:36:18 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BB206003A8
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 00:36:17 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0070E1FBB5;
 Thu, 22 Feb 2024 23:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708644977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmimKFY1SNUA6tSkaJgtDV4uFpiJE5ih4KLmHVTA0h8=;
 b=kZa3utg9nxZPA27QFpQmXdAJEgpUUT7prkGRoWuwa06+BkMKALMBomNfOTWv2qvxcFdiF4
 8PDItmeDB5fqgzNs82CXqpImbmQX/CcxS9SiQ2PRIKFlaxSEdtyXhXOBDCaoUNPHuRXQmd
 ijOBJveV2Xvo9E0OXzpJ/8QNgaicews=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708644977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmimKFY1SNUA6tSkaJgtDV4uFpiJE5ih4KLmHVTA0h8=;
 b=HvFqeQ68SJ483YEvX8IMDDvouhcIGdfG4e7c5lo86iGquXNjmvuEYwI/CtUnWLC8/QxOJ6
 LtvJNQbE9ZS2lZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708644977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmimKFY1SNUA6tSkaJgtDV4uFpiJE5ih4KLmHVTA0h8=;
 b=kZa3utg9nxZPA27QFpQmXdAJEgpUUT7prkGRoWuwa06+BkMKALMBomNfOTWv2qvxcFdiF4
 8PDItmeDB5fqgzNs82CXqpImbmQX/CcxS9SiQ2PRIKFlaxSEdtyXhXOBDCaoUNPHuRXQmd
 ijOBJveV2Xvo9E0OXzpJ/8QNgaicews=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708644977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmimKFY1SNUA6tSkaJgtDV4uFpiJE5ih4KLmHVTA0h8=;
 b=HvFqeQ68SJ483YEvX8IMDDvouhcIGdfG4e7c5lo86iGquXNjmvuEYwI/CtUnWLC8/QxOJ6
 LtvJNQbE9ZS2lZCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF82F13419;
 Thu, 22 Feb 2024 23:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id DSPgJXDa12VaUAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 23:36:16 +0000
Date: Fri, 23 Feb 2024 00:36:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240222233614.GA1417479@pevik>
References: <20240222153648.2563-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240222153648.2563-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add stat04 test
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test has been extracted from symlink01 test and it checks that
> stat() executed on file provide the same information of symlink linking
> to it.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> free() tmpdir
> rename link_stat into link
> rename path_stat into path

>  runtest/smoketest                         |  2 +-
>  runtest/syscalls                          |  4 +-
>  testcases/kernel/syscalls/stat/.gitignore |  2 +
>  testcases/kernel/syscalls/stat/stat04.c   | 50 +++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 3 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/stat/stat04.c

> diff --git a/runtest/smoketest b/runtest/smoketest
> index 83eebfe7b..5608417f9 100644
> --- a/runtest/smoketest
> +++ b/runtest/smoketest
> @@ -8,7 +8,7 @@ time01 time01
>  wait02 wait02
>  write01 write01
>  symlink01 symlink01
> -stat04 symlink01 -T stat04
> +stat04 stat04
>  utime01A symlink01 -T utime01
>  rename01A symlink01 -T rename01
>  splice02 splice02 -s 20
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7794f1465..ef90076e4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1529,8 +1529,8 @@ stat02 stat02
>  stat02_64 stat02_64
>  stat03 stat03
>  stat03_64 stat03_64
> -stat04 symlink01 -T stat04
> -stat04_64 symlink01 -T stat04_64
> +stat04 stat04
> +stat04_64 stat04_64

>  statfs01 statfs01
>  statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
> index fa0a4ce9f..0a62dc6ee 100644
> --- a/testcases/kernel/syscalls/stat/.gitignore
> +++ b/testcases/kernel/syscalls/stat/.gitignore
> @@ -4,3 +4,5 @@
>  /stat02_64
>  /stat03
>  /stat03_64
> +/stat04
> +/stat04_64
> diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
> new file mode 100644
> index 000000000..aebfacf5a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/stat/stat04.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
very nit:
 * Author: David Fenner, Jon Hendrickson

> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks that stat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +	char *tmpdir = tst_get_tmpdir();
> +
> +	SAFE_SYMLINK(tmpdir, symname);
> +
> +	struct stat path;
> +	struct stat link;
nit: maybe define struct at the top of the function?
> +
> +	TST_EXP_PASS(stat(tmpdir, &path));
> +	free(tmpdir);
If SAFE_SYMLINK() fails, free() will not happen. I wonder if we should bother
(we'd have to set it NULL and add a cleanup function).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +	TST_EXP_PASS(stat(symname, &link));
> +
> +	TST_EXP_EQ_LI(path.st_dev, link.st_dev);
> +	TST_EXP_EQ_LI(path.st_mode, link.st_mode);
> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
> +	TST_EXP_EQ_LI(path.st_uid, link.st_uid);
> +	TST_EXP_EQ_LI(path.st_gid, link.st_gid);
> +	TST_EXP_EQ_LI(path.st_size, link.st_size);
> +	TST_EXP_EQ_LI(path.st_atime, link.st_atime);
> +	TST_EXP_EQ_LI(path.st_mtime, link.st_mtime);
> +	TST_EXP_EQ_LI(path.st_ctime, link.st_ctime);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
