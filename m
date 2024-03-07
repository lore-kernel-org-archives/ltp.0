Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38D9C5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 06:45:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A1E23CE968
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 07:45:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF2C83CC75A
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 07:45:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 288C9201190
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 07:45:30 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79D053F577;
 Thu,  7 Mar 2024 23:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709852640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCIPiGj//dIhpoqAsopm7NlvhrMF4wn+1/UZJtmTVsE=;
 b=vyXevcOXfUfYXuYOi/f3N+G2nnteRXJ/25eo0R28LpI5Ibl6LsNsDQrV81f5SwUGGPkmRi
 CWN3eOOl+uwN0jv0TapobBdfwt5fbaQJUshHWmdQalkDxCVpn+zQAMrbP4l/6oOQmFn++3
 L7kr2MTARlnaDBWA3WGsfJDxVnoH3Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709852640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCIPiGj//dIhpoqAsopm7NlvhrMF4wn+1/UZJtmTVsE=;
 b=IyrbLSMcrZcu0ZOYSBq0ObZC/nWJPq13Qy5lkzWsgYHyaNKEnkbK0T76cdeIfRBYCuuDc2
 4DR1aadVaEGEobAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709852640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCIPiGj//dIhpoqAsopm7NlvhrMF4wn+1/UZJtmTVsE=;
 b=vyXevcOXfUfYXuYOi/f3N+G2nnteRXJ/25eo0R28LpI5Ibl6LsNsDQrV81f5SwUGGPkmRi
 CWN3eOOl+uwN0jv0TapobBdfwt5fbaQJUshHWmdQalkDxCVpn+zQAMrbP4l/6oOQmFn++3
 L7kr2MTARlnaDBWA3WGsfJDxVnoH3Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709852640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCIPiGj//dIhpoqAsopm7NlvhrMF4wn+1/UZJtmTVsE=;
 b=IyrbLSMcrZcu0ZOYSBq0ObZC/nWJPq13Qy5lkzWsgYHyaNKEnkbK0T76cdeIfRBYCuuDc2
 4DR1aadVaEGEobAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4358513997;
 Thu,  7 Mar 2024 23:04:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +CbCDeBH6mUcRgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 23:04:00 +0000
Date: Fri, 8 Mar 2024 00:03:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240307230358.GB218331@pevik>
References: <20240119092308.20337-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119092308.20337-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add rename15 test
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test has been extracted from symlink01 and it verifies that
> rename() is working correctly on symlink() generated files, renaming
> symbolic link and checking if stat() information are preserved.

The original test does 2 things:
1) Create symlink to *non-existing* file, then rename symlink:
symlink("object", "symbolic")           = 0
rename("symbolic", "asymbolic")         = 0

and check struct stat content.

2) Create symlink to *non-existing* file, but then creates the file, so that
it's symlink to an existing file (I would personally first call creat()).

symlink("object", "symbolic")           = 0
creat("object", 0700)                   = 3
rename("symbolic", "asymbolic")         = 0

Therefore you are testing only 2), maybe it'd be worth to test both cases.
I suppose there is no point to test on more file types (directory, char device,
...).

Also, it performs lstat() and then it checks against S_IFLNK,
but we can probably be ok just with safe_symlink(). I'm repeating myself,
because you send these symlink01.c related tests as separate patches, but IMHO
they are related (if v2 is needed it might make sense to sent all you sent in a
patchset, not separate).


> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/smoketest                           |  2 +-
>  runtest/syscalls                            |  2 +-
>  testcases/kernel/syscalls/rename/.gitignore |  1 +
>  testcases/kernel/syscalls/rename/rename15.c | 41 +++++++++++++++++++++
>  4 files changed, 44 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/rename/rename15.c

> diff --git a/runtest/smoketest b/runtest/smoketest
> index 83eebfe7b..19fa257d6 100644
> --- a/runtest/smoketest
> +++ b/runtest/smoketest
> @@ -10,7 +10,7 @@ write01 write01
>  symlink01 symlink01
>  stat04 symlink01 -T stat04
>  utime01A symlink01 -T utime01
> -rename01A symlink01 -T rename01
> +rename15 rename15
>  splice02 splice02 -s 20
>  df01_sh df01.sh
>  shell_test01 echo "SUCCESS" | shell_pipe01.sh
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6e2407879..ae058153b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1158,7 +1158,6 @@ removexattr01 removexattr01
>  removexattr02 removexattr02

>  rename01 rename01
> -rename01A symlink01 -T rename01
>  rename03 rename03
>  rename04 rename04
>  rename05 rename05
> @@ -1171,6 +1170,7 @@ rename11 rename11
>  rename12 rename12
>  rename13 rename13
>  rename14 rename14
> +rename15 rename15

>  #renameat test cases
>  renameat01 renameat01
> diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
> index f95cf7d21..d17b80f09 100644
> --- a/testcases/kernel/syscalls/rename/.gitignore
> +++ b/testcases/kernel/syscalls/rename/.gitignore
> @@ -11,3 +11,4 @@
>  /rename12
>  /rename13
>  /rename14
> +/rename15
> diff --git a/testcases/kernel/syscalls/rename/rename15.c b/testcases/kernel/syscalls/rename/rename15.c
> new file mode 100644
> index 000000000..ae7f330b6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rename/rename15.c
> @@ -0,0 +1,41 @@
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
> + * This test verifies that rename() is working correctly on symlink()
> + * generated files, renaming symbolic link and checking if stat() information
> + * are preserved.
> + */
> +

very nit: maybe it'd be safer to actually use headers which are needed.
One day, if we rewrite library, we will have to keep all the headers in
tst_test.h, even not needed in the library, because tests starts to depend on
it.

#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	char *oldname = "my_symlink0";
> +	char *newname = "asymlink";

These aren't modified, how about use:

#define OLDNAME "my_symlink0"
#define NEWNAME "asymlink"

> +	struct stat oldsym_stat;
> +	struct stat newsym_stat;
> +
> +	SAFE_SYMLINK(tst_get_tmpdir(), oldname);
Again, this looks to be a memory leak.

It's noted in the headers, but IMHO it should be added to the docs:
https://github.com/linux-test-project/ltp/wiki/C-Test-API
https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
and/or even write sparse check.

include/tst_test.h
/*
 * Returns path to the test temporary directory in a newly allocated buffer.
 */
char *tst_get_tmpdir(void);

include/old/old_tmpdir.h
/* tst_get_tmpdir()
 *
 * Return a copy of the test temp directory as seen by LTP. This is for
 * path-oriented tests like chroot, etc, that may munge the path a bit.
 *
 * FREE VARIABLE AFTER USE IF IT IS REUSED!
 */
char *tst_get_tmpdir(void);

Alternatives would be: 1) use "." (relative path instead of absolute,
2) call it in the setup function.

> +	SAFE_STAT(oldname, &oldsym_stat);
> +
> +	SAFE_RENAME(oldname, newname);
> +	SAFE_STAT(newname, &newsym_stat);
> +
> +	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
> +	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
> +
> +	SAFE_UNLINK(newname);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
