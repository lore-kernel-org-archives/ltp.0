Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A3F8A16A
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:08:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FA73E2928
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:08:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833D73C1E06
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:08:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E609E1A000BA
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:08:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73F6E5BCF3;
 Thu, 16 Apr 2026 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776341312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3lFTPXu9fiQVLcLeKWKYhqurLGLHQn+0Zpp9xNn6/o=;
 b=hAZl0jxijvG5TY7eRB78qmh7hYMU5xS7VRX7Q1CrXKu8HINZtLeUVlB373qbYER5hpr4O/
 1/vE0gZ13A6HTJU7MtIG0hBi/2A7Z6yLEg8fZEuhf+zZO1umEzlmbQ4vSMFC+WYEaq7tc9
 OtLNTDZJoFxtnYxi4TMzvlRvNTbmrbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776341312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3lFTPXu9fiQVLcLeKWKYhqurLGLHQn+0Zpp9xNn6/o=;
 b=FYpNP7nW5GptFH38b8p28ZxogJNCE3RouEBhfKwI4px0itV2PrxdKg8jTBxpaz2ec5KHse
 7wQdh65YmoJLiVBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776341311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3lFTPXu9fiQVLcLeKWKYhqurLGLHQn+0Zpp9xNn6/o=;
 b=E+GKR6S6Eil5tZqAcwTkiDT8+DooMYKqmZxzteMJqqCOJ+v0rvV7t822lMkSY+KcDfKolD
 +dYeMys992WGLm2x4GTHpQ/vGLpePRS/s5QTigr06Yp9L80I/fMtexhS4KBfdEelrAa7cg
 hXuOFUGAcFxIAq2xcy4TGJRWiqhc38Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776341311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3lFTPXu9fiQVLcLeKWKYhqurLGLHQn+0Zpp9xNn6/o=;
 b=kxlYdkgLVE0kovyZN8HHrr8cO2O2m9sgQnW7AZxPkKG1QctM9d7q0VrIXDNUPfsfrzplWI
 oXq5VTwrXaB8U9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DABA593A3;
 Thu, 16 Apr 2026 12:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gtoQFj/R4GkICQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 12:08:31 +0000
Date: Thu, 16 Apr 2026 14:08:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260416120821.GB299728@pevik>
References: <20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nanosleep: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,
...
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/helpers.h
> @@ -0,0 +1,28 @@
> +/*
> + * Copyright (c) 2026, Linux Test Project
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef NANOSLEEP_HELPERS_H
> +#define NANOSLEEP_HELPERS_H
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <time.h>
> +
> +static inline clockid_t get_supported_clock(void)
> +{
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	if (_POSIX_MONOTONIC_CLOCK > 0)
> +		return CLOCK_MONOTONIC;
> +
> +	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
> +		return CLOCK_MONOTONIC;
> +#endif
> +
> +	printf("CLOCK_MONOTONIC unavailable, test may fail due to "
> +	       "external clock adjustments\n");
> +	return CLOCK_REALTIME;
> +}
> +
> +#endif /* NANOSLEEP_HELPERS_H */
Could you please also fix
testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h?

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
