Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A547C109B46D
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 182A73E5701
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 16:15:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 787053E4EC5
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 16:15:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD0011400960
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 16:15:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 841F14D272;
 Tue, 31 Mar 2026 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774966513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaXwcOsi0EOhegISut9KFBvGE0gOQWzR6AsBZn0IKLw=;
 b=BxXiXKbCri2CNWIaqW3La/nJG7wSEwRBGNxTCGLjV98Yw0AtjjJopys54DXqblUnNH94w2
 GaNwfPXq1JqiDJSsF4SG67zW++DrQcRZf1jp9UoZdwC8e8hVdsLAUFIQrZRggYeyyP0Bsx
 lBgJRmBR5bs/PJ9OeYeeeJRe/gIVaNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774966513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaXwcOsi0EOhegISut9KFBvGE0gOQWzR6AsBZn0IKLw=;
 b=xi2HNqnFOZ0e8botmPKFQlikeR5hZkftnrY8AUdPlIzMudLEjUnvxYVO4suSeSeu+0ZPvF
 md/f5OkheqJPdjCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774966513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaXwcOsi0EOhegISut9KFBvGE0gOQWzR6AsBZn0IKLw=;
 b=BxXiXKbCri2CNWIaqW3La/nJG7wSEwRBGNxTCGLjV98Yw0AtjjJopys54DXqblUnNH94w2
 GaNwfPXq1JqiDJSsF4SG67zW++DrQcRZf1jp9UoZdwC8e8hVdsLAUFIQrZRggYeyyP0Bsx
 lBgJRmBR5bs/PJ9OeYeeeJRe/gIVaNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774966513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaXwcOsi0EOhegISut9KFBvGE0gOQWzR6AsBZn0IKLw=;
 b=xi2HNqnFOZ0e8botmPKFQlikeR5hZkftnrY8AUdPlIzMudLEjUnvxYVO4suSeSeu+0ZPvF
 md/f5OkheqJPdjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6723B4A0A2;
 Tue, 31 Mar 2026 14:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DxXaFfHWy2nqCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 31 Mar 2026 14:15:13 +0000
Date: Tue, 31 Mar 2026 16:14:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <acvWwBNhJ5b8A7r2@rei.lan>
References: <20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_settime: Detect external clock
 adjustments via CLOCK_MONOTONIC
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
Cc: Claude <noreply@anthropic.com>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> These tests manipulate CLOCK_REALTIME to verify timer and
> clock_nanosleep behavior, but NTP or VM time sync can also adjust
> CLOCK_REALTIME during the test, causing timers to fire at wrong times
> and producing spurious failures.
> 
> Use CLOCK_MONOTONIC as a sideband check to detect external interference.
> If the monotonic elapsed time is anomalous, report UNTESTED instead of
> a false FAIL. Guard the checks with _POSIX_MONOTONIC_CLOCK since
> CLOCK_MONOTONIC is optional in POSIX.1-2001.

Maybe we can retry a few times before we give up and report untested?

> Co-authored-by: Claude <noreply@anthropic.com>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> I used Claude to generate the right patches to fix sporadic issues in the
> clock_settime testing suite. We tried many attempt for fixing it, but the
> CLOCK_REALTIME usage seems to be the real issue in here. The idea is that
> we use internal Openposix mechanisms to skip tests if CLOCK_MONOTONIC
> usage spots a possible interference from external tools.
> ---
> Changes in v2:
> - print a message if CLOCK_MONOTONIC is not available
> - always verify that CLOCK_MONOTONIC is available
> - Link to v1: https://lore.kernel.org/r/20260331-clock_settime_fix-v1-1-dfae06df2436@suse.com
> ---
>  .../conformance/interfaces/clock_settime/4-1.c     | 36 ++++++++++++++++++
>  .../conformance/interfaces/clock_settime/5-1.c     | 43 +++++++++++++++++++++-
>  .../conformance/interfaces/clock_settime/5-2.c     | 43 +++++++++++++++++++++-
>  .../conformance/interfaces/clock_settime/7-1.c     | 38 +++++++++++++++++++
>  .../conformance/interfaces/clock_settime/7-2.c     | 41 ++++++++++++++++++++-
>  5 files changed, 198 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
> index f8a3e9c542ca8c9767cdd0057005e519f58b2b55..5f3f816a5fc71a9e62bb3577e1a18a19f987a802 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
> @@ -42,6 +42,9 @@ int main(void)
>  {
>  	struct sigevent ev;
>  	struct timespec tpT0, tpT2, tpreset;
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	struct timespec mono_before, mono_after;
> +#endif
>  	struct itimerspec its;
>  	timer_t tid;
>  	int delta;
> @@ -55,6 +58,10 @@ int main(void)
>  		return PTS_UNTESTED;
>  	}
>  
> +#ifndef _POSIX_MONOTONIC_CLOCK
> +	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
> +#endif
> +
>  	/*
>  	 * set up sigevent for timer
>  	 * set up signal set for sigwait
> @@ -82,6 +89,13 @@ int main(void)
>  		return PTS_UNRESOLVED;
>  	}
>  
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
> +		perror("clock_gettime() was not successful\n");
> +		return PTS_UNRESOLVED;
> +	}
> +#endif
> +
>  	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
>  		perror("timer_create() did not return success\n");
>  		return PTS_UNRESOLVED;
> @@ -120,6 +134,28 @@ int main(void)
>  	tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
>  	setBackTime(tpreset);
>  
> +#ifdef _POSIX_MONOTONIC_CLOCK
> +	if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
> +		perror("clock_gettime() was not successful\n");
> +		return PTS_UNRESOLVED;
> +	}
> +
> +	/*
> +	 * The expected monotonic elapsed time is SLEEPTIME + TIMEROFFSET
> +	 * since after resetting the clock, the timer must wait another
> +	 * full TIMEROFFSET. If monotonic time is much shorter, an external
> +	 * clock adjustment (NTP, VM sync) interfered with the test.
> +	 */
> +	if (mono_after.tv_sec - mono_before.tv_sec <
> +	    SLEEPTIME + TIMEROFFSET - ACCEPTABLEDELTA) {
> +		printf("UNTESTED: external clock adjustment detected "
> +		       "(monotonic elapsed %ds, expected ~%ds)\n",
> +		       (int)(mono_after.tv_sec - mono_before.tv_sec),
> +		       SLEEPTIME + TIMEROFFSET);
> +		return PTS_UNTESTED;
> +	}
> +#endif

This is a bit more than a line or two, maybe we can put this into a
common header as a static inline functions instead?

Something as having a function to start measuring the time and to return
true of false based on if the measured interval lenght is as expected?

e.g.:

static inline void pts_mono_time_start(void);

static inline bool pts_mono_time_end(unsigned int expected_delta);

Then we could loop the actual test a few times while pts_mon_time_end()
returns false.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
