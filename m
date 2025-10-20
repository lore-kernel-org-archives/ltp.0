Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D89BCCD199
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 14:17:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AA313CEFA2
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 16:17:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40EA93CEF2D
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 16:16:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEE002005FF
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 16:16:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9901021181;
 Mon, 20 Oct 2025 14:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760969812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/gSGIaoyLEUSU6Lr48ZQSUb7oGhFez0lijxuA/SmMM=;
 b=WPFWA9SN9Pf9pIXsayu5o54IjGcIp6+WhrcZfjBq5Wu9oTCDrBec2fxNVVwYLB7o863hE+
 HMJ9eRTzg0Uki9XAOJrZQuOqvki29W+aEDbvLKyTSyqjFsdxlajGx3oRtkFVBKNCbCww8o
 FFVZB1Gl5TKsFHUiawYHuCOATV8XOJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760969812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/gSGIaoyLEUSU6Lr48ZQSUb7oGhFez0lijxuA/SmMM=;
 b=qoOYblLJcAO20ubnnoA9uIyuxwZhrp97qoE62q3EeeHvrN6AFF6KvkHunpjZGoSTGc4t0w
 3MCmVAI72NK9ccAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FxLc8P+x;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="xTQk/DuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760969808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/gSGIaoyLEUSU6Lr48ZQSUb7oGhFez0lijxuA/SmMM=;
 b=FxLc8P+xk5BUQYPE0jNXRuI4lianBG1DRSiZqCneCETrU46VgMYl5GneNBWhNsdq/4b/gH
 xVVtpyBdKZVxegaErELbwML8au2anztcmu0p5/uENpoAR4Z4MTa+geFe2r0zoA8KVA7b+I
 UVn0bsPn8pDcnXcxNKcXESD3D5xZ7kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760969808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/gSGIaoyLEUSU6Lr48ZQSUb7oGhFez0lijxuA/SmMM=;
 b=xTQk/DuAESqL1x6KAjYSUIMAX0wlOp/b3twDPHISh8fmtZG5y8Ckrh2QaNN8MKJrXcxqGI
 JtLUdoAPCr4yH+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 781E613AAC;
 Mon, 20 Oct 2025 14:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m+ubG1BE9miEGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Oct 2025 14:16:48 +0000
Date: Mon, 20 Oct 2025 16:16:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20251020141643.GA404362@pevik>
References: <20251001145600.24767-1-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251001145600.24767-1-jack@suse.cz>
X-Rspamd-Queue-Id: 9901021181
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,linaro.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] name_to_handle_at: Add test cases for
 AT_HANDLE_FID
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

Hi Jan,

> Add a few testcases verifying AT_HANDLE_FID flag.

Thanks for keeping tests updated, we really appreciate that.
I wonder if the functionality got merged.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/lapi/fcntl.h                          |  4 +
>  .../name_to_handle_at/name_to_handle_at03.c   | 88 +++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c

> This is actually a testcase for a kernel regression, the kernel fix is on the
> way.

> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> index 7c050248892e..55a5e8b40432 100644
> --- a/include/lapi/fcntl.h
> +++ b/include/lapi/fcntl.h
> @@ -98,6 +98,10 @@
>  # define AT_HANDLE_FID		AT_REMOVEDIR
>  #endif

> +#ifndef AT_HANDLE_CONNECTABLE
> +# define AT_HANDLE_CONNECTABLE	0x002
> +#endif
> +
>  #ifndef AT_SYMLINK_FOLLOW
>  # define AT_SYMLINK_FOLLOW	0x400
>  #endif
> diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c
> new file mode 100644
> index 000000000000..4a6df5e46fd7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * Basic name_to_handle_at() tests.
> + *
> + * [Algorithm]
nit: unrelated to the test subject. Here needs to be a blank line, otherwise
following lines aren't recognised as list, but they remain inline (RST format
used for spinx).

> + *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
> + *  - Check that we were able to access a file's stat with name_to_handle_at()
> + *    and open_by_handle_at().
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/stat.h>
> +#include "lapi/name_to_handle_at.h"
> +
> +#define TEST_FILE "test_file"
> +
> +static int fd_atcwd = AT_FDCWD;
> +static struct file_handle *fhp;
> +
> +static struct tcase {
> +	const char *name;
> +	int *dfd;
> +	const char *pathname;
> +	int name_flags;
> +	int exp_errno;
> +} tcases[] = {
> +	{"test-file", &fd_atcwd, TEST_FILE, AT_HANDLE_FID, 0},
> +	{"unexportable-file", &fd_atcwd, "/proc/filesystems", AT_HANDLE_FID, 0},
> +	{"test-file-connectable", &fd_atcwd, TEST_FILE, AT_HANDLE_FID | AT_HANDLE_CONNECTABLE, EINVAL},
> +};
> +
> +static bool handle_type_supported(unsigned int flag, const char *name)
> +{
> +	if (name_to_handle_at(-1, ".", NULL, NULL, flag) && errno == EINVAL) {
> +		tst_brk(TCONF, "%s not supported by the kernel.", name);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +#define REQUIRE_HANDLE_TYPE_SUPPORT(flag) handle_type_supported(flag, #flag)
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(TEST_FILE, 0600, NULL);
> +	fhp = malloc(MAX_HANDLE_SZ);
> +	if (!fhp)
> +		tst_brk(TBROK, "malloc failed");
> +
> +	REQUIRE_HANDLE_TYPE_SUPPORT(AT_HANDLE_FID);
> +	REQUIRE_HANDLE_TYPE_SUPPORT(AT_HANDLE_CONNECTABLE);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int mount_id;
> +
> +	fhp->handle_bytes = MAX_HANDLE_SZ;
> +	TEST(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
> +			       tc->name_flags));
> +	if (!tc->exp_errno) {
> +		if (TST_RET)
> +			tst_res(TFAIL | TTERRNO, "%s: name_to_handle_at() failed", tc->name);
> +		else
> +			tst_res(TPASS, "%s: name_to_handle_at() passed", tc->name);
> +		return;

nit: We have TST_EXP_PASS() ...

> +	}
> +
> +	if (TST_RET != -1)
> +		tst_res(TFAIL, "%s: name_to_handle_at() unexpectedly succeeded", tc->name);
> +	else if (TST_ERR != tc->exp_errno)
> +		tst_res(TFAIL | TTERRNO, "%s: name_to_handle_at() should fail with errno %s",
> +			tc->name, tst_strerrno(tc->exp_errno));
> +	else
> +		tst_res(TPASS, "%s: name_to_handle_at() failed as expected", tc->name);

... and TST_EXP_FAIL() to simplify. Something like should work (untested):

if (!tc->exp_errno) {
	TST_EXP_PASS(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
				       tc->name_flags));
	return;
} else {
	TST_EXP_FAIL(name_to_handle_at(*tc->dfd, tc->pathname, fhp, &mount_id,
				       tc->name_flags), tc->exp_errno);
}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
