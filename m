Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480BDC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 09:21:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EDE03CB098
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 11:21:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94D383C03F4
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 11:21:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C96D01A007AE
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 11:21:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A38E1F74C;
 Fri, 11 Jul 2025 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752225668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Q8pE+20EJpBndvx8qPau99A9KRKDKORzWYtGceMay8=;
 b=RPXNp9MIR2S+lbB/jDDdKoRmDiKICUBMqOxDHfPi4RsN85VpGBSwIzCfiombz18ou7DLFv
 C2Z1Xucsn3aqZIetcn/uFPmBv8cNSoy+Y8fAXDz3M9hkkH7j7nu1vM5ZBw94aC4izzh061
 QRHQwfvLIREcskzC8sefFoQqG8IjS+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752225668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Q8pE+20EJpBndvx8qPau99A9KRKDKORzWYtGceMay8=;
 b=ugpRbJxR0bHInysY9SNNPKFDJm4FswO0Ep0+lWlWFLdol2+PKFiBqCVCYIDlhXlPnOBRoA
 XL1XymLdASjvZcDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752225668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Q8pE+20EJpBndvx8qPau99A9KRKDKORzWYtGceMay8=;
 b=RPXNp9MIR2S+lbB/jDDdKoRmDiKICUBMqOxDHfPi4RsN85VpGBSwIzCfiombz18ou7DLFv
 C2Z1Xucsn3aqZIetcn/uFPmBv8cNSoy+Y8fAXDz3M9hkkH7j7nu1vM5ZBw94aC4izzh061
 QRHQwfvLIREcskzC8sefFoQqG8IjS+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752225668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Q8pE+20EJpBndvx8qPau99A9KRKDKORzWYtGceMay8=;
 b=ugpRbJxR0bHInysY9SNNPKFDJm4FswO0Ep0+lWlWFLdol2+PKFiBqCVCYIDlhXlPnOBRoA
 XL1XymLdASjvZcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 685CC1388B;
 Fri, 11 Jul 2025 09:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tfuKGITXcGhbagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 09:21:08 +0000
Date: Fri, 11 Jul 2025 11:21:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aHDXqyMUZ_KdNV1U@yuki.lan>
References: <20250219082954.23552-1-wegao@suse.com>
 <20250319114144.24349-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319114144.24349-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, linux.it:url, suse.com:email,
 yuki.lan:mid, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mount_setattr02.c: Check mount_setattr attr
 propagation
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
>  move_mount01 move_mount01
>  move_mount02 move_mount02
> diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
> index 52a77b9ca..1654f27de 100644
> --- a/testcases/kernel/syscalls/mount_setattr/.gitignore
> +++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
> @@ -1 +1,2 @@
>  /mount_setattr01
> +/mount_setattr02
> diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> new file mode 100644
> index 000000000..fcc088e3b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Basic mount_setattr() test.
> + *
> + * Test basic propagation mount attributes are set correctly.

This is too sparse. We should at least write here which parameters we
are testing, obviously the test is checking if the propagation field of
the structure is handled properly.

And then we should list what we are trying to test

- When propagation is set to 0 it's not changed
- EINVAL with propagation set to -1
- MS_SHARED turns propagation on
- MS_PRIVATE turns propagation off
...

> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/statvfs.h>
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "tst_safe_stdio.h"
> +
> +static char *tmpdir;
> +
> +static int mounted;
> +
> +static bool is_shared_mount(const char *path)
> +{
> +	FILE *file = SAFE_FOPEN("/proc/self/mountinfo", "r");
> +
> +	char line[PATH_MAX];
> +	bool found = false;
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		char mntpoint[PATH_MAX];
> +		char opts[256];
> +
> +		if (sscanf(line, "%*d %*d %*d:%*d %*s %255s %*s %255s",
> +					mntpoint, opts) != 2)
> +			continue;
> +
> +		if (strcmp(mntpoint, path) != 0)
> +			continue;
> +
> +		if (strstr(opts, "shared:") != NULL) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	fclose(file);
> +	return found;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mounted)
> +		SAFE_UMOUNT(tmpdir);
> +}
> +
> +static void setup(void)
> +{
> +	tmpdir = tst_tmpdir_path();
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> +	SAFE_MOUNT("testing", tmpdir, "tmpfs", MS_NOATIME | MS_NODEV, "");
                     ^
		     We tend to include ltp in names that are visible on
		     the system so that's clear where they came from.

		     It would be a bit better if the name of the mount
		     was "ltp-mount_setattr" or something that makes it clear
		     which test was mounting it.
> +	mounted = 1;
> +}
> +
> +static void run(void)
> +{
> +	struct mount_attr attr = {
> +		.attr_set       = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
> +		.attr_clr       = MOUNT_ATTR__ATIME,


I suppose that we can as well set these to zero as we are trying to test
only the propagation part. Or is there a reason why we are specifying
any attributes here?

> +	};
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
> +
> +	attr.propagation = -1;
> +	TST_EXP_FAIL_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)), EINVAL);
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
> +
> +	attr.propagation = MS_SHARED;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 1);

Here we should once more check with propagation = 0 and expect that the
mount is shared after that call.

> +	attr.propagation = MS_PRIVATE;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
> +
> +	attr.propagation = MS_SLAVE;
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);

Can we figure out slave mount from the mountinfo? I suppose there will
be slave in in the opts.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
