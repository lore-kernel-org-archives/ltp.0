Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64152FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:55:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2458C3E61FF
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:55:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39693E2128
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:54:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF9361000558
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:54:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61CEA5C277;
 Mon,  4 May 2026 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777888483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+LCHiguyqGp4t/M7k1Lw4/Tm6SfMNBewRvGf04bQJE=;
 b=HdgD7vOX8eA6O0ipEeSpHti1CrMToRtwSV0zEQ3eMvc6jZOEQpOgPQwzMHEaq871cQ1uEq
 WVkagDQJcYdL3u51E8WrFFwsaddho7v22jmTv8w/KLWLgb5EQ9eDtVL5MojwDTzbXASoW5
 1+I10cHQIn/CAn70lwZWyJgJ3NyxzPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777888483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+LCHiguyqGp4t/M7k1Lw4/Tm6SfMNBewRvGf04bQJE=;
 b=aHinx8rVZ/uRFu50fZ5BPXbEkE1Ds+KaxyQUGMnw0ec1JZ5goR4/Y7bl72qWm0GnLEuX4n
 dqk2xoJlNdMfxaCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777888483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+LCHiguyqGp4t/M7k1Lw4/Tm6SfMNBewRvGf04bQJE=;
 b=HdgD7vOX8eA6O0ipEeSpHti1CrMToRtwSV0zEQ3eMvc6jZOEQpOgPQwzMHEaq871cQ1uEq
 WVkagDQJcYdL3u51E8WrFFwsaddho7v22jmTv8w/KLWLgb5EQ9eDtVL5MojwDTzbXASoW5
 1+I10cHQIn/CAn70lwZWyJgJ3NyxzPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777888483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+LCHiguyqGp4t/M7k1Lw4/Tm6SfMNBewRvGf04bQJE=;
 b=aHinx8rVZ/uRFu50fZ5BPXbEkE1Ds+KaxyQUGMnw0ec1JZ5goR4/Y7bl72qWm0GnLEuX4n
 dqk2xoJlNdMfxaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52370593A3;
 Mon,  4 May 2026 09:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Eq1TE+Ns+GkkPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 09:54:43 +0000
Date: Mon, 4 May 2026 11:54:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <afhs4WvcNbp1msPY@yuki.lan>
References: <20260504-fix_clock_settime_helper-v4-1-403149f43d30@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260504-fix_clock_settime_helper-v4-1-403149f43d30@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] clock_settime: use POSIX runtime detection for
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
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +static inline int pts_mono_available(void)
> +{
> +#ifdef CLOCK_MONOTONIC

This one should have stayed _POSIX_MONOTONIC_CLOCK since we are doing a
presence checks and the -1 is correctly handled here (we get to return 0
case in this case).

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
> +#ifdef CLOCK_MONOTONIC
> +	if (clock_gettime(CLOCK_MONOTONIC, &pts_mono_start) != 0) {
> +		perror("clock_gettime(CLOCK_MONOTONIC) failed");
> +		return -1;
> +	}
> +#endif

These are guarding againts compilation failures and looks fine to me
now.

> +	return 0;
> +}
> +
> +static inline int pts_mono_time_check(unsigned int expected_secs)
> +{
> +#ifdef CLOCK_MONOTONIC
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
> base-commit: 73cfad509db014e5a631bd2298f4e9d8ea3ee1c1
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
