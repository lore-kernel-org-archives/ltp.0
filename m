Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE47EC3DA4A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:11:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18F0B3D1CCC
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 17:11:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4FFD3C9469
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 17:10:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 679E56030D2
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 17:10:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8531E21288;
 Fri, 26 Jul 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 768C4138A7;
 Fri, 26 Jul 2024 15:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /04BHHS8o2atKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jul 2024 15:10:44 +0000
Date: Fri, 26 Jul 2024 17:10:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqO8WHD-vJ7y9eLx@yuki>
References: <20240726-ioctl_ficlone-v4-1-710ed71bee70@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726-ioctl_ficlone-v4-1-710ed71bee70@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8531E21288
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add ioctl_ficlone04 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test verifies that ioctl() FICLONE/FICLONERANGE feature raises
> the right error according with bad file descriptors.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This testing suite is testing ioctl() FICLONE and FICLONERANGE
> functionalities. In particular, file clone and error codes.
> ---
> Changes in v4:
> - ioctl_ficlone04: add EPERM and EOPNOTSUP
> - Link to v3: https://lore.kernel.org/r/20240724-ioctl_ficlone-v3-1-bdf7551380ee@suse.com
> 
> Changes in v3:
> - ioctl_ficlone04: use a generic array for expected errors
> - Link to v2: https://lore.kernel.org/r/20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com
> 
> Changes in v2:
> - add fallback definitions
> - algorithm steps using '-'
> - avoid assigning -1 to file descriptors after close()
> - use SAFE_UNLINK() instead of remove()
> - enable both xfs and btrs for all tests
> - Link to v1: https://lore.kernel.org/r/20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com
> ---
>  testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
>  testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c | 52 +++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index 9f995b1ad..1f099ff95 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -25,5 +25,6 @@
>  /ioctl_ficlone01
>  /ioctl_ficlone02
>  /ioctl_ficlone03
> +/ioctl_ficlone04
>  /ioctl_ficlonerange01
>  /ioctl_ficlonerange02
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
> new file mode 100644
> index 000000000..b7711ac30
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that ioctl() FICLONE/FICLONERANGE feature raises the right
> + * error according with bad file descriptors.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/ficlone.h"
> +
> +static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
> +{
> +	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
> +		tst_res(TCONF, "Skipping file: SUCCESS");

Maybe just a TINFO here.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
