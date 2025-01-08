Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFD2E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 12:48:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 283063C1BB4
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:48:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81B303C0325
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:48:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33F87600CC2
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:48:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD6781F385;
 Wed,  8 Jan 2025 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMZmjOgGfO0ZCtR7phXNAUmV4YljG4OudXpRMojv4XY=;
 b=EPfnPlNV4evA5pKWb65WTen65zGnG5CG8O6GK5zopwPKpbJzMo7iUPSLPjvhvjh5c3N1Im
 xWwwxqC7OFp7qgiuU168uOpTuiJMJ6bt2K6jazPkNZEtS2xmYpppdoFUjz8xCtBHwcvhfk
 vtrWMhxB4mOa0CKr6HtK1TYwfoJFnBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMZmjOgGfO0ZCtR7phXNAUmV4YljG4OudXpRMojv4XY=;
 b=zw8tmnGMcFoiCCDnX2C7RHv92kOR6F4wpxJGzZcawcfR89XuCJP64rMyU4vhM960gibO95
 hWrtj7fZArFsUoDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMZmjOgGfO0ZCtR7phXNAUmV4YljG4OudXpRMojv4XY=;
 b=EPfnPlNV4evA5pKWb65WTen65zGnG5CG8O6GK5zopwPKpbJzMo7iUPSLPjvhvjh5c3N1Im
 xWwwxqC7OFp7qgiuU168uOpTuiJMJ6bt2K6jazPkNZEtS2xmYpppdoFUjz8xCtBHwcvhfk
 vtrWMhxB4mOa0CKr6HtK1TYwfoJFnBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMZmjOgGfO0ZCtR7phXNAUmV4YljG4OudXpRMojv4XY=;
 b=zw8tmnGMcFoiCCDnX2C7RHv92kOR6F4wpxJGzZcawcfR89XuCJP64rMyU4vhM960gibO95
 hWrtj7fZArFsUoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBFF9137DA;
 Wed,  8 Jan 2025 12:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PMDcMBZ0fmeHKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jan 2025 12:48:22 +0000
Date: Wed, 8 Jan 2025 13:52:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z351C1oe7rplimrf@rei>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-2-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-2-e293a8d99cf6@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
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

The cast to (struct lsm_ctx *) here is useless, C will cast it
automatically upon returning the value from the function.

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

The strstr() is not future proof here. If somebody adds a lsm with a
name that is substring of current lsm name, the strstr() will produce
false possitive.

It's better to iterate over the data with strtok() and compare exact
names with strcmp().

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
> +	struct lsm_ctx **ctx;
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

The test itself looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
