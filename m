Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E43C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 09:46:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 589823CE219
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 10:46:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD9943CD195
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 10:45:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04F6860151F
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 10:45:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84AA421F17;
 Tue, 23 Jan 2024 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706003156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKJDNjpfkCo6RM15HftCkLVFse939dSolw+FV7pQrak=;
 b=o/miiVcRi72veKhNxNzHpO0XnaC1T+jMq1uPY05wZAGUmQcK/CmdsLAth5nWZuWIgYsr/k
 UTSkUHBxpFB+qZq9fpQmroo/9SUIqChKtVAK5ZmBm4cXemvG96sbHcNSyyHsviRoGutAh9
 KfQ59RvYDBiBHuUhsNpltBlgaHNQcTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706003156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKJDNjpfkCo6RM15HftCkLVFse939dSolw+FV7pQrak=;
 b=cbfX1uM2BLH0w+EQvp5DrYw7CsndQbHJ0WZhFp7Fh4rfY7bYfXBbtWDMbwPdY5HbyFz5Vg
 RtA5udWVJX5W1yAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706003156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKJDNjpfkCo6RM15HftCkLVFse939dSolw+FV7pQrak=;
 b=o/miiVcRi72veKhNxNzHpO0XnaC1T+jMq1uPY05wZAGUmQcK/CmdsLAth5nWZuWIgYsr/k
 UTSkUHBxpFB+qZq9fpQmroo/9SUIqChKtVAK5ZmBm4cXemvG96sbHcNSyyHsviRoGutAh9
 KfQ59RvYDBiBHuUhsNpltBlgaHNQcTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706003156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKJDNjpfkCo6RM15HftCkLVFse939dSolw+FV7pQrak=;
 b=cbfX1uM2BLH0w+EQvp5DrYw7CsndQbHJ0WZhFp7Fh4rfY7bYfXBbtWDMbwPdY5HbyFz5Vg
 RtA5udWVJX5W1yAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2157D136A4;
 Tue, 23 Jan 2024 09:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vWOwAtSKr2VPCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 09:45:56 +0000
Date: Tue, 23 Jan 2024 10:45:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240123094554.GC149835@pevik>
References: <20240117080446.9663-1-wegao@suse.com>
 <20240117125227.24700-1-wegao@suse.com>
 <20240117125227.24700-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117125227.24700-3-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o/miiVcR";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cbfX1uM2
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 84AA421F17
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] getcwd01: Implement .test_variants
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

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/getcwd/getcwd01.c | 80 +++++++++++++++------
>  1 file changed, 60 insertions(+), 20 deletions(-)

> NOTE: Cyril give solution for run the test in a child and pass
> the test both on EFAULT and child being killed by SIGSEGV. But
> currently i have no idea how to do it since no SIGSEGV will hapeen
> if NULL buffer give to getcwd. This file just used for give a real
> user case for TST_EXP_FAIL_PTR.

@Cyril, could you please point out test which uses similar approach?
Maybe these?
testcases/kernel/syscalls/fstat/fstat03.c
testcases/kernel/syscalls/ipc/shmat/shmat01.c
testcases/kernel/syscalls/kill/kill11.c
testcases/kernel/syscalls/setrlimit/setrlimit05.c

Or can the current approach be used?

Below only nits (formatting).

> diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> index 218bf4ef2..879c36206 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> @@ -3,21 +3,34 @@
>   * Copyright (c) International Business Machines Corp., 2001

IBM in 2001 could be proud on this code :). There should have been some
copyright, I would add:
 * Copyright (c) Linux Test Project, 2002-2024

>   */

> -/*
> - * DESCRIPTION
> +/*\
> + * [Description]
> + *
>   * Testcase to test that getcwd(2) sets errno correctly.
> + *
> + * 1. getcwd(2) fails if buf points to a bad address.
> + * 2. getcwd(2) fails if the size is invalid.
> + * 3. getcwd(2) fails if the size is set to 0.
> + * 4. getcwd(2) fails if the size is set to 1.
> + * 5. getcwd(2) fails if buf points to NULL and the size is set to 1.
>   *
>   * Expected Result:
> + *
> + * linux syscall
> + *
> + * 1. getcwd(2) should return NULL and set errno to EFAULT.
I don't like repeating "getcwd(2) should return NULL and set errno to"

> + * 2. getcwd(2) should return NULL and set errno to EFAULT.
> + * 3. getcwd(2) should return NULL and set errno to ERANGE.
> + * 4. getcwd(2) should return NULL and set errno to ERANGE.
> + * 5. getcwd(2) should return NULL and set errno to ERANGE.
> + *
> + * glibc and uclibc{,-ng}.
Although in the past LTP developers cared only about glibc, now we generally
don't stick to any libc implementation. Thus it should be "libc syscall wrapper"

> + *
> + * 1. getcwd(2) should return NULL and set errno to EFAULT.
> + * 2. getcwd(2) should return NULL and set errno to ENOMEM.
> + * 3. getcwd(2) should return NULL and set errno to EINVAL.
> + * 4. getcwd(2) should return NULL and set errno to ERANGE.
> + * 5. getcwd(2) should return NULL and set errno to ERANGE.
>   */

How about to make it simple like this:
/*\
 * [Description]
 *
 * Testcase to test that getcwd(2) returns NULL and sets errno correctly.
 *
 * 1. getcwd(2) fails if buf points to a bad address (EFAULT).
 * 2. getcwd(2) fails if the size is invalid (syscall: EFAULT, libc wrapper: ENOMEM).
 * 3. getcwd(2) fails if the size is set to 0 (syscall: ERANGE, libc wrapper: EINVAL).
 * 4. getcwd(2) fails if the size is set to 1 (ERANGE).
 * 5. getcwd(2) fails if buf points to NULL and the size is set to 1 (ERANGE).
 */

>  #include <errno.h>
> @@ -32,23 +45,50 @@ static struct t_case {
>  	char *buf;
>  	size_t size;
>  	int exp_err;
> +	int exp_err_libc;
>  } tcases[] = {
> -	{(void *)-1, PATH_MAX, EFAULT},
> -	{NULL, (size_t)-1, EFAULT},
> -	{buffer, 0, ERANGE},
> -	{buffer, 1, ERANGE},
> -	{NULL, 1, ERANGE}
> +	{(void *)-1, PATH_MAX, EFAULT, EFAULT},
> +	{NULL, (size_t)-1, EFAULT, ENOMEM},
> +	{buffer, 0, ERANGE, EINVAL},
> +	{buffer, 1, ERANGE, ERANGE},
> +	{NULL, 1, ERANGE, ERANGE},
>  };

> +static inline void tst_getcwd(char *buf, size_t size, int exp_err, int exp_err_libc)
> +{
> +
> +	if (tst_variant == 0)
> +		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
> +	else
> +		TST_EXP_FAIL_PTR(getcwd(buf, size), exp_err_libc);
> +}
+1

> -static void verify_getcwd(unsigned int n)
> +static void run(unsigned int n)
>  {
>  	struct t_case *tc = &tcases[n];

> -	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
> +	/* https://github.com/linux-test-project/ltp/issues/1084 */
IMHO this comment should go to the commit message.

> +#if !defined(__GLIBC__) && !defined(__ANDROID__)
I'll ask AOSP developers to check this.

> +	if (tst_variant && !tc->buf) {
> +		tst_res(TCONF, "NULL buffer test skipped on MUSL due different implementation");
> +		return;
> +	}
> +#endif
> +
> +	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err_libc);
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_variant == 0)
> +		tst_res(TINFO, "Testing getcwd with raw syscall");
> +	else
> +		tst_res(TINFO, "Testing getcwd with wrap syscall");

"wrap syscall" => "libc syscall wrapper"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
