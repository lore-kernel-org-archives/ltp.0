Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C3ECC6B12
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 16:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0289F3EB0F5
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 18:30:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EBE23EA82B
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:30:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 79AA81400432
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:30:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1491C1F45E;
 Tue, 13 Oct 2026 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791908999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KefBbWl9IwZPy+y7DU7ZkSKdCtyim6O5IcvTKiXYqVM=;
 b=MjXRfp/NqzlmKuLxjeqFNAABEf82isNJkb3t0kzjpyfqAHc7lf9/gjfjS8E9xteq0oAPUV
 jUWmNlLwQFOM2dAps695cbnwFnEWXsR1fQZFMHivOqG8ahtnA+cNDvqRnpcp2kHn2ARR1A
 XkICJtJEdeHK38/AUEla9Jj2TrWv6i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791908999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KefBbWl9IwZPy+y7DU7ZkSKdCtyim6O5IcvTKiXYqVM=;
 b=ZyV5WS5jDaiJ2OucG64rQBqLOUPfisenSHgdsssnsWjUrWodeN40lh6jYq5V7yrxd3vy1I
 qzAeC/0wbutg1qCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MjXRfp/N";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZyV5WS5j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791908999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KefBbWl9IwZPy+y7DU7ZkSKdCtyim6O5IcvTKiXYqVM=;
 b=MjXRfp/NqzlmKuLxjeqFNAABEf82isNJkb3t0kzjpyfqAHc7lf9/gjfjS8E9xteq0oAPUV
 jUWmNlLwQFOM2dAps695cbnwFnEWXsR1fQZFMHivOqG8ahtnA+cNDvqRnpcp2kHn2ARR1A
 XkICJtJEdeHK38/AUEla9Jj2TrWv6i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791908999;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KefBbWl9IwZPy+y7DU7ZkSKdCtyim6O5IcvTKiXYqVM=;
 b=ZyV5WS5jDaiJ2OucG64rQBqLOUPfisenSHgdsssnsWjUrWodeN40lh6jYq5V7yrxd3vy1I
 qzAeC/0wbutg1qCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D4F13341;
 Tue, 13 Oct 2026 16:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id USerFYVczmpyQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 Oct 2026 16:29:57 +0000
Date: Tue, 13 Oct 2026 18:29:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20261013162955.GA109208@pevik>
References: <20261004015344.2862110-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261004015344.2862110-1-wakel@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 1491C1F45E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_pwait04: Use raw syscalls to avoid SIGSEGV
 on 32-bit Bionic
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
Cc: ltp@lists.linux.it, Xie Ziyao <xieziyao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake Liu, all,

> epoll_pwait04 passes an unmapped address from tst_get_bad_addr() as the
> sigmask argument to verify that the kernel returns EFAULT. However,
> do_epoll_pwait() invokes the libc epoll_pwait() and epoll_pwait2()
> wrappers when available.

> On 32-bit Android Bionic, sizeof(sigset_t) is 4 bytes whereas the
> kernel expects an 8-byte (_NSIG / 8) signal set. The 32-bit Bionic
> wrappers therefore dereference the sigmask pointer in userspace to
> zero-extend it into a sigset64_t on the stack before issuing the
> syscall. Passing an unmapped bad_addr thus causes a SIGSEGV in
> userspace before reaching the kernel. As passing an invalid pointer
> to a libc function is undefined behavior anyway, the EFAULT check
> should call the syscalls directly.

LGTM, thank you.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Expose sys_epoll_pwait() and sys_epoll_pwait2() in lapi/epoll.h and add
> do_sys_epoll_pwait() in epoll_pwait_var.h so epoll_pwait04 invokes the
> raw syscalls directly. do_epoll_pwait() is made static inline to avoid
> a -Wunused-function warning now that epoll_pwait04 no longer uses it.

Yeah, IMHO it's mostly better to use 'static inline' for headers (FYI for
library code we often move them to C files, but we do not put syscall
specific helpers into LTP library).

Kind regards,
Petr

> Fixes: 9d083e3a286b ("epoll_pwait: Add invalid sigmask test for epoll_pwait04")
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  include/lapi/epoll.h                          | 37 ++++++++++++++-----
>  .../syscalls/epoll_pwait/epoll_pwait04.c      |  6 ++-
>  .../syscalls/epoll_pwait/epoll_pwait_var.h    | 30 +++++++++++----
>  3 files changed, 55 insertions(+), 18 deletions(-)

> diff --git a/include/lapi/epoll.h b/include/lapi/epoll.h
> index 15a954175..07fb1503a 100644
> --- a/include/lapi/epoll.h
> +++ b/include/lapi/epoll.h
> @@ -24,13 +24,24 @@ static inline void epoll_pwait_supported(void)
>  	tst_syscall(__NR_epoll_pwait);
>  }

> +/*
> + * Note: The kernel expects an _NSIG / 8 bytes signal set, which may be larger
> + * than sizeof(sigset_t) on some 32-bit libcs (e.g. 4 bytes on 32-bit Bionic).
> + */
> +static inline int sys_epoll_pwait(int epfd, struct epoll_event *events,
> +				  int maxevents, int timeout,
> +				  const sigset_t *sigmask)
> +{
> +	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
> +			   timeout, sigmask, _NSIG / 8);
> +}
> +
>  #ifndef HAVE_EPOLL_PWAIT
>  static inline int epoll_pwait(int epfd, struct epoll_event *events,
>  			      int maxevents, int timeout,
>  			      const sigset_t *sigmask)
>  {
> -	return tst_syscall(__NR_epoll_pwait, epfd, events, maxevents,
> -			   timeout, sigmask, _NSIG / 8);
> +	return sys_epoll_pwait(epfd, events, maxevents, timeout, sigmask);
>  }
>  #endif

> @@ -40,23 +51,31 @@ static inline void epoll_pwait2_supported(void)
>  	tst_syscall(__NR_epoll_pwait2);
>  }

> -#ifndef HAVE_EPOLL_PWAIT2
> -static inline int epoll_pwait2(int epfd, struct epoll_event *events,
> -			       int maxevents, const struct timespec *timeout,
> -			       const sigset_t *sigmask)
> +static inline int sys_epoll_pwait2(int epfd, struct epoll_event *events,
> +				   int maxevents,
> +				   const struct timespec *timeout,
> +				   const sigset_t *sigmask)
>  {
> -	if (timeout == NULL)
> +	struct __kernel_timespec ts;
> +
> +	if (!timeout)
>  		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
>  				   NULL, sigmask, _NSIG / 8);

> -	struct __kernel_timespec ts;
> -
>  	ts.tv_sec = timeout->tv_sec;
>  	ts.tv_nsec = timeout->tv_nsec;

>  	return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
>  			   &ts, sigmask, _NSIG / 8);
>  }
> +
> +#ifndef HAVE_EPOLL_PWAIT2
> +static inline int epoll_pwait2(int epfd, struct epoll_event *events,
> +			       int maxevents, const struct timespec *timeout,
> +			       const sigset_t *sigmask)
> +{
> +	return sys_epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
> +}
>  #endif

>  #endif /* LAPI_EPOLL_H__ */
> diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
> index b399225b9..4b77c3bd0 100644
> --- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
> +++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
> @@ -20,7 +20,11 @@ static void *bad_addr;

>  static void run(void)
>  {
> -	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, NULL, bad_addr),
> +	/*
> +	 * Use raw syscalls, libc wrappers may dereference sigmask in
> +	 * userspace (e.g. 32-bit Bionic) and crash with SIGSEGV.
> +	 */
> +	TST_EXP_FAIL(do_sys_epoll_pwait(efd, &e, 1, NULL, bad_addr),
>  		     EFAULT, "with an invalid sigmask pointer");
>  }

> diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
> index e215a6540..07d2ac8ca 100644
> --- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
> +++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
> @@ -13,21 +13,35 @@
>  #define MSEC_PER_SEC (1000L)
>  #define NSEC_PER_MSEC (1000000L)

> -static int do_epoll_pwait(int epfd, struct epoll_event *events, int
> -	maxevents, struct timespec *timeout, const sigset_t *sigmask)
> +static inline int epoll_timeout_ms(const struct timespec *timeout)
> +{
> +	if (!timeout)
> +		return -1;
> +
> +	return timeout->tv_sec * MSEC_PER_SEC +
> +		(timeout->tv_nsec + NSEC_PER_MSEC - 1) / NSEC_PER_MSEC;
> +}
> +
> +static inline int do_epoll_pwait(int epfd, struct epoll_event *events,
> +	int maxevents, struct timespec *timeout, const sigset_t *sigmask)
>  {
>  	if (tst_variant == 1)
>  		return epoll_pwait2(epfd, events, maxevents, timeout, sigmask);

> -	int timeout_ms = -1;
> +	return epoll_pwait(epfd, events, maxevents, epoll_timeout_ms(timeout),
> +			   sigmask);
> +}

> -	if (timeout) {
> -		timeout_ms = timeout->tv_sec * MSEC_PER_SEC;
> -		timeout_ms += (timeout->tv_nsec + NSEC_PER_MSEC - 1) /
> -			NSEC_PER_MSEC;
> +static inline int do_sys_epoll_pwait(int epfd, struct epoll_event *events,
> +	int maxevents, struct timespec *timeout, const sigset_t *sigmask)
> +{
> +	if (tst_variant == 1) {
> +		return sys_epoll_pwait2(epfd, events, maxevents, timeout,
> +					sigmask);
>  	}

> -	return epoll_pwait(epfd, events, maxevents, timeout_ms, sigmask);
> +	return sys_epoll_pwait(epfd, events, maxevents,
> +			       epoll_timeout_ms(timeout), sigmask);
>  }

>  static void epoll_pwait_init(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
