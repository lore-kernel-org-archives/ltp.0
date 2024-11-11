Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB22D5E39A
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731313871; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mqywP58YPALj/r1+Ion9gTj5smp3u+hDTrUaoaWEaHI=;
 b=LThoJI3qC2JdtDi4vzOFOa9V5QUpxpIK1YQiJeOWx53J7ygdOnbTl5jmlPXKz3vATxcwP
 puMNZkNb4qBbKx2h62YemTOINq3g8sz1skng84C50rGsc1121b0t/abtouwuyp9tTlm80on
 cK2cqfEgdq6FeS9UA1+Soq5jOxzG5jA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7163D5281
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 09:31:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 649353D5264
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 09:30:53 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7BE5A1BD2AD8
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 09:30:52 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso762689966b.1
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 00:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731313852; x=1731918652; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tCvSb+haynmgvH+yuw7oFUddnwergLk5Mj6w58GPhBs=;
 b=AEallIG7cnkLSpJDr+ybucfW6cfbCEg4QKmkU+4AFVCHQ9ZgEGajEIORpLpdjsRJIs
 CglyzdrlAKMgmNntjqbwz5G42BPmAIItuBHH7qm2+/UjCW+vdGWYj89ZH3BhAZxmtSV0
 LZTNU8rqRZN2pz508UnEPWt8KvXulxklTZFQsi5iSUyn3Ndgz4a6oS+NPZi+XvyXqU2H
 X+EYt9yvXdS4eq8/EVpctyQZBhc5Wb498I+AIMtUkeLAaYRboc1zoGqY5fYwiPjFMZFI
 acTCBzbjSWe7wE0OKf/mJSf//6rxzqA/vkwGtrjRrt9nXTN0SqdplzvIfwDsiHF9+Rxn
 E0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731313852; x=1731918652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCvSb+haynmgvH+yuw7oFUddnwergLk5Mj6w58GPhBs=;
 b=VzFgQrmVmBA2WIo4OCLxmido9qmy2yNLNeyEEnYfA6u2J7phIdAUybTTy9FnVJIBNn
 N4s3QT1yCq6tPbMQi/V6qF8sthX/pUf0vM08ctcl6c+qHJ/K6ecHk3U3lGctkGEdBVbN
 4tTXOHHjPkWx6AgbeJjEqKUY1VPcJ3vmievk0j1BgFyBGDMsDq0+MTx+2V12aJzZdjxs
 VIWGV9IlSeHs2llHMvtJxR1TL/CEhw/UG7hJNk5odNr+mRl1pX0dTA7q6ep7S6L4N+Lg
 OmOTZzGaUAicIhcQgkpOI5cphmMiGTkWZnuPIfKoXdBvQQTRrTcSaEFi7Ne/3wustrEi
 z/rg==
X-Gm-Message-State: AOJu0Yyy9Qbwz/VdiXf4x8+zJIDc8qee7AKy35fPeGtm0KeVyheBO6ry
 Edj8ZVrGDt03RhFGWGzK1RmZraeBbR/pSoMdjHayeWiJm6bm4IfD6XiFsNFQ6Vu4mdxprGRWgWk
 =
X-Google-Smtp-Source: AGHT+IFFvBOwDrE7Z6YY8yohoJdXDhLsQJFflnFHeWXijMbrSmRQq1u2ovGh9KkkcNfgcWw6ERrJTQ==
X-Received: by 2002:a17:907:3fa5:b0:a9e:b287:2808 with SMTP id
 a640c23a62f3a-a9eefeafae0mr1171133966b.6.1731313851756; 
 Mon, 11 Nov 2024 00:30:51 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4c1ffsm567167066b.79.2024.11.11.00.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 00:30:51 -0800 (PST)
Date: Mon, 11 Nov 2024 03:30:45 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzHAtb2Zqc7Ffpzi@wegao>
References: <20241108122139.87974-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241108122139.87974-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 08, 2024 at 01:21:39PM +0100, Petr Vorel wrote:
> EFAULT test segfaults on newer kernels (e.g. 6.4) on libc variant on
> 32bit.  Use typical LTP workaround to test by forked child + checking
> the terminating signal.
> 
> NOTE: testing kernel variants could be done without forking child, but
> use it as well for simplicity.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: working on other 3 tests affected by the same problem
> (mq_timedreceive01.c, mq_timedsend01.c,  sigtimedwait01.c).
> 
>  .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 48 +++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> index fb21ea1e70..46658b133d 100644
> --- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> +++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> @@ -47,7 +47,7 @@ static struct test_case tcase[] = {
>  		.desc = "bad message vector address",
>  		.fd = &receive_sockfd,
>  		.exp_errno = EFAULT,
> -		.msg_vec = (void*)&bad_addr,
> +		.msg_vec = (void *)&bad_addr,
>  	},
>  	{
>  		.desc = "negative seconds in timeout",
> @@ -74,23 +74,54 @@ static struct test_case tcase[] = {
>  	}
>  };
>  
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
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFEXITED(status))
> +		return;
> +
> +	if (tv->ts_type == TST_LIBC_TIMESPEC &&
> +		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "Child killed by signal");
very nit: 
1) s/Child killed by signal/Child killed by SIGSEGV signal/
2) suggest also print out tc->desc

Thanks for create patch fix our current issue.
Reviewed-by: Wei Gao <wegao@suse.com>
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "Child %s", tst_strstatus(status));
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +
>  	if (tc->bad_ts_addr)
> -		timeout = bad_addr;
> +		test_bad_addr(i);
>  	else
> -		timeout = tst_ts_get(&ts);
> -
> -	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
> -	             tc->exp_errno, "recvmmsg() %s", tc->desc);
> +		verify_recvmmsg(i, tst_ts_get(&ts));
>  }
>  
>  static void setup(void)
> @@ -139,6 +170,7 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_variants = ARRAY_SIZE(variants),
> +	.forks_child = 1,
>  	.bufs = (struct tst_buffers []) {
>  		{&iov, .iov_sizes = (int[]){1, -1}},
>  		{&msg, .size = VLEN * sizeof(*msg)},
> -- 
> 2.45.2
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
