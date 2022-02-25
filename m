Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D386C433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 15:53:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D64133CA249
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 16:53:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 153EE3C92D0
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 16:53:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 125C11A01E3E
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 16:53:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09B72210EE;
 Fri, 25 Feb 2022 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645804406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGyAbwYce4MtXZYZKd0zgY/ir+YkrCSrXoq2/xVIU/s=;
 b=O8vXQv/blYPBlL6lZ/s66+EVStloA3mfh/JcHB9kQ3CVPy9TpFt+yHUmZWTGNAxWrvoZNH
 B01ZMZJ3e3ZdXgoCbEMtIY9LTRwEzvwrTBgdf5fTlKr4n/RMAq4TymPpFhTTDzOKXymfqk
 vsou3en2aNZ5cGnjHn7WdBf1kw5SEA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645804406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGyAbwYce4MtXZYZKd0zgY/ir+YkrCSrXoq2/xVIU/s=;
 b=oyhgVdKFNnA20Muc3RcdA6PZVoxPyVxzxlXy+KxXwLPgmhRS6FpVonuEWucJSMlHopuP9I
 bCBta1luD8q+VPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF9AB13BFF;
 Fri, 25 Feb 2022 15:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nLsYNXX7GGL4EAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 25 Feb 2022 15:53:25 +0000
Date: Fri, 25 Feb 2022 16:55:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Message-ID: <Yhj7/VbTz/Z0m8d/@yuki>
References: <20220225033456.63578-1-xiaoshoukui@ruijie.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220225033456.63578-1-xiaoshoukui@ruijie.com.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Add pty06 test for use-after-free in
 con_shutdown()
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
First of all the coding style is wrong, please run 'make check-pty06'
and fix all the warnings and errors.

> diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
> new file mode 100644
> index 000000000..9fcd341e6
> --- /dev/null
> +++ b/testcases/kernel/pty/pty06.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> + *
> + * Test based on Syzkaller reproducer:
> + * https://syzkaller.appspot.com/bug?extid=522643ab5729b0421998
> + *
> + * The VT_DISALLOCATE ioctl can free a virtual console while tty_release()
> + * is still running, causing a use-after-free in con_shutdown().	This
> + * occurs because VT_DISALLOCATE only considers a virtual console to be
> + * in-use if it has a tty_struct with count > 0.	But actually when
> + * count == 0, the tty is still in the process of being closed.
> + *
> + * Fixed by commit ca4463bf8438:
> + * "vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console"
> + *
> + */

Plese convert this into a docparse comment. We do have a system that
collects documentation from tests and renders a nice documentation:

http://linux-test-project.github.io/metadata/metadata.asciidoctor.html

The docparse comment starts with:

/*\
 * [Description]
 *

And is assciidoc formatted.

> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <termios.h>
> +#include <linux/vt.h>
> +#include "lapi/ioctl.h"
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_fuzzy_sync.h"
> +
> +#define BUF_SIZE 256
> +static char tty_path_a[BUF_SIZE];
> +static char tty_path_b[BUF_SIZE];
> +static int tst_tty_port = 8;
> +static struct tst_fzsync_pair fzp;
> +
> +static void *open_close(void *unused) {
> +    sprintf(tty_path_b, "/dev/tty%d", tst_tty_port);
> +    while (tst_fzsync_run_b(&fzp)) {
> +        tst_fzsync_start_race_b(&fzp);
> +        int fd = SAFE_OPEN(tty_path_b, O_RDWR);
> +        SAFE_CLOSE(fd);
> +        tst_fzsync_end_race_b(&fzp);
> +    }
> +    return unused;
> +}
> +
> +static void do_test(void) {
> +    sprintf(tty_path_a, "/dev/tty%d", tst_tty_port + 1);
> +    int fd = SAFE_OPEN(tty_path_a, O_RDWR);
> +    tst_fzsync_pair_reset(&fzp, open_close);
> +    while (tst_fzsync_run_a(&fzp)) {
> +        tst_fzsync_start_race_a(&fzp);
> +        ioctl(fd, VT_DISALLOCATE, tst_tty_port);
> +        tst_fzsync_end_race_a(&fzp);
> +    }
> +    tst_res(TPASS, "Did not crash with VT_DISALLOCATE");
> +}
> +
> +static void setup(void) {
> +    tst_fzsync_pair_init(&fzp);
> +}
> +
> +static void cleanup(void) {
> +    tst_fzsync_pair_cleanup(&fzp);
> +}
> +
> +static struct tst_test test = {
> +        .test_all = do_test,
> +        .setup = setup,
> +        .cleanup = cleanup,
> +        .needs_root = 1,
> +        .tags = (const struct tst_tag[]) {
> +                {"linux-git", "ca4463bf8438"},
> +                {}
> +        }
> +};
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
