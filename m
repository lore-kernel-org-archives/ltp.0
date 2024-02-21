Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9623C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510A63D0CC0
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:07:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AD9B3D015B
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:06:46 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 161351A00A51
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:06:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B38D61FB61;
 Wed, 21 Feb 2024 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708528004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhjArlG5hlISUMsMYUxML7AqjxMxibrWqtc6qsepCjg=;
 b=PYbF7wS8WQNTFprH8tFmUu3901QFy7EV6eS39GXB1WbODZbo1lW6SP+l79KcZoJEXD0b7J
 LkyfdIXgQz7jE0wj/R4+xEK4Ppqc3hvOFAeQXMGghP1qtaZggv0tXaJIL1nEg2bIQ+Njj7
 qWTgysILU/djS0/A0zBvSym4jraj5fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708528004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhjArlG5hlISUMsMYUxML7AqjxMxibrWqtc6qsepCjg=;
 b=f3o/+0Q4hzJGpix2+L+jrgb9kR6O9kAcsMZBgXGPFwh8H9/EYOPFDYePytv8/I50lneYfm
 aG4Hm1aBXo1xLJDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708528004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhjArlG5hlISUMsMYUxML7AqjxMxibrWqtc6qsepCjg=;
 b=PYbF7wS8WQNTFprH8tFmUu3901QFy7EV6eS39GXB1WbODZbo1lW6SP+l79KcZoJEXD0b7J
 LkyfdIXgQz7jE0wj/R4+xEK4Ppqc3hvOFAeQXMGghP1qtaZggv0tXaJIL1nEg2bIQ+Njj7
 qWTgysILU/djS0/A0zBvSym4jraj5fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708528004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhjArlG5hlISUMsMYUxML7AqjxMxibrWqtc6qsepCjg=;
 b=f3o/+0Q4hzJGpix2+L+jrgb9kR6O9kAcsMZBgXGPFwh8H9/EYOPFDYePytv8/I50lneYfm
 aG4Hm1aBXo1xLJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A38AA139D0;
 Wed, 21 Feb 2024 15:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /kPSJoQR1mV7DAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Feb 2024 15:06:44 +0000
Date: Wed, 21 Feb 2024 16:05:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZdYRQYw-XIPG5CNZ@yuki>
References: <20240219154909.22937-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240219154909.22937-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add lstat03 test
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
> This test has been extracted from symlink01 test and it checks that
> lstat() executed on file provide the same information of symlink
> linking to it.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Remove test_lstat_no_path() test
> TST_EXP_PASS for lstat() and SAFE_SYMLINK for symlink()
> Removed memory leak using tst_get_tmpdir()

The leak is stil there, as far as I can tell.

>  runtest/syscalls                           |  4 +-
>  testcases/kernel/syscalls/lstat/.gitignore |  2 +
>  testcases/kernel/syscalls/lstat/lstat03.c  | 50 ++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/lstat/lstat03.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7794f1465..a7f22d907 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -723,12 +723,12 @@ lseek02 lseek02
>  lseek07 lseek07
>  lseek11 lseek11
>  
> -lstat01A symlink01 -T lstat01
> -lstat01A_64 symlink01 -T lstat01_64
>  lstat01 lstat01
>  lstat01_64 lstat01_64
>  lstat02 lstat02
>  lstat02_64 lstat02_64
> +lstat03 lstat03
> +lstat03_64 lstat03_64
>  
>  mallinfo02 mallinfo02
>  
> diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
> index a497a445f..72cba871f 100644
> --- a/testcases/kernel/syscalls/lstat/.gitignore
> +++ b/testcases/kernel/syscalls/lstat/.gitignore
> @@ -2,3 +2,5 @@
>  /lstat01_64
>  /lstat02
>  /lstat02_64
> +/lstat03
> +/lstat03_64
> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
> new file mode 100644
> index 000000000..30932f1fa
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks that lstat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +	char *tmpdir = tst_get_tmpdir();
> +
> +	SAFE_SYMLINK(tmpdir, symname);
> +
> +	struct stat path_stat;
> +	struct stat link_stat;
> +
> +	TST_EXP_PASS(lstat(tmpdir, &path_stat));
> +	TST_EXP_PASS(lstat(symname, &link_stat));
> +
> +	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
> +	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
> +	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
> +	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
> +	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
> +	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
> +	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
> +
> +	TST_EXP_EXPR(path_stat.st_mode != link_stat.st_mode,
> +		"object and symbolic link have different st_mode");
> +	TST_EXP_EXPR(path_stat.st_size != link_stat.st_size,
> +		"object and symbolic link have different st_size");

Now shouldn't this be the other way around, i.e. we are doing stat on
two different entities and we should concentrate on the parts that are
different?

I guess that one way would be to explicitly set different gid/uid for
the symlink and then check that these values are not equal.

Also if we fill the file with a megabyte of data I'm pretty sure that
st_size will be different from the symlink st_size.

I guess that the inode should differ.

The same for the timestamps, if we go for the more granular timestaps
the creation time would differ.

It's mostly accidental that these values actually match.

> +	SAFE_UNLINK(symname);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
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
