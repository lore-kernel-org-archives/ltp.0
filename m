Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A2C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D957D3C9478
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:32:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1428D3C110E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:31:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51BF010005BE
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:31:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73AA321CA5;
 Mon, 13 Jun 2022 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655130713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROTpnk4ddTGRgds9nB0l9ssAxxYpfqx6vYRDoMJudXc=;
 b=0ANvg2XvS3/VtWhKm9DcsD9Gdm0uJWLwdk1E0P9nLi/ED9PWy53n0NOskcPB37aFlOVNPl
 s0o3xOWFSY0fssDmi5+XUf0KZqj4a+WJ46mecpe6YiuztUUYiEw/fjGOMAssuPFzUp+bjP
 KWcxJsPt+0jTWx22lLzHkgUJLbBxYf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655130713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROTpnk4ddTGRgds9nB0l9ssAxxYpfqx6vYRDoMJudXc=;
 b=nBYEUSBf42znfsuR8YmBS8NJ8aUuAIjYl1lseZllyQmQ3zVw37rCwgO/QmM2c6ccnwWBE4
 qrW10XR9VlusIVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2689913443;
 Mon, 13 Jun 2022 14:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SnPNBVlKp2J/RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 14:31:53 +0000
Date: Mon, 13 Jun 2022 16:31:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YqdKVngCCGUfFDCZ@pevik>
References: <20220613125153.20423-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613125153.20423-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve06: Add test for argv[0] = NULL
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

Hi Cyril,

...
> in order to fix all potential CVEs where userspace programs attempt to
> blindly process the argv[] list starting at argv[1]. There was at least
> one example of this caught in the wild CVE-2021-4034 in polkit but there
> are likely more.

Thanks for implementing this!

> Fixes: #911

...
> diff --git a/testcases/kernel/syscalls/execve/execve06.c b/testcases/kernel/syscalls/execve/execve06.c
> new file mode 100644
> index 000000000..b3280cf76
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execve/execve06.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test that kernel adds dummy argv[0] if empty argument list was passed to
> + * execve(). This fixes at least one CVE where userspace programs start to
> + * process argument list blindly from argv[1] such as polkit pkexec
> + * CVE-2021-4034.

We might also add link to LWM article :)
https://lwn.net/Articles/883547/
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static void verify_execve(void)
> +{
> +	pid_t pid;
> +	char path[512];
> +	char ipc_env_var[1024];
> +
> +	sprintf(ipc_env_var, IPC_ENV_VAR "=%s", getenv(IPC_ENV_VAR));
> +
> +	char *const envp[] = {ipc_env_var, NULL};
> +	char *const argv[] = {NULL};
> +
> +	if (tst_get_path("execve06_child", path, sizeof(path)))
> +		tst_brk(TCONF, "Couldn't find execve06_child in $PATH");
I wonder why this does not work:
	.needs_cmds = (const char *[]) {
		"execve06_child",
		NULL
	},

tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
execve06.c:33: TFAIL: Failed to execute execl01_child: ENOENT (2)
tst_test.c:395: TBROK: Invalid child (23451) exit value 1

> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		execve(path, argv, envp);
> +		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.child_needs_reinit = 1,
> +	.test_all = verify_execve,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "dcd46d897adb"},
> +		{"CVE", "2021-4034"},
> +		{}
> +	}
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve06_child.c b/testcases/kernel/syscalls/execve/execve06_child.c
> new file mode 100644
> index 000000000..17280d58a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execve/execve06_child.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 Cyril Hrubis chrubis@suse.cz
very nit: <chrubis@suse.cz> (missing < >)

> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	tst_reinit();
> +
> +	if (argc != 1) {
> +		tst_res(TFAIL, "argc is %d, expected 1", argc);
> +		return 0;
> +	}
> +
> +	if (!argv[0]) {
> +		tst_res(TFAIL, "argv[0] == NULL");
> +		return 0;
> +	}
> +
> +	tst_res(TPASS, "argv[0] was filled in by kernel");

Testing matches the description from kernel commit.
Maybe also test for argv[0] being empty string (to make sure behavior does not
change, although unlikely it'd change)?

I tested it on various kernels, works as expected.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
