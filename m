Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A6C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:47:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CB263CFDB2
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 17:47:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EF253CFD7A
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 17:46:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6838A1A00A2E
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 17:46:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41F5A5D858;
 Fri, 19 Apr 2024 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713541607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YE+xGAv17IDxe2XM8gTT4L9LO9z1WCz24+7GXnB7i4Q=;
 b=aLMMFfnlZMBP8pig0lMgQv9Ytu8Tsyc7bUzMyB7imiAZ+nmfv5D5HJXfVs5qAXjmjVhcmS
 J3bZeiZzSg47PQpvJCPdaCj2/0nXx8Zj2a0y7g3h8kT54ZldqzMpXIlPPikq6+Wiv1VwEZ
 BH/ekJnNAyF4q/rnHcHFzwl28ZabVFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713541607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YE+xGAv17IDxe2XM8gTT4L9LO9z1WCz24+7GXnB7i4Q=;
 b=EcFHQEnqzW383WTBWVTwYYRAfSCt3WzGHxmnYV5aJpu54FBITa2zRe8i4APMQtY49i2BxO
 K7+wgyom1y2tnIBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713541606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YE+xGAv17IDxe2XM8gTT4L9LO9z1WCz24+7GXnB7i4Q=;
 b=Bp2HQdK30/KXD0KPK5wrBKNlNq/MWTWTJZ69doFvPb5llUdYupXYFJJKjrnDzBZhinBaeG
 9ggPl/dE84xt64yXI2deCloQpa13MXcR00GfvxjQ+hBtUXC5ZoTMYT3q9zYx8OG1NKcaN9
 taIy5DRxRBnovYhSlhKLmWf0rt2+Vtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713541606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YE+xGAv17IDxe2XM8gTT4L9LO9z1WCz24+7GXnB7i4Q=;
 b=+iClnmQhaAKBTduJmxhM85RLo7eYtGt9v20ohVIgQrED9Cn7aEX6wT6LCTVXiCRHuRRwMV
 vELZqPNK/abTedCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26A46136CF;
 Fri, 19 Apr 2024 15:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cpQ5COaRImahBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Apr 2024 15:46:46 +0000
Date: Fri, 19 Apr 2024 17:46:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <ZiKRuBi8tfoGeS0c@yuki>
References: <20240419070717.2506101-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240419070717.2506101-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email, suse.cz:email,
 configure.ac:url, linux.it:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add case about arch_prctl syscall.
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
First of all do 'make check' in the directory with the test source and
fix all errors and warnings.

> Signed-off-by: Lu Fei <lufei@uniontech.com>
> ---
>  configure.ac                                  |  1 +
>  .../kernel/syscalls/arch_prctl/.gitignore     |  1 +
>  testcases/kernel/syscalls/arch_prctl/Makefile |  8 +++
>  .../kernel/syscalls/arch_prctl/arch_prctl01.c | 56 +++++++++++++++++++

This is missing a runtest entry, i.e. line in the runtest/syscalls file
that tells the test execution framework to run the test.

>  4 files changed, 66 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/arch_prctl/.gitignore
>  create mode 100644 testcases/kernel/syscalls/arch_prctl/Makefile
>  create mode 100644 testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
> 
> diff --git a/configure.ac b/configure.ac
> index 1d7e862d8..0dcaddc0f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -41,6 +41,7 @@ AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
>  
>  AC_CHECK_HEADERS_ONCE([ \
>      asm/ldt.h \
> +    asm/prctl.h \
>      cpuid.h \
>      emmintrin.h \
>      ifaddrs.h \
> diff --git a/testcases/kernel/syscalls/arch_prctl/.gitignore b/testcases/kernel/syscalls/arch_prctl/.gitignore
> new file mode 100644
> index 000000000..24871e249
> --- /dev/null
> +++ b/testcases/kernel/syscalls/arch_prctl/.gitignore
> @@ -0,0 +1 @@
> +/arch_prctl01
> diff --git a/testcases/kernel/syscalls/arch_prctl/Makefile b/testcases/kernel/syscalls/arch_prctl/Makefile
> new file mode 100644
> index 000000000..272949d57
> --- /dev/null
> +++ b/testcases/kernel/syscalls/arch_prctl/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) UnionTech Software Technology Co.,Ltd. 2024
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
> new file mode 100644
> index 000000000..06b3d99b8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* 
> + * Copyright (c) UnionTech Software Technology Co.,Ltd., 2024
> + * Author: Lu Fei <lufei@uniontech.com>
> + */
> +
> +/* 

This has to be /*\ so that the docparse comment gets picked up by the
documentation parser and shows up in docparse/metadata.html

> + * [Description]
> + *
> + * Simple test on arch_prctl to set and get cpuid instruction of test thread.
> + */
> +
> +# include "tst_test.h"
> +# include "lapi/syscalls.h"
> +# include <stdlib.h>
> +# ifdef HAVE_ASM_PRCTL_H
> +# include <asm/prctl.h>

No spaces after # here please.

> +static int arch_prctl_get(int code, unsigned long *addr) {
> +	return tst_syscall(__NR_arch_prctl, code, *addr);
> +}
> +
> +static int arch_prctl_set(int code, unsigned long addr) {
> +	return tst_syscall(__NR_arch_prctl, code, addr);
> +}
> +
> +static int tc[] = {0,1};
> +
> +static void run(unsigned int index){
> +
> +	unsigned long *addr = malloc(sizeof(long));

This does not need to be allocated, we can just do unsigned long addr
and pass &addr to the calls.

> +	TEST(arch_prctl_set(ARCH_SET_CPUID, tc[index]));
> +
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "set %s cpuid",tc[index] ? "enable" : "disable");
> +	else
> +		tst_res(TFAIL, "failed to set cpuid");

This should use TST_EXP_PASS(arch_prctl_set(...))

> +	TEST(arch_prctl_get(ARCH_GET_CPUID, addr));

This as well.

> +	if (TST_RET == tc[index])

This is wrong, the value should be stored the addr parameter, TST_RET
should be 0 on success.


> +		tst_res(TPASS, "get cpuid succeed.");
> +	else
> +		tst_res(TFAIL, "get cpuid failed.");
> +}
> +
> +static struct tst_test test = {
> +    .test = run,
> +    .tcnt = 2,
> +    .min_kver = "4.11",

This should have .supported_archs = {"x86", "x86-64", NULL},

> +};
> +
> +#else /* HAVE_ASM_PRCTL_H */
> +TST_TEST_TCONF("missing <asm/prctl.h>");
> +#endif
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
