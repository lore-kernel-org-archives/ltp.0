Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E939C282D3
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B08A43CA023
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:00:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F7BD3C9F5B
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:00:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C53901401117
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:00:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1204E21170;
 Tue,  4 Mar 2025 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741089601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDie4GukQHZAdopQb39as280M5oZB7zk4eTFH1M+8/Q=;
 b=kactqgEfgEb0tp1jxNNRzcHxLpsbUtoohgBpxrvkVmKNFw/uFvHMYrsLweS5oKlAEv4fFI
 7y03c+YyqnQ3v0eP4QML30SVSMM2awnXN2CZ+X5xIWRZh37DClfCTl5ZEhEF973Dm71SCn
 epmxKc+RCxnmf1WSAJW+8gX5DHkAw5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741089601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDie4GukQHZAdopQb39as280M5oZB7zk4eTFH1M+8/Q=;
 b=0fsKcsU9d2s+dWjDpiE+3TkwnJM6vkY+z2kwkX30t3t8UoS7iP7N8NpBAREBgNYj8hX275
 hfDzJkr8/h6aE3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741089601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDie4GukQHZAdopQb39as280M5oZB7zk4eTFH1M+8/Q=;
 b=kactqgEfgEb0tp1jxNNRzcHxLpsbUtoohgBpxrvkVmKNFw/uFvHMYrsLweS5oKlAEv4fFI
 7y03c+YyqnQ3v0eP4QML30SVSMM2awnXN2CZ+X5xIWRZh37DClfCTl5ZEhEF973Dm71SCn
 epmxKc+RCxnmf1WSAJW+8gX5DHkAw5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741089601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDie4GukQHZAdopQb39as280M5oZB7zk4eTFH1M+8/Q=;
 b=0fsKcsU9d2s+dWjDpiE+3TkwnJM6vkY+z2kwkX30t3t8UoS7iP7N8NpBAREBgNYj8hX275
 hfDzJkr8/h6aE3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0310113967;
 Tue,  4 Mar 2025 12:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K8OOO0DrxmeBfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Mar 2025 12:00:00 +0000
Date: Tue, 4 Mar 2025 13:00:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z8brR4pxW-r5BDoI@yuki.lan>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-1-bd38035f86bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110-lsm-v2-1-bd38035f86bc@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions of LSM syscalls
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef LAPI_LSM_H__
> +#define LAPI_LSM_H__
> +
> +#include "config.h"
> +
> +#ifdef HAVE_LINUX_LSM_H
> +#include <linux/lsm.h>
> +#else

It's kind of broken to have an else branch here...

> +#include <stdint.h>
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_STRUCT_LSM_CTX
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +	uint64_t id;
> +	uint64_t flags;
> +	uint64_t len;
> +	uint64_t ctx_len;
> +	uint8_t ctx[4096];
> +};
> +#endif

... when most of the entries are guarded by their own ifdefs.


So I would be for dropping the else and just making sure that everyting
else is guarded by ifdef. This is only way how to make sure that we have
all defintions on older variants of linux/lsm.h that may miss some of
the ifdefs that are currently in the #else branch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
