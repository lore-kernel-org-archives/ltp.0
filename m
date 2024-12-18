Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDDE77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03C533ED621
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:55:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4583ECA3B
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:55:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A05D1412A35
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:55:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C9B121137;
 Wed, 18 Dec 2024 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/hs24JB/Nu1rWgyKLgsHtX0FUD7LQFh6U6UCJekXeo=;
 b=duW5YNqAaodQ1dnfriPnmgI93mL5sUP+XfgDYeHAYtrDCB689rMnLVi+S+v05dutM/qn1z
 0kRbY7m8uEd6VclOch1Zlc2awC/gnw0XsFoWA4Zuxx82DUfgmzImhuNpxaaUs6NM2c0/d3
 KaRlecbR2Qp14CUgAOf/AGr+9JRb92E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/hs24JB/Nu1rWgyKLgsHtX0FUD7LQFh6U6UCJekXeo=;
 b=vXrIGp1xbI/EDzmN+wnrQiYo0DABG1p0qz0r8bvC1uZ/+iyA/jnUBLTNeuOvNhHZ9edrhy
 6CBEdZGh5xEYW8Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=duW5YNqA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vXrIGp1x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/hs24JB/Nu1rWgyKLgsHtX0FUD7LQFh6U6UCJekXeo=;
 b=duW5YNqAaodQ1dnfriPnmgI93mL5sUP+XfgDYeHAYtrDCB689rMnLVi+S+v05dutM/qn1z
 0kRbY7m8uEd6VclOch1Zlc2awC/gnw0XsFoWA4Zuxx82DUfgmzImhuNpxaaUs6NM2c0/d3
 KaRlecbR2Qp14CUgAOf/AGr+9JRb92E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/hs24JB/Nu1rWgyKLgsHtX0FUD7LQFh6U6UCJekXeo=;
 b=vXrIGp1xbI/EDzmN+wnrQiYo0DABG1p0qz0r8bvC1uZ/+iyA/jnUBLTNeuOvNhHZ9edrhy
 6CBEdZGh5xEYW8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE11B137CF;
 Wed, 18 Dec 2024 18:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JeerKo0aY2csdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Dec 2024 18:55:09 +0000
Date: Wed, 18 Dec 2024 19:55:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241218185508.GA77804@pevik>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-2-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-2-e293a8d99cf6@suse.com>
X-Rspamd-Queue-Id: 0C9B121137
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add lsm_get_self_attr01 test
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
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

[ Cc Casey, the author of the syscalls and kselftest tests ]

> Verify that lsm_get_self_attr syscall is raising errors when invalid
> data is provided.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |  2 +
>  testcases/kernel/syscalls/lsm/Makefile             |  7 ++
>  testcases/kernel/syscalls/lsm/lsm_common.h         | 57 +++++++++++++++
>  .../kernel/syscalls/lsm/lsm_get_self_attr01.c      | 81 ++++++++++++++++++++++

You miss the change in .gitignore. You added it in the next commit. Could you
please before merge rebase, so that it's added for lsm_get_self_attr01 in this
commit? (in case of some revert).

>  4 files changed, 147 insertions(+)

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 5fd62617df1a116b1d94c57ff30f74693320a2ab..d59faf08a3f36b5f64d56952f69641191c70bf33 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -756,6 +756,8 @@ lseek02 lseek02
>  lseek07 lseek07
>  lseek11 lseek11

> +lsm_get_self_attr01 lsm_get_self_attr01
> +
>  lstat01 lstat01
>  lstat01_64 lstat01_64
>  lstat02 lstat02
> diff --git a/testcases/kernel/syscalls/lsm/Makefile b/testcases/kernel/syscalls/lsm/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..8cf1b9024d8bdebe72408c90fef4b8b84ce9dc4b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/lsm/lsm_common.h b/testcases/kernel/syscalls/lsm/lsm_common.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..33ddda13720d843907404662e6c6dc72ffac3233
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_common.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef LSM_GET_SELF_ATTR_H
> +#define LSM_GET_SELF_ATTR_H
> +
> +#include "tst_test.h"
> +#include "lapi/lsm.h"
> +
> +static inline struct lsm_ctx *next_ctx(struct lsm_ctx *tctx)
> +{
> +	return (struct lsm_ctx *)((void *)tctx + sizeof(*tctx) + tctx->ctx_len);
> +}
> +
> +static inline void read_proc_attr(const char *attr, char *val, const size_t size)
> +{
> +	int fd;
> +	char *ptr;
> +	char path[BUFSIZ];
> +
> +	memset(val, 0, size);
> +	memset(path, 0, BUFSIZ);
> +
> +	snprintf(path, BUFSIZ, "/proc/self/attr/%s", attr);
> +
> +	tst_res(TINFO, "Reading %s", path);
> +
> +	fd = SAFE_OPEN(path, O_RDONLY);
> +
> +	if (read(fd, val, size) > 0) {
> +		ptr = strchr(val, '\n');
> +		if (ptr)
> +			*ptr = '\0';
> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static inline int verify_enabled_lsm(const char *name)
> +{
> +	int fd;
> +	char data[BUFSIZ];
> +
> +	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
> +	SAFE_READ(0, fd, data, BUFSIZ);
> +	SAFE_CLOSE(fd);
> +
> +	if (!strstr(data, name)) {
> +		tst_res(TINFO, "%s is running", name);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2317941af1b73240368820e6a51591e7c18cc140
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that lsm_get_self_attr syscall is raising errors when invalid data is
> + * provided.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/lsm.h"
> +
> +static struct lsm_ctx *ctx;
> +static uint32_t ctx_size;
> +static uint32_t ctx_size_small;
> +
> +static struct tcase {
> +	uint32_t attr;
.attr = LSM_ATTR_CURRENT is the same for all 4 testcases.
Can you please remove it from the test struct and use it directly?

> +	struct lsm_ctx **ctx;
The same applies to ctx.

Also, kselftest test tools/testing/selftests/lsm/lsm_get_self_attr_test.c is
testing also for ctx being NULL. Then it would make sense to use it.
You would then need to use verify_enabled_lsm(), which you added in this commit
but not use it (e.g. lsm_get_self_attr_test.c in kselftest checks for values
when no lsm is set). Obviously you would have to store also errno for the case
when lsm is not stored.

On some Tumbleweed VM (6.10.0-rc7) I have the default:

$ cat /sys/kernel/security/lsm
lockdown,capability,landlock,yama,apparmor,bpf,ima,evm

When I boot with lsm= kernel parameter, I get:

$ cat /sys/kernel/security/lsm
lockdown,capability,ima,evm

And with that test fails:

# ./lsm_get_self_attr01
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:1893: TINFO: LTP version: 20240930-146-gccd20cd77
tst_test.c:1897: TINFO: Tested kernel: 6.10.0-rc7-3.g92abc10-default #1 SMP PREEMPT_DYNAMIC Wed Jul 10 14:15:11 UTC 2024 (92abc10) x86_64
tst_test.c:1728: TINFO: Timeout per run is 0h 00m 30s
lsm_get_self_attr01.c:67: TPASS: size is NULL : EINVAL (22)
lsm_get_self_attr01.c:67: TPASS: flags is invalid : EINVAL (22)
lsm_get_self_attr01.c:67: TFAIL: size is too smal expected E2BIG: EOPNOTSUPP (95)
lsm_get_self_attr01.c:67: TPASS: flags force to use ctx attributes : EINVAL (22)

=> I would vote for having 2 variants to use EOPNOTSUPP or at least check with
verify_enabled_lsm() and TCONF. Otherwise sooner or later somebody report a bug
in the test.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	uint32_t *size;
> +	uint32_t flags;
> +	int exp_err;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.exp_err = EINVAL,
> +		.msg = "size is NULL",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.flags = LSM_FLAG_SINGLE | (LSM_FLAG_SINGLE << 1),
> +		.exp_err = EINVAL,
> +		.msg = "flags is invalid",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size_small,
> +		.exp_err = E2BIG,
> +		.msg = "size is too smal",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.flags = LSM_FLAG_SINGLE,
> +		.exp_err = EINVAL,
> +		.msg = "flags force to use ctx attributes",
> +	},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	memset(ctx, 0, sizeof(struct lsm_ctx));
> +	ctx_size = sizeof(struct lsm_ctx);
> +	ctx_size_small = 1;
> +
> +	TST_EXP_FAIL(lsm_get_self_attr(
> +		LSM_ATTR_CURRENT, *tc->ctx, tc->size, tc->flags),
> +		tc->exp_err,
> +		"%s", tc->msg);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.min_kver = "6.8",
> +	.bufs = (struct tst_buffers[]) {
> +		{&ctx, .size = sizeof(struct lsm_ctx)},
> +		{}
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
