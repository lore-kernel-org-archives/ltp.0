Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803A8D597C9
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731466849; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0qOEt/OUHzJh7Q2YHwVXYHtSLiAzTM19y75pEUP0p1o=;
 b=MFHDsr2XIDrzk9TiC0LzKQhs2UQdon00OcH23zUnPd3K/D5pFXFcfWq/5vLF9KJ3Mvb2y
 w3Aw/w9JEh1Uzz+kCSHpYVlR4uFCeipl7/svChvFBfSEPYH+qj0xffXhQjvUvQgHx/HAKcK
 ewJDbqjsDB3FmcCJLdcjK183g8y78x8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D34C93D6420
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 04:00:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA2E33D63E8
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 04:00:28 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 34B2B1182ADC
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 04:00:27 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-382026ba43eso1734018f8f.1
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 19:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731466826; x=1732071626; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FaEc6W1w1lK8Q4bA1raV2OuJtGtCE0iooPyn/KkpbaU=;
 b=LqJnP1xVB9FRWAPg4M4AxYlG5MQcRix7EZ09j4oXqe9FUyucT+mxmdXBxyVnrbJgiC
 ph2oqtR+DT2OGh9lajSUJ13sm4Xwg8AlluUb1FnXy1p9YSw+wYr/yi04ZL6mIZn+sCZT
 hG+Euy2CONt3r9yNf0Y+FageBQ3CisyA5NN0fJlwNevDUhlEfXB/ms2q7gSL71D2+Fho
 t2SaSQRmpQcAmslNiqYUNxFrOLBNgtMhFaSTxJ+h6GhPbaZTIsdF/TiCUMVlJh8HL3iV
 1rAT5CZXVNVPfBUUgiTq4ankQg5/VxsYi37aLUjn+ev+9kO6MD1LsfYTK/qhMR4TCEGZ
 2rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731466826; x=1732071626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaEc6W1w1lK8Q4bA1raV2OuJtGtCE0iooPyn/KkpbaU=;
 b=WRlZWwsVqsl3b54HgNk3fdm/cfAlyIQOFEXO0fDSlmkWHdbSMvY9IAtXMX75bVlQmK
 eETyR+yacvqH+1Chw2LRMTQNBJ0m0IJQHK/Ed4L65GwD/fYVT+w3IuZLmjrgy7Dbh4IW
 7p394WFD68naLYwv8q4JDi1FMg/WuCORwGp6TID2tSYcO3fXQ17SRiN7qYwAnV0ycgDU
 ZD6Da4c7PPolQRGy2B8p/+Byqey4ivyR6hGJw/rYk0fkLe3vfleE7P42HUscKYaedvlq
 cJMdhYzRaNBTBLgUuZS3DXXGpUGrAvtW4gU1yK58qKxNeYqI2jfx09IY4cU8cByMrfN0
 7AUw==
X-Gm-Message-State: AOJu0YwcL23DzKHZ6ZTLRpKJQ/XU38Ud2zQv4uLqKg6B+SO9PuOADw4B
 7V0kWjcZR2QHq86QaID0ic/RXzG5+TiDCxktfvP3ivoWqZoGJ8E/cHWRCX4hTQ==
X-Google-Smtp-Source: AGHT+IEZ5qS6HN5AeiDSDPrqm3b+2vvvSbIoiDIKt/cPx+jkclC4pePFZ7nHvJl4CHIN/O+xjVVmGQ==
X-Received: by 2002:a05:6000:1fa3:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-382080f7025mr4244255f8f.11.1731466826574; 
 Tue, 12 Nov 2024 19:00:26 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e5810csm101290245ad.179.2024.11.12.19.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 19:00:26 -0800 (PST)
Date: Tue, 12 Nov 2024 22:00:21 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzQWRTZTrWWMDNDv@wegao>
References: <20241112171831.156440-1-pvorel@suse.cz>
 <20241112171831.156440-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112171831.156440-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mq_timedreceive01: Workaround segfault on
 libc variant on 32 bit
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

On Tue, Nov 12, 2024 at 06:18:31PM +0100, Petr Vorel wrote:
> EFAULT test segfaults on newer kernels (e.g. 6.4) on libc variant on
> 32bit.  Similarly to 1d4d5a0750 use typical LTP workaround to test by
> forked child + checking the terminating signal.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../mq_timedreceive/mq_timedreceive01.c       | 78 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> index d4f447d047..a5a43a1771 100644
> --- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> +++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> @@ -129,32 +129,16 @@ static void setup(void)
>  	setup_common();
>  }
>  
> -static void do_test(unsigned int i)
> +
> +static void verify_mqt_receive(unsigned int i, pid_t pid)
>  {
>  	struct time64_variants *tv = &variants[tst_variant];
>  	const struct test_case *tc = &tcase[i];
> -	unsigned int j;
> -	unsigned int prio;
>  	size_t len = MAX_MSGSIZE;
>  	char rmsg[len];
> -	pid_t pid = -1;
>  	void *abs_timeout;
> -
> -	tst_ts_set_sec(&ts, tc->tv_sec);
> -	tst_ts_set_nsec(&ts, tc->tv_nsec);
> -
> -	if (tc->signal)
> -		pid = set_sig(tc->rq, tv->clock_gettime);
> -
> -	if (tc->timeout)
> -		set_timeout(tc->rq, tv->clock_gettime);
> -
> -	if (tc->send) {
> -		if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
> -			tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
> -			return;
> -		}
> -	}
> +	unsigned int j;
> +	unsigned int prio;
>  
>  	if (tc->invalid_msg)
>  		len -= 1;
> @@ -208,6 +192,60 @@ static void do_test(unsigned int i)
>  			TST_RET, prio, len);
>  }
>  
> +static void test_bad_addr(unsigned int i)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +	pid_t pid;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		verify_mqt_receive(i, pid);
> +		_exit(0);
nit:
If this is a normal exit, i suggest use s/_exit(0)/exit(0) ?
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFEXITED(status) && !WEXITSTATUS(status))
> +		return;
> +
> +	if (tv->ts_type == TST_LIBC_TIMESPEC &&
> +		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "Child killed by expected signal");
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "Child %s", tst_strstatus(status));
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +	const struct test_case *tc = &tcase[i];
> +	pid_t pid = -1;
> +
> +	tst_ts_set_sec(&ts, tc->tv_sec);
> +	tst_ts_set_nsec(&ts, tc->tv_nsec);
> +
> +	if (tc->bad_ts_addr) {
> +		test_bad_addr(i);
> +		return;
> +	}
> +
> +	if (tc->signal)
> +		pid = set_sig(tc->rq, tv->clock_gettime);
> +
> +	if (tc->timeout)
> +		set_timeout(tc->rq, tv->clock_gettime);
> +
> +	if (tc->send && tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
> +		tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
> +		return;
> +	}
> +
> +	verify_mqt_receive(i, pid);
> +}
> +
>  static struct tst_test test = {
>  	.tcnt = ARRAY_SIZE(tcase),
>  	.test = do_test,
> -- 
> 2.47.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
