Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5755C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 11:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D6CE3C193C
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:35:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C6AE3C0503
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:35:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A9B051A0060C
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:35:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36A4621279;
 Tue,  5 Aug 2025 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754393715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4C4ot+/V3vW2fAcrHbHegQbh5u+SXE5JZH4+e40E40=;
 b=zDJ8iZgpF7h9o+XDSZnhvcfcQEaK7+TpHYwHbQLVxPRUL/DvRmPpTccwVy0Py9AGiqphzS
 GZ6A0UEmTDhy6kNvbIgX4vjketIiFPRq75690g96OesIQ4FWU+8VeTFyIK21+zzce6E2jD
 wsPx6Ep/tBp6cW533srhmj7dLvE8Z8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754393715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4C4ot+/V3vW2fAcrHbHegQbh5u+SXE5JZH4+e40E40=;
 b=Esrf3VlvUPb/jeSKYba4BF9wo4PpvXzvaEXNOlx1cQN34yh6jwNDfnofM65fltCLExpOWV
 2UuQ0qK/aKIc1tCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754393715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4C4ot+/V3vW2fAcrHbHegQbh5u+SXE5JZH4+e40E40=;
 b=zDJ8iZgpF7h9o+XDSZnhvcfcQEaK7+TpHYwHbQLVxPRUL/DvRmPpTccwVy0Py9AGiqphzS
 GZ6A0UEmTDhy6kNvbIgX4vjketIiFPRq75690g96OesIQ4FWU+8VeTFyIK21+zzce6E2jD
 wsPx6Ep/tBp6cW533srhmj7dLvE8Z8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754393715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4C4ot+/V3vW2fAcrHbHegQbh5u+SXE5JZH4+e40E40=;
 b=Esrf3VlvUPb/jeSKYba4BF9wo4PpvXzvaEXNOlx1cQN34yh6jwNDfnofM65fltCLExpOWV
 2UuQ0qK/aKIc1tCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 228F113A55;
 Tue,  5 Aug 2025 11:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id emRzB3PskWh6dAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Aug 2025 11:35:15 +0000
Date: Tue, 5 Aug 2025 13:36:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJHspF_wL8Su93lV@yuki.lan>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
 <20250805-file_setattr_getattr-v3-4-67a7747d226c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250805-file_setattr_getattr-v3-4-67a7747d226c@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/6] Add file_attr01 test
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
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -246,6 +246,8 @@ fallocate06 fallocate06
>  fsetxattr01 fsetxattr01
>  fsetxattr02 fsetxattr02
>  
> +file_attr01 file_attr01
> +
>  #posix_fadvise test cases
>  posix_fadvise01                      posix_fadvise01
>  posix_fadvise01_64                posix_fadvise01_64
> diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
> new file mode 100644
> index 0000000000000000000000000000000000000000..de06f204d34be482a6401f2a5e7931caa5e3ab12
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/.gitignore
> @@ -0,0 +1 @@
> +file_attr01
> diff --git a/testcases/kernel/syscalls/file_attr/Makefile b/testcases/kernel/syscalls/file_attr/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..3b19b0ce6be00839038c405eea027b0102761e45
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/Makefile
> @@ -0,0 +1,8 @@
> +# Copyright (c) 2025 - Linaro Limited. All rights reserved.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..597ce31fbb11c47754a264eba394be3c233c8663
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that `file_getattr` and `file_setattr` syscalls are raising the
> + * correct errors according to the invalid input arguments. In particular:
> + *
> + * - EBADFD: Invalid file descriptor.
> + * - ENOENT: File doesn't exist
> + * - EFAULT: File name is NULL
> + * - EFAULT: File attributes is NULL
> + * - EINVAL: File attributes size is zero
> + * - E2BIG: File attributes size is too big
> + * - EINVAL: Invalid AT flags
> + */
> +
> +#include <string.h>
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include "lapi/fcntl.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FILENAME "ltp_file"
> +#define NO_FILENAME "ltp_file_doesnt_exist"
> +
> +static int valid_dfd = -1;
> +static int invalid_dfd = -1;
> +static char *valid_filename;
> +static char *invalid_filename;
> +static char *null_ptr;
> +static size_t zero;
> +static size_t valid_usize;
> +static size_t big_usize;
> +static struct file_attr *valid_file_attr;
> +
> +static struct tcase {
> +	int *dfd;
> +	char **filename;
> +	struct file_attr **ufattr;
> +	size_t *usize;
> +	int at_flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		.dfd = &invalid_dfd,

Hmm do we need a tst_fd iterator for this case?

> +		.filename = &valid_filename,
> +		.ufattr = &valid_file_attr,
> +		.usize = &valid_usize,
> +		.exp_errno = EBADF,
> +		.msg = "Invalid file descriptor",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &invalid_filename,
> +		.ufattr = &valid_file_attr,
> +		.usize = &valid_usize,
> +		.exp_errno = ENOENT,
> +		.msg = "File doesn't exist",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &null_ptr,
> +		.ufattr = &valid_file_attr,
> +		.usize = &valid_usize,
> +		.exp_errno = EFAULT,
> +		.msg = "Filename is NULL",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &valid_filename,
> +		.ufattr = (struct file_attr **)(&null_ptr),
> +		.usize = &valid_usize,
> +		.exp_errno = EFAULT,
> +		.msg = "File attributes is NULL",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &valid_filename,
> +		.ufattr = &valid_file_attr,
> +		.usize = &zero,
> +		.exp_errno = EINVAL,
> +		.msg = "File attributes size is zero",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &valid_filename,
> +		.ufattr = &valid_file_attr,
> +		.usize = &big_usize,
> +		.exp_errno = E2BIG,
> +		.msg = "File attributes size is too big",
> +	},
> +	{
> +		.dfd = &valid_dfd,
> +		.filename = &valid_filename,
> +		.ufattr = &valid_file_attr,
> +		.usize = &valid_usize,
> +		.at_flags = -1,
> +		.exp_errno = EINVAL,
> +		.msg = "Invalid AT flags",
> +	},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (tst_variant) {
> +		TST_EXP_FAIL(file_getattr(
> +			*tc->dfd, *tc->filename,
> +			*tc->ufattr, *tc->usize,
> +			tc->at_flags),
> +			tc->exp_errno,
> +			"%s", tc->msg);
> +	} else {
> +		TST_EXP_FAIL(file_setattr(
> +			*tc->dfd, *tc->filename,
> +			*tc->ufattr, *tc->usize,
> +			tc->at_flags),
> +			tc->exp_errno,
> +			"%s", tc->msg);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	valid_dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +
> +	SAFE_CHDIR(MNTPOINT);
> +	SAFE_TOUCH(FILENAME, 0777, NULL);
> +	SAFE_CHDIR("..");
> +
> +	memcpy(valid_filename, FILENAME, strlen(FILENAME));
> +	memcpy(invalid_filename, NO_FILENAME, strlen(NO_FILENAME));

The struct tst_buffers have .str member that if set copies the string,
so instead of .size = 32 you need to pass .str = FILENAME and .str
NO_FILENAME there.

> +	valid_usize = FILE_ATTR_SIZE_LATEST;
> +	big_usize = sysconf(_SC_PAGESIZE) + 100;

Do we need a small_usize that would be one less than smalles
FILE_ATTR_SIZE as well?

> +}
> +
> +static void cleanup(void)
> +{
> +	if (valid_dfd != -1)
> +		SAFE_CLOSE(valid_dfd);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.mntpoint = MNTPOINT,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.test_variants = 2,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		"ntfs",
> +		"vfat",
> +		"exfat",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&valid_filename, .size = 32},
> +		{&invalid_filename, .size = 32},
> +		{&valid_file_attr, .size = sizeof(struct file_attr)},
> +		{}
> +	}
> +};
> 
> -- 
> 2.50.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
