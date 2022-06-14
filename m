Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABF8C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:02:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98DCD3C9483
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 15:02:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42DDD3C006A
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:02:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 078061A009B3
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:02:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 517ED21AC2;
 Tue, 14 Jun 2022 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655211734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXdQUEu9JVd5gLGofWmmSgh8D5w1Cyv0Lf66pMG4Doc=;
 b=fpT15RI2vXetbn74IvBipE509uGY/2yObZKiWtho237nsxZPYCHcEm2JykdxJD7p2QWsRp
 wX8Ne+cHmVhGg9jlRKqb0+H3Fg/Aa0bRhxKYF1UUMgUnbMUwFqV6ShEZ5oC3uR7WdVPlD9
 FYqn0O0HoD+GB8j2OoyAt90OmH206rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655211734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXdQUEu9JVd5gLGofWmmSgh8D5w1Cyv0Lf66pMG4Doc=;
 b=mIeK+wQSg1DhTOfecOj3z4OL8Wz9EbR3gyD8ST6JthvjHwwqc1Y725gkDmZv4wdjUoKuvy
 uLeQ7j8lOu8XRADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3244F1361C;
 Tue, 14 Jun 2022 13:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XElICdaGqGIrHQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jun 2022 13:02:14 +0000
Date: Tue, 14 Jun 2022 15:04:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YqiHVJhvhf16s2kL@yuki>
References: <20220613125153.20423-1-chrubis@suse.cz> <YqdKVngCCGUfFDCZ@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqdKVngCCGUfFDCZ@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I wonder why this does not work:
> 	.needs_cmds = (const char *[]) {
> 		"execve06_child",
> 		NULL
> 	},
>
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> execve06.c:33: TFAIL: Failed to execute execl01_child: ENOENT (2)
> tst_test.c:395: TBROK: Invalid child (23451) exit value 1

The difference is because the test library adds current directory and
test start directory into $PATH before a test is executed, see
add_paths() in the tst_test.c.

The .needs_cmds is for binaries installed on the system in /usr/bin/
etc. so it does not make much sense to call the add_paths() before we
process the array.

> > +
> > +	pid = SAFE_FORK();
> > +	if (pid == 0) {
> > +		execve(path, argv, envp);
> > +		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
> > +	}
> > +}
> > +
> > +static struct tst_test test = {
> > +	.forks_child = 1,
> > +	.child_needs_reinit = 1,
> > +	.test_all = verify_execve,
> > +	.tags = (const struct tst_tag[]) {
> > +		{"linux-git", "dcd46d897adb"},
> > +		{"CVE", "2021-4034"},
> > +		{}
> > +	}
> > +};
> > diff --git a/testcases/kernel/syscalls/execve/execve06_child.c b/testcases/kernel/syscalls/execve/execve06_child.c
> > new file mode 100644
> > index 000000000..17280d58a
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/execve/execve06_child.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2022 Cyril Hrubis chrubis@suse.cz
> very nit: <chrubis@suse.cz> (missing < >)

Will fix.

> > + */
> > +
> > +#define TST_NO_DEFAULT_MAIN
> > +#include <stdlib.h>
> > +#include "tst_test.h"
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	tst_reinit();
> > +
> > +	if (argc != 1) {
> > +		tst_res(TFAIL, "argc is %d, expected 1", argc);
> > +		return 0;
> > +	}
> > +
> > +	if (!argv[0]) {
> > +		tst_res(TFAIL, "argv[0] == NULL");
> > +		return 0;
> > +	}
> > +
> > +	tst_res(TPASS, "argv[0] was filled in by kernel");
> 
> Testing matches the description from kernel commit.
> Maybe also test for argv[0] being empty string (to make sure behavior does not
> change, although unlikely it'd change)?

It should be safe either way but I decided to be less specific and only
check that something have been added there.

> I tested it on various kernels, works as expected.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

I will push it with the added runtest entries and fixed copyright then.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
