Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E74C5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 08:13:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994003CA3C5
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 10:13:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA283CA280
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:13:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E4B51000D18
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 10:13:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B72420881;
 Thu,  5 Jun 2025 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749111196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
 b=HADvRxmnxBAr6zDxG1K1sChJqLID/UAnKE63bFCJP9hLajTLlLtuiT0SUNfwqdtT0om6V6
 ZmVMlUdvmhxQmOupPBSywUxxlQgk4Wj+4Ho3XV/g+oKfJsR6jGfZtkg/89rrZ3Db3ZTIZK
 RqaUQr+gIClLRPONm8SZiZI357bMoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749111196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
 b=eq3K7Fo8eD8fGmCgeO0HnrMkXVBsXCZZ+YyLDvkPzOrub1u3uZ3uPGxae0sFKkJHMAyptA
 G0KTnt2X/hd0T0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749111196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
 b=HADvRxmnxBAr6zDxG1K1sChJqLID/UAnKE63bFCJP9hLajTLlLtuiT0SUNfwqdtT0om6V6
 ZmVMlUdvmhxQmOupPBSywUxxlQgk4Wj+4Ho3XV/g+oKfJsR6jGfZtkg/89rrZ3Db3ZTIZK
 RqaUQr+gIClLRPONm8SZiZI357bMoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749111196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RYO4b/CeI1hoUhImmO/HMeMpnMI8r8Dtfwkw2xvlYo=;
 b=eq3K7Fo8eD8fGmCgeO0HnrMkXVBsXCZZ+YyLDvkPzOrub1u3uZ3uPGxae0sFKkJHMAyptA
 G0KTnt2X/hd0T0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A57A137FE;
 Thu,  5 Jun 2025 08:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sc5WBJtRQWhaPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 08:13:15 +0000
Date: Thu, 5 Jun 2025 10:13:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250605081309.GD1190804@pevik>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-7-602b7097e722@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250429-lsm-v4-7-602b7097e722@suse.com>
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.18)[-0.900]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 7/7] Add lsm_set_self_attr01 test
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
Cc: =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

> Verify that lsm_set_self_attr syscall is raising errors when invalid
> data is provided.

...
> diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that lsm_set_self_attr syscall is raising errors when invalid data is
> + * provided.
> + */
> +
> +#include "lsm_common.h"
> +
> +static struct lsm_ctx *ctx;
> +static struct lsm_ctx *ctx_orig;
> +static struct lsm_ctx *ctx_null;
> +static uint32_t ctx_size;
> +static uint32_t ctx_size_small;
> +static uint32_t ctx_size_big;
> +static uint32_t page_size;
> +
> +static struct tcase {
> +	uint32_t attr;
> +	struct lsm_ctx **ctx;
> +	uint32_t *size;
> +	uint32_t flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx_null,
> +		.size = &ctx_size,
> +		.exp_errno = EFAULT,
> +		.msg = "ctx is NULL",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size_small,
> +		.exp_errno = EINVAL,
> +		.msg = "size is too small",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size_big,
> +		.exp_errno = E2BIG,
> +		.msg = "size is too big",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.flags = 1,
> +		.exp_errno = EINVAL,
> +		.msg = "flags must be zero",
> +	},
> +	{
> +		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
> +		.ctx = &ctx,
> +		.size = &ctx_size,
> +		.exp_errno = EINVAL,
> +		.msg = "attr is overset",

FYI The test fails on this check on current Tumbleweed with new
6.15.0-1-default. It worked on 6.14.

Looking at 6.15 landlock related changes (added Landlock audit support and
Landlock signal scope fixes) test might needs to be updated.
https://kernelnewbies.org/Linux_6.15#Security

@Andrea could you please have a look?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
