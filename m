Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E812F108B8EE
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98E573E2B3D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 11:40:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B9EF3C940A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 11:39:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBE79602156
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 11:39:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 914715BD59;
 Fri, 20 Mar 2026 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774003188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obml08jZMaA/Aoo4YDe0hGvQvhVqE2p6IGoZiPhpZnA=;
 b=3Qyy80/0/fvYq/U18yiBn0OqidMvNqB7n+GWUkct9NiW4/Vsh1MGblxbT92g/iA6yiv2iX
 992jW/94JUP+WGDcBJzhK9McOpKyeIviHcHL2JaUjg9y/vvYn0EtenjomUPEOd7pDOkDoS
 vM+lyDcjp/rkIMsmsjmYC87pfRSf0XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774003188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obml08jZMaA/Aoo4YDe0hGvQvhVqE2p6IGoZiPhpZnA=;
 b=80Ep43+gbvBEg5/eAqJnkr8gTMWsJHup/XtQkEiGSgvL+TqCUZ3x9xFU435kehR+fFOevu
 CLRWH0mdTVh+FYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774003188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obml08jZMaA/Aoo4YDe0hGvQvhVqE2p6IGoZiPhpZnA=;
 b=3Qyy80/0/fvYq/U18yiBn0OqidMvNqB7n+GWUkct9NiW4/Vsh1MGblxbT92g/iA6yiv2iX
 992jW/94JUP+WGDcBJzhK9McOpKyeIviHcHL2JaUjg9y/vvYn0EtenjomUPEOd7pDOkDoS
 vM+lyDcjp/rkIMsmsjmYC87pfRSf0XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774003188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obml08jZMaA/Aoo4YDe0hGvQvhVqE2p6IGoZiPhpZnA=;
 b=80Ep43+gbvBEg5/eAqJnkr8gTMWsJHup/XtQkEiGSgvL+TqCUZ3x9xFU435kehR+fFOevu
 CLRWH0mdTVh+FYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79E0F4273B;
 Fri, 20 Mar 2026 10:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JD0tHPQjvWkwSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 10:39:48 +0000
Date: Fri, 20 Mar 2026 11:39:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ab0j8yh0a8IlT5Oc@yuki.lan>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
 <20260313-listns-v2-4-38384fae9b1f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260313-listns-v2-4-38384fae9b1f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.it:url,yuki.lan:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] syscalls: add listns01 test for EFAULT on
 invalid address
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +++ b/testcases/kernel/syscalls/listns/listns01.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test listns() EFAULT error handling with invalid buffer pointers.
> + *
> + * Verify that listns() returns EFAULT when given a completely invalid
> + * address or a NULL pointer as the output buffer.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/listns.h"
> +
> +static struct tcase {
> +	const char *desc;
> +	uintptr_t bad_ptr_val;
> +	size_t nr_ids;
> +} tcases[] = {
> +	{
> +		.desc = "completely invalid pointer",
                            ^
			    Just "invalid pointer"

Keep messages short and to the point.

> +		.bad_ptr_val = 0xdeadbeef,

We do have a tst_get_bad_addr() function to generate an address that is
100% sure to be invalid on any platform.

> +		.nr_ids = 10,

This is the same for bot cases, no need to put it into the struct.

> +	},
> +	{
> +		.desc = "NULL buffer",
> +		.bad_ptr_val = 0,
> +		.nr_ids = 10,
> +	},
> +};
> +
> +static void verify_listns(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct listns_req req = { .size = NS_ID_REQ_SIZE_VER0 };
> +
> +	TST_EXP_FAIL2(listns(&req, (uint64_t *)tc->bad_ptr_val, tc->nr_ids, 0),
> +		      EFAULT, "listns() %s", tc->desc);
> +}
> +
> +static void setup(void)
> +{
> +	struct listns_req req = { .size = NS_ID_REQ_SIZE_VER0 };
> +
> +	tst_syscall(__NR_listns, &req, NULL, 0, 0);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_listns,
> +	.setup = setup,
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
