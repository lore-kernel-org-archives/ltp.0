Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835DC021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F07D3CA000
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 14:11:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9AEE3C7B04
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:11:28 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 706BF1BBEF29
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 14:11:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C151B1F456;
 Tue,  4 Mar 2025 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PAmbZlBxeGlHlDNi+EndQyUTUm14dDNuUoRRZqXYBs=;
 b=qFnDXPTw6g80KUrSXOo1VxkSIL1531zW6wKPhD5RDmsM37zIwZlRp7gYLQu1+0D/69ubpF
 GV3MyW7LybaaV4hh79Zwz9mayAdL/GM6b+AlXeh33RDUVUmgmi1hRspBU3agv8acnKU4zG
 zBhDd6JkpYfLJkOua4K+rThrBeuTkWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PAmbZlBxeGlHlDNi+EndQyUTUm14dDNuUoRRZqXYBs=;
 b=hsXCWgN8tJaHzQiOQLHHimfHPKep4oiHEvUuXldHmZaDEtFCI2zRy87ZM/Ap8hyhur08Rv
 XaO7RL+6KqCA2EAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PAmbZlBxeGlHlDNi+EndQyUTUm14dDNuUoRRZqXYBs=;
 b=qFnDXPTw6g80KUrSXOo1VxkSIL1531zW6wKPhD5RDmsM37zIwZlRp7gYLQu1+0D/69ubpF
 GV3MyW7LybaaV4hh79Zwz9mayAdL/GM6b+AlXeh33RDUVUmgmi1hRspBU3agv8acnKU4zG
 zBhDd6JkpYfLJkOua4K+rThrBeuTkWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PAmbZlBxeGlHlDNi+EndQyUTUm14dDNuUoRRZqXYBs=;
 b=hsXCWgN8tJaHzQiOQLHHimfHPKep4oiHEvUuXldHmZaDEtFCI2zRy87ZM/Ap8hyhur08Rv
 XaO7RL+6KqCA2EAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3E7313967;
 Tue,  4 Mar 2025 13:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id idYXK/n7xmfYGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 04 Mar 2025 13:11:21 +0000
Date: Tue, 4 Mar 2025 14:11:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z8b8CLkKbrRkkt9P@yuki.lan>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-4-bd38035f86bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250110-lsm-v2-4-bd38035f86bc@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] Add lsm_get_self_attr03 test
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
> index 0000000000000000000000000000000000000000..b432006650bff697eb60eb7ad6fdd62dbe0eb984
> --- /dev/null
> +++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that LSM_ATTR_CURRENT attribute is correctly recognizing
> + * the current, active security context of the process. This is done by
> + * checking that /proc/self/attr/current matches with the obtained value.
> + */
> +
> +#include "lsm_common.h"
> +
> +static struct lsm_ctx *ctx;
> +static uint32_t page_size;
> +
> +static void run(void)
> +{
> +	tst_res(TINFO, "Verifying 'LSM_ATTR_CURRENT' attribute");
> +
> +	uint32_t count;
> +	uint32_t size = page_size;
> +	char attr[size];
> +
> +	memset(attr, 0, size);
> +	memset(ctx, 0, sizeof(struct lsm_ctx));
> +
> +	count = TST_EXP_POSITIVE(
> +		lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
                                                          ^
							  This does not
							  look right.


Shouldn't we pass size initialized to size of the ctx->ctx[] there?

You are mixing the size of the attr[] array and the size of the ctx
into a single variable which isn't right at all. The attr[] size can
also be much smaller, since it's just a single string.

Looking back at the lapi/lsm.h the definition of the lsm_ctx structure
is wrong there too. You define the ctx[] as an array of 4096 bytes. That
is wrong because it does not match the system definition where it's
defined as a flexible array.

The correct solution is to:

1) change the ctx[4096] in the lapi/lsm.h to just ctx[]
   (so that we match the system definition)
2) define CTX_DATA_SIZE to something sensible, e.g. 4096
3) the size for allocation of the ctx must be sizeof(struct lsm_ctx) + CTX_DATA_SIZE
   (since the size passed to the syscall is the size of the ctx flexible array)
4) the size passed to the lsm_get_self_attr() must be then initialized to CTX_DATA_SIZE

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
