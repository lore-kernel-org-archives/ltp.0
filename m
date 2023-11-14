Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13ECC4167D
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 11:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 906C13CE505
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 12:30:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 954393CC27F
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 12:30:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7EF33687226
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 12:30:34 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2CE1421892;
 Tue, 14 Nov 2023 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699961433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r4jE3s0fuPtaizZfC+J8K6JTUgOiIe1j96SXkg6AkXE=;
 b=H8iTUiNJWFjbXucbyRRF4mzQF+xFD25lqm9hdgqu8WRy5msjENBOXEYArxJTuM5mOFZOxL
 fA0BO8cgsbRbsvQZ6/apt9kkv0RvlTuEIeVREISV8UL7c8u4D3Q8r9F4yFSn8WpMhrBVug
 PH/uNJOWu8RGUf5rcu/XRozjAPTzeKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699961433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r4jE3s0fuPtaizZfC+J8K6JTUgOiIe1j96SXkg6AkXE=;
 b=8FYw2XMBLdfpDN9yPrwhDjEueghQG4KGljlc8/adOm51n8WbCG5BLre5xSgteFVSnSZ7UR
 Bl/rMAX+lfyCEtCg==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CAFDF2C525;
 Tue, 14 Nov 2023 11:30:32 +0000 (UTC)
References: <20230913101542.18550-1-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Tue, 14 Nov 2023 09:17:15 +0000
Organization: Linux Private Site
In-reply-to: <20230913101542.18550-1-wegao@suse.com>
Message-ID: <87zfzga7xj.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 2CE1421892
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] move_mount03: check allow to mount beneath top
 mount
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/fsmount.h                        |  4 ++
>  runtest/syscalls                              |  1 +
>  .../kernel/syscalls/move_mount/.gitignore     |  1 +
>  .../kernel/syscalls/move_mount/move_mount03.c | 63 +++++++++++++++++++
>  4 files changed, 69 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c
>
> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index 07eb42ffa..216e966c7 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -115,6 +115,10 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
>  }
>  #endif /* HAVE_MOUNT_SETATTR */
>  
> +#ifndef MOVE_MOUNT_BENEATH
> +#define MOVE_MOUNT_BENEATH 		0x00000200
> +#endif /* MOVE_MOUNT_BENEATH */
> +
>  /*
>   * New headers added in kernel after 5.2 release, create them for old userspace.
>  */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b1125dd75..04b758fd9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -824,6 +824,7 @@ mount_setattr01 mount_setattr01
>  
>  move_mount01 move_mount01
>  move_mount02 move_mount02
> +move_mount03 move_mount03
>  
>  move_pages01 move_pages01
>  move_pages02 move_pages02
> diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
> index 83ae40145..ddfe10128 100644
> --- a/testcases/kernel/syscalls/move_mount/.gitignore
> +++ b/testcases/kernel/syscalls/move_mount/.gitignore
> @@ -1,2 +1,3 @@
>  /move_mount01
>  /move_mount02
> +/move_mount03
> diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
> new file mode 100644
> index 000000000..071fd984c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify allow to mount beneath top mount

This should at least reference the following commit:

commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed May 3 13:18:42 2023 +0200

    fs: allow to mount beneath top mount

To be honest I am struggling to understand what all of this
does. However I think that I found some issues with the test which I
have noted below.

> + *
> + */
> +
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "lapi/sched.h"
> +
> +#define MNTPOINTR "mntpoint"
> +#define DIRA "LTP_DIR_A"
> +
> +static void run(void)
> +{
> +	int fd;
> +
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +	SAFE_MKDIR(DIRA, 0777);
> +	SAFE_TOUCH(DIRA "/A", 0, NULL);
> +	/* The parent mnt should be private if check MOVE_MOUNT_BENEATH */
> +	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);

Is it necessary and safe to do this on root? It's not clear what effect
setting all mounts under the present "/" and namespace might have. I
guess it should be possible to create a mount to use as the parent that
is private?

> +	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
> +	fd = SAFE_OPEN(DIRA, O_RDONLY | O_DIRECTORY);

Why do we open this directory? It seems both source and destination can
be paths.

Also it is never closed.

> +
> +	TST_EXP_PASS(move_mount(fd, "", AT_FDCWD, MNTPOINT,
> +				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH));
> +
> +	if (access(MNTPOINT "/A", F_OK) == 0)

So we have mounted mntpoint/LTP_DIR_A at mntpoint (or moved it there),
but we don't expect file A to be there?

> +		tst_res(TFAIL, "mount beneath top mount failed");
> +	else
> +		tst_res(TPASS, "mount beneath top mount pass");

This message doesn't explain what the test is doing. You can probably
use TST_EXP_* here as well.

> +
> +	if (tst_is_mounted_at_tmpdir(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
> +
> +	if (access(MNTPOINT "/A", F_OK) == 0)
> +		tst_res(TPASS, "mount beneath top mount pass");
> +	else
> +		tst_res(TFAIL, "mount beneath top mount failed");
> +

So if MNTPOINT is not under tmpdir we do nothing, but the test now
expects A to exist?

If we always unmount MNTPOINT then this should always fail because we
never created anything at mntpoint/A.

> +	remove(DIRA "/A");

This should probably be SAFE_UNLINK.

> +	SAFE_RMDIR(DIRA);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"fuse", NULL},
> +	.min_kver = "6.5.0"
> +};



-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
