Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7FCC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:52:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AF9C3E5C63
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 12:52:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C18A3C0F6F
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:52:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FC2F60087C
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:52:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26C4B75E5E;
 Thu,  9 Jul 2026 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783594326;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7XH3moUKysKe3Ha04MsgCiUXrD/2Qjf1C5kWWZj/k8=;
 b=auQaIc2pxHfHNDT+6lnAymgZGndgCADhVLzlBxxUThlqnBZ/b3fZwNzV4M8LBNIZuedMZq
 /VDxiQjLwIRfqr9B0lZiabop5CycdCj7oiGSwywq7kiRPWxzVrM/6HeLuC//RupQ6lcMOB
 vr88KTz4mU6q/K38mA+6rA3ZwO/x6pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783594326;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7XH3moUKysKe3Ha04MsgCiUXrD/2Qjf1C5kWWZj/k8=;
 b=pqnx505mvh68/OSP9kYdj5wFRuKZ/QH0ruWKnQo08wZ0Vhh3v8gkI3MKKWBcCTd+Ic/og4
 2el/UEcassZGRRDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783594326;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7XH3moUKysKe3Ha04MsgCiUXrD/2Qjf1C5kWWZj/k8=;
 b=auQaIc2pxHfHNDT+6lnAymgZGndgCADhVLzlBxxUThlqnBZ/b3fZwNzV4M8LBNIZuedMZq
 /VDxiQjLwIRfqr9B0lZiabop5CycdCj7oiGSwywq7kiRPWxzVrM/6HeLuC//RupQ6lcMOB
 vr88KTz4mU6q/K38mA+6rA3ZwO/x6pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783594326;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7XH3moUKysKe3Ha04MsgCiUXrD/2Qjf1C5kWWZj/k8=;
 b=pqnx505mvh68/OSP9kYdj5wFRuKZ/QH0ruWKnQo08wZ0Vhh3v8gkI3MKKWBcCTd+Ic/og4
 2el/UEcassZGRRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55317779AA;
 Thu,  9 Jul 2026 10:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOxMD1V9T2poFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 10:52:05 +0000
Date: Thu, 9 Jul 2026 12:51:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260709105159.GA874350@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709085353.345957-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: Add epoll_create03
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

Hi Cyril,

> Test that checks that we get EMFILE when limit on per-process file
> descriptors is hit.

+1.

...
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create03.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * Verify that :manpage:epoll_create() fails with EMFILE when the per-process
Please add 2 to the manpage link.

:manpage:epoll_create(2)

Without it it's not working (plain text instead of link).
Can be changed before merge.

> + * limit on the number of open file descriptors has been reached.
> + */
> +
> +#include <stdlib.h>
> +#include <sys/epoll.h>
> +
> +#include "tst_test.h"
> +#include "lapi/epoll.h"
> +#include "lapi/syscalls.h"
> +
> +#include "epoll_create.h"
> +
> +static int *fds;
> +static int nfds;
> +static long maxfds;
> +
> +static void setup(void)
> +{
> +	int fd;
> +
> +	variant_info();
> +
> +	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
> +	fds = SAFE_MALLOC(maxfds * sizeof(int));
> +	memset(fds, -1, maxfds * sizeof(int));
> +
> +	fds[0] = SAFE_OPEN("dummy", O_RDWR | O_CREAT, 0700);
> +	nfds = 1;
> +
> +	for (int i = 1; i < maxfds; i++) {
> +		fd = dup(fds[0]);
> +		if (fd == -1)
> +			break;
> +		fds[nfds++] = fd;
> +	}

How many files are created is done via `ulimit -n`, right? (not sure if there
is file for it in /proc/sys).
Would it be worth we check that? Or at least check that at least 2 files were
opened? Maybe this check should be rather put into dup03.c.

Or maybe to print how many descriptors was created?
tst_res(TINFO, "Created %d file descriptors", nfds);

> +}
> +
> +static void run(void)
> +{
> +	TST_EXP_FAIL2(do_epoll_create(1), EMFILE,
> +		      "epoll_create(1) with exhausted fds");

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
