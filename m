Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4C5C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 18:14:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 921733D0050
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 19:14:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B2F3CDC97
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 19:14:15 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B5882010FA
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 19:14:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41BE233AE4;
 Mon,  4 Mar 2024 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709576053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+x2mb+IadlOyrm1cHC7CRYGij3eMjjbRQ5L17stDVOA=;
 b=Bxeol1zmsENcN6a6unbL8VUA4hW6RLxig725CIPcJWzaDP/1m/3DEPBl/kjik/9Jia3rVi
 LFb4UaeRmN5j1H4wZRmKuJf2/xZuQ/JWX7UU4wyuuvc8pGRx3nuegB4d25oHzsbKiwklZM
 3mBg38HxeSHfTlxASiaQCoImXapVycc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709576053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+x2mb+IadlOyrm1cHC7CRYGij3eMjjbRQ5L17stDVOA=;
 b=EMfTQNKeQ5alIvw7RGFrcu8z1/QPNGJGzpgDKEU48Y4+tZg/Ah7WfjM8Jfx+anyxvX2CJG
 zL7BQKor663ff2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709576053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+x2mb+IadlOyrm1cHC7CRYGij3eMjjbRQ5L17stDVOA=;
 b=Bxeol1zmsENcN6a6unbL8VUA4hW6RLxig725CIPcJWzaDP/1m/3DEPBl/kjik/9Jia3rVi
 LFb4UaeRmN5j1H4wZRmKuJf2/xZuQ/JWX7UU4wyuuvc8pGRx3nuegB4d25oHzsbKiwklZM
 3mBg38HxeSHfTlxASiaQCoImXapVycc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709576053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+x2mb+IadlOyrm1cHC7CRYGij3eMjjbRQ5L17stDVOA=;
 b=EMfTQNKeQ5alIvw7RGFrcu8z1/QPNGJGzpgDKEU48Y4+tZg/Ah7WfjM8Jfx+anyxvX2CJG
 zL7BQKor663ff2BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18669139C6;
 Mon,  4 Mar 2024 18:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id O9OhBHUP5mUqGgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 18:14:13 +0000
Date: Mon, 4 Mar 2024 19:14:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240304181411.GC3191855@pevik>
References: <20240119091612.17595-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119091612.17595-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bxeol1zm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EMfTQNKe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 41BE233AE4
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add utime07 test
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

Hi Andrea,

> This test has been extracted from symlink01 test and it verifies that
> utime() is working correctly on symlink() generated files.

According to VFS doc [1] VFS does open(2), stat(2), read(2), write(2), chmod(2).
Although the main comparison is done through stat(), it's about utime on
symlink.  struct inode_operations described in the docs contain also symlink and
update_time callbacks (filesystem specific). Wouldn't it make sense to run this
on all_filesystems?

[1] https://www.kernel.org/doc/html/latest/filesystems/vfs.html

..
> +++ b/runtest/smoketest
> @@ -9,7 +9,7 @@ wait02 wait02
>  write01 write01
>  symlink01 symlink01
>  stat04 symlink01 -T stat04
> -utime01A symlink01 -T utime01
> +utime07 utime07
>  rename01A symlink01 -T rename01
>  splice02 splice02 -s 20
>  df01_sh df01.sh
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6e2407879..5fd107e35 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1676,12 +1676,12 @@ ustat01 ustat01
>  ustat02 ustat02

>  utime01 utime01
> -utime01A symlink01 -T utime01
>  utime02 utime02
>  utime03 utime03
>  utime04 utime04
>  utime05 utime05
>  utime06 utime06
> +utime07 utime07

>  utimes01 utimes01

> diff --git a/testcases/kernel/syscalls/utime/.gitignore b/testcases/kernel/syscalls/utime/.gitignore
> index 94c0ae07c..403764521 100644
> --- a/testcases/kernel/syscalls/utime/.gitignore
> +++ b/testcases/kernel/syscalls/utime/.gitignore
> @@ -4,3 +4,4 @@
>  /utime04
>  /utime05
>  /utime06
> +/utime07
> diff --git a/testcases/kernel/syscalls/utime/utime07.c b/testcases/kernel/syscalls/utime/utime07.c
> new file mode 100644
> index 000000000..eaf832099
> --- /dev/null
> +++ b/testcases/kernel/syscalls/utime/utime07.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson

nit: original test is v2 only. But we are writing from scratch, using a previous
just as an inspiration. I suppose we still need to use the original copyright
and likely also the license v2 only.


> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that utime() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include <utime.h>
> +#include "tst_test.h"
> +
> +static void test_utime(void)
> +{
> +	char *symname = "my_symlink0";
> +	struct stat oldsym_stat;
> +	struct stat newsym_stat;
> +
> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
Original test actually also perform lstat() on the symlink
and checks for S_IFLNK. You consider SAFE_SYMLINK() enough?

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	SAFE_STAT(symname, &oldsym_stat);
> +
> +	struct utimbuf utimes = {
> +		.actime = oldsym_stat.st_atime + 100,
> +		.modtime = oldsym_stat.st_mtime + 100
> +	};
> +
> +	TST_EXP_PASS(utime(symname, &utimes));
> +	SAFE_STAT(symname, &newsym_stat);
> +
> +	time_t temp, diff;
> +
> +	temp = newsym_stat.st_atime - oldsym_stat.st_atime;
> +	diff = newsym_stat.st_mtime - oldsym_stat.st_mtime - temp;
> +
> +	TST_EXP_EQ_LI(diff, 0);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_utime_no_path(void)
> +{
> +	char *symname = "my_symlink1";
> +	struct utimbuf utimes;
> +
> +	SAFE_SYMLINK("bc+eFhi!k", symname);
> +	TST_EXP_FAIL(utime(symname, &utimes), ENOENT);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_utime_loop(void)
> +{
> +	char *symname = "my_symlink2";
> +	struct utimbuf utimes;
> +
> +	SAFE_SYMLINK(symname, symname);
> +	TST_EXP_FAIL(utime(symname, &utimes), ELOOP);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void run(void)
> +{
> +	test_utime();
> +	test_utime_no_path();
> +	test_utime_loop();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
