Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA18C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 09:12:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 951893D03DA
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 11:12:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCF53C62EE
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 11:11:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6A10F1A010DE
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 11:11:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B9DD22C58;
 Mon, 29 Apr 2024 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714381907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1CDelbrr0Suh3V2kUuvThbedURTWub7bsHONdW60as=;
 b=u12j6KaKZ9UJ09wBMwRKhZKoyXM6+IIAJ8049HuM4TXg6wFTzHCaVFW0w1vjlMcYyrbmhT
 OPSheqpp+gl+IQKIg6v2c1R87xC/9r9Tgigi2cIOsPtFO6TfGppYdBSKcjoypCblhvFimO
 Auf/++dfdLTRoa4oihazeJ2BS9ojBug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714381907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1CDelbrr0Suh3V2kUuvThbedURTWub7bsHONdW60as=;
 b=EAcsCQRrpHuyiG3aodzEkkwXa+fto1M7Xx3lJW/z4l+2HTpvfaHSe2XOY4v81Dj2l6XDW8
 P+ChU2QWMcqW6IDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714381907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1CDelbrr0Suh3V2kUuvThbedURTWub7bsHONdW60as=;
 b=u12j6KaKZ9UJ09wBMwRKhZKoyXM6+IIAJ8049HuM4TXg6wFTzHCaVFW0w1vjlMcYyrbmhT
 OPSheqpp+gl+IQKIg6v2c1R87xC/9r9Tgigi2cIOsPtFO6TfGppYdBSKcjoypCblhvFimO
 Auf/++dfdLTRoa4oihazeJ2BS9ojBug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714381907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1CDelbrr0Suh3V2kUuvThbedURTWub7bsHONdW60as=;
 b=EAcsCQRrpHuyiG3aodzEkkwXa+fto1M7Xx3lJW/z4l+2HTpvfaHSe2XOY4v81Dj2l6XDW8
 P+ChU2QWMcqW6IDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A60A138A7;
 Mon, 29 Apr 2024 09:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vYCnBVNkL2ZKGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 09:11:47 +0000
Date: Mon, 29 Apr 2024 11:10:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <Zi9kFxXw3mUEVcnf@yuki>
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-4-jstultz@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423225821.4003538-4-jstultz@google.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] sched_football: Re-add the crazy fans to
 interrupt everyone
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>   *      This is a scheduler test that uses a football analogy.
>   *      The premise is that we want to make sure that lower priority threads
> - *      (defensive team). The offense is trying to increment the balls position,
> - *      while the defense is trying to block that from happening.
> + *      don't run while we have runnable higher priority threads.
> + *      The offense is trying to increment the balls position, while the
> + *      defense is trying to block that from happening.
>   *      And the ref (highest priority thread) will blow the wistle if the
>   *      ball moves. Finally, we have crazy fans (higer prority) that try to
>   *      distract the defense by occasionally running onto the field.
>   *
>   *      Steps:
> - *       - Create a fixed number of offense threads (lower priority)
> + *       - Create NR_CPU offense threads (lower priority)
> + *       - Create NR_CPU defense threads (mid priority)
> + *       - Create 2*NR_CPU fan threads (high priority)
>   *       - Create a referee thread (highest priority)
> - *       - Once everyone is on the field, the offense thread increments the
> - *         value of 'the_ball'. The defense thread tries to block
> - *         the ball by never letting the offense players get the CPU (it just
> - *         spins).
> + *       - Once everyone is on the field, the offense thread spins incrementing
> + *         the value of 'the_ball'. The defense thread tries to block the ball
> + *         by never letting the offense players get the CPU (it just spins).
> + *         The crazy fans sleep a bit, then jump the rail and run across the
> + *         field, disrupting the players on the field.
>   *       - The refree threads wakes up regularly to check if the game is over :)
>   *       - In the end, if the value of 'the_ball' is >0, the test is considered
>   *         to have failed.
> @@ -52,7 +56,7 @@
>   *		bugfixes and cleanups. -- Josh Triplett
>   *     2009-06-23 Simplified atomic startup mechanism, avoiding thundering herd
>   *		scheduling at the beginning of the game. -- Darren Hart
> - *
> + *     2024-04-23 Re-add crazy fans! Along with minor cleanups -- John Stultz

We use git now, so it's kind of pointless to add more changelog lines
into the file itself.

>   *****************************************************************************/
>  
>  #include <stdio.h>
> @@ -107,6 +111,38 @@ int parse_args(int c, char *v)
>  	return handled;
>  }
>  
> +#define NSEC_PER_SEC 1000000000ULL
> +unsigned long long ts_delta(struct timespec *start, struct timespec *stop)
> +{
> +	unsigned long long a, b;
> +
> +	a = start->tv_sec * NSEC_PER_SEC + start->tv_nsec;
> +	b = stop->tv_sec * NSEC_PER_SEC + stop->tv_nsec;
> +	return b - a;
> +}

This is tst_timespec_diff() from include/tst_timer.h

> +#define SPIN_TIME_NS 200000000
> +#define SLEEP_TIME_NS 50000000
> +/* These are fans running across the field. They're trying to interrupt/distract everyone */
> +void *thread_fan(void *arg)
> +{
> +	atomic_inc(&players_ready);
> +	/*occasionally wake up and run across the field */
> +	while (1) {
> +		int i;
> +		struct timespec start, stop;
> +
> +		start.tv_sec = 0;
> +		start.tv_nsec = SLEEP_TIME_NS;
> +		clock_nanosleep(CLOCK_MONOTONIC, 0, &start, NULL);
> +		clock_gettime(CLOCK_MONOTONIC, &start);
> +		clock_gettime(CLOCK_MONOTONIC, &stop);
> +		while (ts_delta(&start, &stop) < SPIN_TIME_NS)
> +			clock_gettime(CLOCK_MONOTONIC, &stop);
> +	}
> +	return NULL;
> +}
> +
>  /* This is the defensive team. They're trying to block the offense */
>  void *thread_defense(void *arg)
>  {
> @@ -199,6 +235,17 @@ int main(int argc, char *argv[])
>  	while (atomic_get(&players_ready) < players_per_team * 2)
>  		usleep(100);
>  
> +	/* Start the crazy fans*/
> +	priority = 50;
> +	printf("Starting %d fan threads at priority %d\n",
> +	       players_per_team, priority);
> +	for (i = 0; i < players_per_team*2; i++)
> +		create_fifo_thread(thread_fan, NULL, priority);
> +
> +	/* Wait for the crazy fan threads to start */
> +	while (atomic_get(&players_ready) < players_per_team * 4)
> +		usleep(100);
> +
>  	/* Ok, everyone is on the field, bring out the ref */
>  	printf("Starting referee thread\n");
>  	result = referee(game_length);
> -- 
> 2.44.0.769.g3c40516874-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
