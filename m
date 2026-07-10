Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFEC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 06:42:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 306593E279A
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:42:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38BC43E26BB
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:41:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A766B1A00CA7
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:41:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C9387662D;
 Fri, 10 Jul 2026 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783665710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/SIlFgXW+jew9BZTB7r5cwt6CUg9BuvgK6SnsUl9Ro=;
 b=qQe+BnvWh/iSBYhOb9Omb0uET+40O0ywzy+wtFGUfl3vTbWHxg4qZwq8kFk9RVyjRcLkWI
 JfZUDVO39XukasAPhRfU8zsNjm6Y/tzWwuJGy42Uh/c0EoVVPmgFgkUEiqC78VkLL9Ipi1
 llvp8r7HvwtXt1um0J32LqTL18F3DxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783665710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/SIlFgXW+jew9BZTB7r5cwt6CUg9BuvgK6SnsUl9Ro=;
 b=I2ZPuDtmtg9UPlQMHHVaMBOCAN+Y52Q1yvcf8UvurwFMrpxHfwxIu24FFIZKinZ0JL52il
 rmCvQZ3rd+Gz50BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783665710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/SIlFgXW+jew9BZTB7r5cwt6CUg9BuvgK6SnsUl9Ro=;
 b=qQe+BnvWh/iSBYhOb9Omb0uET+40O0ywzy+wtFGUfl3vTbWHxg4qZwq8kFk9RVyjRcLkWI
 JfZUDVO39XukasAPhRfU8zsNjm6Y/tzWwuJGy42Uh/c0EoVVPmgFgkUEiqC78VkLL9Ipi1
 llvp8r7HvwtXt1um0J32LqTL18F3DxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783665710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/SIlFgXW+jew9BZTB7r5cwt6CUg9BuvgK6SnsUl9Ro=;
 b=I2ZPuDtmtg9UPlQMHHVaMBOCAN+Y52Q1yvcf8UvurwFMrpxHfwxIu24FFIZKinZ0JL52il
 rmCvQZ3rd+Gz50BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E31E779BD;
 Fri, 10 Jul 2026 06:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMKTHS6UUGo6egAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 06:41:50 +0000
Date: Fri, 10 Jul 2026 08:41:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260710064149.GC1138100@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-4-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709085353.345957-4-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/9] syscalls: Add epoll_wait09
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Test checks that events from recursive epoll are propagated correctly.
+1

> +/*\
> + * Verify that :manpage:epoll_wait() works with nested epoll instances up to
> + * the maximum nesting depth of 5 allowed by the kernel (EP_MAX_NESTS).
> + *
> + * [Algorithm]
> + *
> + * - Create a pipe.
> + * - Build a chain of epoll instances of the given depth where the innermost
> + *   monitors the pipe read end and each subsequent one monitors the previous.
> + * - Write data to the pipe.
> + * - Call :manpage:epoll_wait() on the outermost epoll instance and verify it
> + *   reports EPOLLIN.
> + * - Walk the chain inward calling epoll_wait on each level and verify that
> + *   every level reports EPOLLIN on the expected fd.
> + * - Read the data from the pipe to drain it.
> + */

Thanks for the description.
> +
> +#include <sys/epoll.h>
> +
> +#include "tst_epoll.h"
> +#include "tst_test.h"
> +
> +#define MAX_DEPTH 5
> +
> +static int epfds[MAX_DEPTH];
> +static int fds[2] = {-1, -1};
> +
> +static struct tcase {
> +	int depth;
> +} tcases[] = {
> +	{2},
> +	{3},
> +	{4},
> +	{5},

nit: why not just define depth in the test?
int depth = n + 2;

And
-	.tcnt = ARRAY_SIZE(tcases),
+	.tcnt = MAX_DEPTH,

That would help having to sync these 3 (tcases[], MAX_DEPTH and .tcnt).

Also, could you run make check to fix formatting complains?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
