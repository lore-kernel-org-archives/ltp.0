Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A957C28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 14:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFBD03C8A99
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 16:09:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A4EC3C2A8C
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 16:09:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A17741A00905
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 16:09:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4A2201D4;
 Mon, 22 Aug 2022 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661177356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsIAh78Zg/dFI2II1sA0QzXXB5wuJnSPvQQWXZMAgpw=;
 b=ClV5k5tg3CcHB0XJb/I70+UF7HVQ/dS+oO72bs4PznMhyFP1cqqcV6COs0dD1jD/5ai56W
 EOasPU2Q8N6HlTl+8Z5XqcV0QUyak5YvnGG7eJUeA+Hav23sRePm6d/Jqt0Xciait81Wa3
 uWGKbgVEIrZGgbIpoNqbXG8xjtbzPSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661177356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsIAh78Zg/dFI2II1sA0QzXXB5wuJnSPvQQWXZMAgpw=;
 b=kzjMRK1ZD5y0GDsUkryxqeGpjVQArYIETWMdPnMhqqheFiG8yUotzGe2zp6lI1L/0Z1eOS
 40FpbLvmEk/d5yDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADCF13523;
 Mon, 22 Aug 2022 14:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BwupHQyOA2NZdQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Aug 2022 14:09:16 +0000
Date: Mon, 22 Aug 2022 16:11:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <YwOOgSakY7VFN+3e@yuki>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-5-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220822113919.196953-5-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls/statfs: Accept segfault instead
 of EFAULT
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

>  int main(int ac, char **av)
>  {
>  	int lc;
> @@ -67,23 +73,20 @@ int main(int ac, char **av)
>  		tst_count = 0;
>  
>  		for (i = 0; i < TST_TOTAL; i++) {
> +			sig_caught = 0;
> +			if (sigsetjmp(env, 1) == 0)
> +				fstatfs_verify(&TC[i]);
>  
> -			TEST(fstatfs(TC[i].fd, TC[i].sbuf));
> +			if (!sig_caught)
> +				continue;
>  
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> +			if (TC[i].error == EFAULT && sig_caught == SIGSEGV) {
> +				tst_resm(TINFO, "received SIGSEGV instead of returning EFAULT");
> +				tst_resm(TPASS | TTERRNO, "expected failure");

This can be just a signle message tst_resm(TPASS | TERRNO, "Got SIGSEGV intead of EFAULT");

>  				continue;
>  			}
>  
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS, "expected failure - "
> -					 "errno = %d : %s", TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL, "unexpected error - %d : %s - "
> -					 "expected %d", TEST_ERRNO,
> -					 strerror(TEST_ERRNO), TC[i].error);
> -			}
> +			tst_resm(TFAIL, "Received an unexpected signal: %d", sig_caught);
>  		}
>  	}
>  	cleanup();
> @@ -91,9 +94,16 @@ int main(int ac, char **av)
>  	tst_exit();
>  }
>  
> +static void sighandler(int sig)
> +{
> +	sig_caught = sig;
> +	siglongjmp(env, 1);
> +
> +}
> +
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	tst_sig(NOFORK, sighandler, cleanup);

Can we just setup handler for the SIGSEGV signal and keep everything
else for the DEF_HANDLER?

>  	TEST_PAUSE;
>  
> @@ -103,6 +113,24 @@ static void setup(void)
>  #endif
>  }
>  
> +static void fstatfs_verify(const struct test_case_t *test)
> +{
> +	TEST(fstatfs(test->fd, test->sbuf));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "call succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == test->error) {
> +		tst_resm(TPASS, "expected failure - errno = %d : %s",
> +			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	} else {
> +		tst_resm(TFAIL, "unexpected error - %d : %s - expected %d",
> +			 TEST_ERRNO, strerror(TEST_ERRNO), test->error);
> +	}
> +}

If we converted the test to the new test API this would be a single line as:

	TST_EXP_FAIL(fstatfs(test->fd, test->sbuf), test->error, "fstatfs()");

Generally with the new test api the code would be much shorter...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
