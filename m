Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC26D2E9D6
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 10:38:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B6C3D535A
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 11:38:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A88E3CAC79
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 11:37:52 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 71817148F447
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 11:37:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F9771F38E;
 Mon, 11 Nov 2024 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731321469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+Sbq27w8vvfRkVHFLav7biq0CrB7+tXJuKgFv2gUPs=;
 b=2u637oD+4LqX21IsMNWd3+U+ctIcZm0bt/kJpUnwMpqQ4WiLKwTar6Ub2gqeYjBx/7uO8a
 os8huANXXPFd3uOVT6Jd++lsszJ648IOC16T8qLo1/yRt8PZ9Q4BzHnZ/eR3CSMbO0rz5c
 DgY2TKN7gmrzvVE2rC9pUlP15OO1dMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731321469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+Sbq27w8vvfRkVHFLav7biq0CrB7+tXJuKgFv2gUPs=;
 b=TWWqsUb6X4lIIZLaQuDFyRmdMV2whDaX/8qwHQI90sKQzK2qHXa/Ro++Dc3+7hLn+Fejc6
 VPlR6cjPex9rp3Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731321469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+Sbq27w8vvfRkVHFLav7biq0CrB7+tXJuKgFv2gUPs=;
 b=2u637oD+4LqX21IsMNWd3+U+ctIcZm0bt/kJpUnwMpqQ4WiLKwTar6Ub2gqeYjBx/7uO8a
 os8huANXXPFd3uOVT6Jd++lsszJ648IOC16T8qLo1/yRt8PZ9Q4BzHnZ/eR3CSMbO0rz5c
 DgY2TKN7gmrzvVE2rC9pUlP15OO1dMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731321469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+Sbq27w8vvfRkVHFLav7biq0CrB7+tXJuKgFv2gUPs=;
 b=TWWqsUb6X4lIIZLaQuDFyRmdMV2whDaX/8qwHQI90sKQzK2qHXa/Ro++Dc3+7hLn+Fejc6
 VPlR6cjPex9rp3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 109ED13301;
 Mon, 11 Nov 2024 10:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fo8sA33eMWcMHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Nov 2024 10:37:49 +0000
Date: Mon, 11 Nov 2024 11:37:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzHehDjWzY7ZMXyC@yuki.lan>
References: <20241108122139.87974-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241108122139.87974-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] recvmmsg01: Workaround segfault on libc
 variant on 32 bit
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -static void do_test(unsigned int i)
> +static void verify_recvmmsg(unsigned int i, void *timeout)
>  {
>  	struct time64_variants *tv = &variants[tst_variant];
>  	struct test_case *tc = &tcase[i];
> -	void *timeout;
>  
>  	ts.type = tv->ts_type;
>  	tst_ts_set_sec(&ts, tc->tv_sec);
>  	tst_ts_set_nsec(&ts, tc->tv_nsec);
>  
> +	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
> +		      tc->exp_errno, "recvmmsg() %s", tc->desc);
> +}
> +
> +static void test_bad_addr(unsigned int i)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +	void *timeout = bad_addr;
> +	pid_t pid;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		verify_recvmmsg(i, timeout);
> +		_exit(!TST_PASS);

This should be just exit(0). The child should either crash or exit with
0 any other result should be considered a bug.

> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFEXITED(status))
                             ^
			     && !WEXITSTATUS(status))
> +		return;
> +
> +	if (tv->ts_type == TST_LIBC_TIMESPEC &&
> +		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "Child killed by signal");
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "Child %s", tst_strstatus(status));
> +}

The rest looks good to me, with the minor fixed applied:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
