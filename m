Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66AFFF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8110C3E2D31
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:08:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F22513E2CA2
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:08:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F958600435
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:07:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51CA26A81B;
 Mon,  4 May 2026 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777885678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcPFOTs7SiOwGrnrEsFHMO0fqMvdm4YYg1mqAyyw56c=;
 b=O76EwszrerGy1EdzwXoE9j84dQwes8M6wOhaDSSQMEyUmeAlarAic2aQKoDait4Ioy+VT9
 F0eiyelhxuFKo/N7zlIYf03YDnJw+Ovy0CkVMSXHqYss5IVWk/Y4w6YOOScKqIAON8BwVh
 6HHWXSo0l6r5AOgHyGlEjtmMbFHzIO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777885678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcPFOTs7SiOwGrnrEsFHMO0fqMvdm4YYg1mqAyyw56c=;
 b=f8628lnImwQA6oXFF+3VJBN/CUP0Kmo9cSlPEpEz8G7FHjYWUTxJofOUS/7wBb7nfT6+k4
 fGlUCa7sPzJfkoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777885678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcPFOTs7SiOwGrnrEsFHMO0fqMvdm4YYg1mqAyyw56c=;
 b=O76EwszrerGy1EdzwXoE9j84dQwes8M6wOhaDSSQMEyUmeAlarAic2aQKoDait4Ioy+VT9
 F0eiyelhxuFKo/N7zlIYf03YDnJw+Ovy0CkVMSXHqYss5IVWk/Y4w6YOOScKqIAON8BwVh
 6HHWXSo0l6r5AOgHyGlEjtmMbFHzIO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777885678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcPFOTs7SiOwGrnrEsFHMO0fqMvdm4YYg1mqAyyw56c=;
 b=f8628lnImwQA6oXFF+3VJBN/CUP0Kmo9cSlPEpEz8G7FHjYWUTxJofOUS/7wBb7nfT6+k4
 fGlUCa7sPzJfkoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E661593A3;
 Mon,  4 May 2026 09:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZpMIDu5h+GlDDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 09:07:58 +0000
Date: Mon, 4 May 2026 11:07:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <afhh6HGimjQqHvWf@yuki.lan>
References: <20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,linux.it:url,suse.com:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] clock_settime: use POSIX runtime detection for
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/open_posix_testsuite/include/clock.h b/testcases/open_posix_testsuite/include/clock.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..221dd38ff34b627aa5f6c07825cd7439cf559c74
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/include/clock.h
> @@ -0,0 +1,77 @@
> +/*
> + * Copyright (c) 2026, Linux Test Project
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PTS_CLOCK_H
> +#define PTS_CLOCK_H
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +static inline int pts_mono_available(void)
> +{
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	if (_POSIX_MONOTONIC_CLOCK > 0)
> +		return 1;
> +
> +	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
> +		return 1;
> +#endif
> +	return 0;
> +}
> +
> +#define PTS_MONO_MAX_RETRIES 3
> +
> +static struct timespec pts_mono_start;
> +
> +static inline int pts_mono_time_start(void)
> +{
> +	if (!pts_mono_available()) {
> +		static int warned;
> +
> +		if (!warned) {
> +			printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
> +			warned = 1;
> +		}
> +		return 0;
> +	}
> +
> +#ifdef _POSIX_MONOTONIC_CLOCK

I suppose that this not correct either. If _POSIX_MONOTONIC_CLOCK is set
to -1 the CLOCK_MONOTONIC constant may not be defined.

So we either have to to do

#if _POSIX_MONOTONIC_CLOCK >= 0

or

#ifdef CLOCK_MONOTONIC

> +	if (clock_gettime(CLOCK_MONOTONIC, &pts_mono_start) != 0) {
> +		perror("clock_gettime(CLOCK_MONOTONIC) failed");
> +		return -1;
> +	}
> +#endif
> +	return 0;
> +}
> +
> +static inline int pts_mono_time_check(unsigned int expected_secs)
> +{
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	if (pts_mono_available()) {
> +		struct timespec now;
> +		long elapsed;
> +
> +		if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
> +			perror("clock_gettime(CLOCK_MONOTONIC) failed");
> +			return -1;
> +		}
> +
> +		elapsed = now.tv_sec - pts_mono_start.tv_sec;
> +
> +		if (labs(elapsed - (long)expected_secs) > 1) {
> +			printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
> +			       elapsed, expected_secs);
> +			return 1;
> +		}
> +		return 0;
> +	}
> +#endif
> +	(void)expected_secs;
> +	return 0;
> +}
> +
> +#endif /* PTS_CLOCK_H */
> 
> ---
> base-commit: 1d2ea5b042a6c6c169689efebd856583200c564f
> change-id: 20260429-fix_clock_settime_helper-7670708ed94f
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
