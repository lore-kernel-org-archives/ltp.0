Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617B1C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:17:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D90D03CA9D9
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:17:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A70E63CA921
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:17:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4CCC600D31
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:17:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED38521C62;
 Thu, 12 May 2022 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652357831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJTyKpHQFIEunpGbvCOQeFk/U/Evo0cClA5TqpqLzBs=;
 b=RxaX51eDwJzmLqjLjCEGbGgLnoMd1mG7DmwXHQMm8ghdgdoGeQJVy4L1b2786Ub3C5WA+5
 kKBw8BUEREnEV2Kxj4W1rJAjO5CDI/kYp3xaa0PYZisHDHzeG51iYDncYaNaUhZr7j4ACp
 d2ZhfJJYmADBAo+2KAbvLAUcETjiOD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652357831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJTyKpHQFIEunpGbvCOQeFk/U/Evo0cClA5TqpqLzBs=;
 b=OAGmRg7EaKcenmSQnFwYODV3X+ZJnlMuVMZR29O18YR0OBoVF5wgd5b6sYx4TfMERmnwyT
 vT23SKBzY8UhE7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC83F13A84;
 Thu, 12 May 2022 12:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZtOoMMf6fGLWDwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:17:11 +0000
Date: Thu, 12 May 2022 14:19:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Ynz7TSVSxhM+1lM1@yuki>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz> <87a6bwe7ps.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6bwe7ps.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static int multiply_runtime(void)
> > +{
> > +	static float runtime_mul = -1;
> > +
> > +	if (tst_test->max_iteration_runtime <= 0)
> > +		return tst_test->max_iteration_runtime;
> 
> nit; IMO it would be easier to understand if it returned
> TST_UNLIMITED_RUNTIME.

I wanted to keep this as a passthrough for any other possible values we
may add in the future, but I guess that we will not.

> > +
> > +	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
> > +
> > +	return tst_test->max_iteration_runtime * runtime_mul;
> > +}
> > +
> >  static struct option {
> >  	char *optstr;
> >  	char *help;
> > @@ -477,6 +514,7 @@ static struct option {
> >  static void print_help(void)
> >  {
> >  	unsigned int i;
> > +	int timeout, runtime;
> >  
> >  	/* see doc/user-guide.txt, which lists also shell API variables */
> >  	fprintf(stderr, "Environment Variables\n");
> > @@ -489,10 +527,32 @@ static void print_help(void)
> >  	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> >  	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
> >  	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
> > +	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
> >  	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
> >  	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
> >  	fprintf(stderr, "\n");
> >  
> > +	fprintf(stderr, "Timeout and runtime\n");
> > +	fprintf(stderr, "-------------------\n");
> > +
> > +	if (tst_test->max_iteration_runtime) {
> > +		runtime = multiply_runtime();
> > +
> > +		if (runtime == TST_UNLIMITED_RUNTIME) {
> > +			fprintf(stderr, "Test iteration runtime is not limited\n");
> > +		} else {
> > +			fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
> > +				runtime/3600, (runtime%3600)/60, runtime % 60);
> > +		}
> > +	}
> > +
> > +	timeout = tst_multiply_timeout(DEFAULT_TIMEOUT);
> > +
> > +	fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
> > +		timeout/3600, (timeout%3600)/60, timeout % 60);
> > +
> > +	fprintf(stderr, "\n");
> > +
> >  	fprintf(stderr, "Options\n");
> >  	fprintf(stderr, "-------\n");
> >  
> > @@ -620,7 +680,10 @@ static void parse_opts(int argc, char *argv[])
> >  			iterations = atoi(optarg);
> >  		break;
> >  		case 'I':
> > -			duration = atof(optarg);
> > +			if (tst_test->max_iteration_runtime > 0)
> > +				tst_test->max_iteration_runtime =
> > atoi(optarg);
> 
> Doesn't this change the semantics of -I? Duration does not seem to be
> per iteration, but overall execution time.

That's why I asked if we should override the -I or add a new option.

The thing is that setting overall execution time is simply wrong, as we
figured out previously, since in many cases we do not know in advance
how many variants will the test run until we actually start executing
it.

Also the -I option was kind of behaving like this from the start, since
the duration variable it sets applies on the most inner call (the
testrun() function in tst_test.c).

So all in all this patchset just fixes the -I option for long running
tests so that the runtime is actually propagated to the test itself.

> > +			else
> > +				duration = atof(optarg);
> >  		break;
> >  		case 'C':
> >  #ifdef UCLINUX
> > @@ -1034,6 +1097,11 @@ static void do_setup(int argc, char *argv[])
> >  	if (!tst_test)
> >  		tst_brk(TBROK, "No tests to run");
> >  
> > +	if (tst_test->max_iteration_runtime < -1) {
> > +		tst_brk(TBROK, "Invalid runtime value %i",
> > +			results->max_iteration_runtime);
> > +	}
> > +
> >  	if (tst_test->tconf_msg)
> >  		tst_brk(TCONF, "%s", tst_test->tconf_msg);
> >  
> > @@ -1404,39 +1472,36 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
> >  }
> >  
> >  unsigned int tst_timeout_remaining(void)
> > +{
> > +	tst_brk(TBROK, "Stub called!");
> > +	return 0;
> > +}
> > +
> > +unsigned int tst_remaining_runtime(void)
> >  {
> >  	static struct timespec now;
> > -	unsigned int elapsed;
> > +	int elapsed;
> > +
> > +	if (results->max_iteration_runtime == TST_UNLIMITED_RUNTIME)
> > +		return UINT_MAX;
> > +
> > +	if (results->max_iteration_runtime == 0)
> > +		tst_brk(TBROK, "Runtime not set!");
> >  
> >  	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
> >  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> >  
> > -	elapsed = (tst_timespec_diff_ms(now, tst_start_time) + 500) / 1000;
> > -	if (results->timeout > elapsed)
> > -		return results->timeout - elapsed;
> > +	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
> > +	if (results->max_iteration_runtime > elapsed)
> > +		return results->max_iteration_runtime - elapsed;
> >  
> >  	return 0;
> >  }
> >  
> > +
> >  unsigned int tst_multiply_timeout(unsigned int timeout)
> >  {
> > -	char *mul;
> > -	int ret;
> > -
> > -	if (timeout_mul == -1) {
> > -		mul = getenv("LTP_TIMEOUT_MUL");
> > -		if (mul) {
> > -			if ((ret = tst_parse_float(mul, &timeout_mul, 1, 10000))) {
> > -				tst_brk(TBROK, "Failed to parse LTP_TIMEOUT_MUL: %s",
> > -						tst_strerrno(ret));
> > -			}
> > -		} else {
> > -			timeout_mul = 1;
> > -		}
> > -	}
> > -	if (timeout_mul < 1)
> > -		tst_brk(TBROK, "LTP_TIMEOUT_MUL must to be int >= 1! (%.2f)",
> > -				timeout_mul);
> > +	parse_mul(&timeout_mul, "LTP_TIMEOUT_MUL", 0.099, 10000);
> >  
> >  	if (timeout < 1)
> >  		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
> > @@ -1446,37 +1511,48 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
> >  
> >  void tst_set_timeout(int timeout)
> >  {
> > -	if (timeout == -1) {
> > +	tst_brk(TBROK, "Stub called!");
> > +}
> > +
> > +static void set_timeout(void)
> > +{
> > +	unsigned int timeout = DEFAULT_TIMEOUT;
> > +
> > +	if (results->max_iteration_runtime == TST_UNLIMITED_RUNTIME) {
> >  		tst_res(TINFO, "Timeout per run is disabled");
> >  		return;
> >  	}
> >  
> > -	if (timeout < 1)
> > -		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
> > +	if (results->max_iteration_runtime < 0) {
> > +		tst_brk(TBROK, "max_iteration_runtime must to be >= 0! (%d)",
> 
> It can be -1

Ah right, fixed the comment.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
