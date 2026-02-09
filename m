Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628FFCA5FEB
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 07:52:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 744523C9B0C
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 08:52:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6150F3C7A53
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 08:52:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E410200067
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 08:51:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98DBA3E6C5;
 Mon,  9 Feb 2026 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770623515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hogLijAxhNYD9wgbaQ6bGYnle4tmh9V03PWM7Y+w71I=;
 b=YnoTb+vRN79ELoNIygVuS1yfGAtjdve6WOsVRCs8sLL1wqA3REhO9d6gN1Eo7napH2fzC8
 j4tEeFEbLhIBbyv4GCLb4sv/Fx/3sfWq65eM5ku5CAb+h0/tJxWqymVD1Z7Nh4p44x5ize
 Jigach705GJG/NoiwUqNRn0hL7c+H2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770623515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hogLijAxhNYD9wgbaQ6bGYnle4tmh9V03PWM7Y+w71I=;
 b=6NbwwqE84xEtALjeKmwTQL3WllexWpgVVDnfNzeRyROX+jKMiS3rZk9f7S5iHwj8iCu87r
 2s4Opw3Trjkv5eCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770623515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hogLijAxhNYD9wgbaQ6bGYnle4tmh9V03PWM7Y+w71I=;
 b=YnoTb+vRN79ELoNIygVuS1yfGAtjdve6WOsVRCs8sLL1wqA3REhO9d6gN1Eo7napH2fzC8
 j4tEeFEbLhIBbyv4GCLb4sv/Fx/3sfWq65eM5ku5CAb+h0/tJxWqymVD1Z7Nh4p44x5ize
 Jigach705GJG/NoiwUqNRn0hL7c+H2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770623515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hogLijAxhNYD9wgbaQ6bGYnle4tmh9V03PWM7Y+w71I=;
 b=6NbwwqE84xEtALjeKmwTQL3WllexWpgVVDnfNzeRyROX+jKMiS3rZk9f7S5iHwj8iCu87r
 2s4Opw3Trjkv5eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6861D3EA63;
 Mon,  9 Feb 2026 07:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yKzrFxuSiWl3YQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Feb 2026 07:51:55 +0000
Date: Mon, 9 Feb 2026 08:51:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <20260209075146.GA450151@pevik>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260207145942.299366-1-changwei.zou@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: reserve pre-TCB space to avoid
 undefined behavior in clone10.c
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

Hi Changwei,

> Allocate extra space before the TLS area to hold a struct pthread, ensuring
> THREAD_SELF->cancelhandling is initialized to 0. This prevents undefined
> behavior in __pthread_disable_asynccancel(), which is called at thread
> cancellation points such as write().

> Without this, touch_tls_in_child() could get stuck in tst_res().

LGTM, but I'd prefer others had a look on it.
Acked-by: Petr Vorel <pvorel@suse.cz>

BTW clone10.c segfaults w/a the patch when run with more iterations:

./clone10 -i200
clone10.c:48: TINFO: Child (PID: 4271, TID: 4285): TLS value set to: 101
clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
clone10.c:48: TINFO: Child (PID: 4271, TID: 4286): TLS value set to: 101
clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
tst_test.c:1953: TBROK: Test killed by SIGSEGV!

Summary:
passed   15
failed   0
broken   1
skipped  0
warnings 0

Kind regards,
Petr

> (gdb) bt
>   0  futex_wait () at ../sysdeps/nptl/futex-internal.h:141
>   1  futex_wait_simple () at ../sysdeps/nptl/futex-internal.h:172
>   2  __libc_disable_asynccancel () at ../nptl/cancellation.c:100
>   3  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:26
>   4  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:24
>   5  print_result ()  at tst_test.c:387
>   6  tst_vres_ () at tst_test.c:401
>   7  tst_res_ () at tst_test.c:512
>   8  touch_tls_in_child (arg=<optimized out>) at clone10.c:48
>   9  thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

> Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
> ---
>  include/lapi/tls.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

> diff --git a/include/lapi/tls.h b/include/lapi/tls.h
> index 468fe3086..7f2fa18a1 100644
> --- a/include/lapi/tls.h
> +++ b/include/lapi/tls.h
> @@ -22,6 +22,15 @@
>  #define TLS_SIZE 4096
>  #define TLS_ALIGN 16

> +/*
> + * Space allocated large enough to hold a struct pthread.
> + *
> + * Zero-initialized to ensure THREAD_SELF->cancelhandling starts at 0,
> + * avoiding undefined behavior (e.g., in clone10.c) in __pthread_disable_asynccancel(),
> + * which is called at thread cancellation points such as write().
> + */
> +#define TLS_PRE_TCB_SIZE (TLS_ALIGN * 256)
> +
>  #if defined(__x86_64__)
>  typedef struct {
>  	void *tcb;
> @@ -36,10 +45,11 @@ extern void *tls_ptr;

>  static inline void *allocate_tls_area(void)
>  {
> -	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
> +	char *tls_area = aligned_alloc(TLS_ALIGN, TLS_PRE_TCB_SIZE + TLS_SIZE);
>  	if (!tls_area)
>  		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
> -	memset(tls_area, 0, TLS_SIZE);
> +	memset(tls_area, 0, TLS_PRE_TCB_SIZE + TLS_SIZE);
> +	tls_area += TLS_PRE_TCB_SIZE;

>  #if defined(__x86_64__)
>  	tcb_t *tcb = (tcb_t *)tls_area;
> @@ -59,7 +69,7 @@ static inline void free_tls(void)
>  {
>  	usleep(10000);
>  	if (tls_ptr) {
> -		free(tls_ptr);
> +		free(((char *)tls_ptr) - TLS_PRE_TCB_SIZE);
>  		tls_ptr = NULL;
>  	}
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
