Return-Path: <SRS0=1KVt=O3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067BC433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 11:35:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AD160FD7
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 11:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50AD160FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C31F73C7F45
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 13:35:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B6BE3C1CC3
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 13:34:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B21CA1000B22
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 13:34:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E19B200B0;
 Thu,  7 Oct 2021 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633606491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtB5YJjGcQGpSQK/GR1ogzVWlq6YaXzrnqxVA0sagRk=;
 b=S7WIkc/Whvh8qauO1GchuT9YvVlgXq4iOLPJT02rPM6nZF5XEK0Sk6ZlRG8JiFnHfYRJu7
 ucK4G8nJnhm4udgPNjjV9QHZ6RTtzeLyBBVpYjhlrfmGuFrsCU8OqcNTnE5wFmQ4Zd75aB
 atZJkU8zjjz3Ie/UisDCAwSzgVpaPwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633606491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtB5YJjGcQGpSQK/GR1ogzVWlq6YaXzrnqxVA0sagRk=;
 b=bH//dDhISrM+1G7HfHiAuXRDrOXW+imn5eSZeU04oWdAXgCcaA66GToQ7hVsaHUs9Rdtfm
 COjNyZmjGUzFT7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7822013B92;
 Thu,  7 Oct 2021 11:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /+7SHFvbXmG9dQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Oct 2021 11:34:51 +0000
Date: Thu, 7 Oct 2021 13:35:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YV7bfgmBT+1unI3j@yuki>
References: <20210929083249.22320-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210929083249.22320-1-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/readdir01: Convert to new API
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
> +static void setup(void)
> +{
> +	sprintf(prefix, "%s_%d.", "readdirfile", getpid());

Since the test runs in it's own temporary directory there is no need to
prefix everything with the pid.

> +}
> 
> -/***********************************************************************
> - * Main
> - ***********************************************************************/
> -int main(int ac, char **av)
> +static void verify_readdir(void)
>  {
> -	int lc;
> -	int cnt;
> -	int nfiles, fd;
> +	int i;
> +	int fd;
> +	int cnt = 0;
>  	char fname[255];
>  	DIR *test_dir;
>  	struct dirent *dptr;
> 
> -	tst_parse_opts(ac, av, options, &help);
> -
> -	if (Nflag) {
> -		if (sscanf(Nfilearg, "%i", &Nfiles) != 1) {
> -			tst_brkm(TBROK, NULL, "--N option arg is not a number");
> -		}
> +	for (i = 0; i < nfiles; i++) {
> +		sprintf(fname, "%s_%d", prefix, i);
> +		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
> +		SAFE_WRITE(1, fd, "hello\n", 6);
> +		SAFE_CLOSE(fd);
>  	}

This loop could be moved to the test setup, there is no need to
re-create the files on each iteration.

> 
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
> -	/* Next you should run a setup routine to make sure your environment is
> -	 * sane.
> -	 */
> -	setup();
> -
> -    /***************************************************************
> -     * check looping state
> -     ***************************************************************/
> -	/* TEST_LOOPING() is a macro that will make sure the test continues
> -	 * looping according to the standard command line args.
> -	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		if (Nfiles)
> -			nfiles = Nfiles;
> -		else
> -			/* min of 10 links and max of a 100 links */
> -			nfiles = (lc % 90) + 10;
> -
> -		/* create a bunch of files to look at */
> -		for (cnt = 0; cnt < nfiles; cnt++) {
> -
> -			sprintf(fname, "%s%d", Basename, cnt);
> -			if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
> -				tst_brkm(TBROK, cleanup,
> -					 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
> -					 fname, errno, strerror(errno));
> -			} else if (write(fd, "hello\n", 6) < 0) {
> -				tst_brkm(TBROK, cleanup,
> -					 "write(%s, \"hello\\n\", 6) Failed, errno=%d : %s",
> -					 fname, errno, strerror(errno));
> -			} else if (close(fd) < 0) {
> -				tst_resm(TWARN,
> -					"close(%s) Failed, errno=%d : %s",
> -					fname, errno, strerror(errno));
> -			}
> -		}
> -
> -		if ((test_dir = opendir(".")) == NULL) {
> -			tst_resm(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
> -				 errno, strerror(errno));
> -		} else {
> -			/* count the entries we find to see if any are missing */
> -			cnt = 0;
> -			errno = 0;
> -			while ((dptr = readdir(test_dir)) != 0) {
> -				if (strcmp(dptr->d_name, ".")
> -				    && strcmp(dptr->d_name, ".."))
> -					cnt++;
> -			}
> -
> -			if (errno != 0) {
> -				tst_resm(TFAIL,
> -					 "readir(test_dir) Failed on try %d, errno=%d : %s",
> -					 cnt + 1, errno, strerror(errno));
> -			}
> -			if (cnt == nfiles) {
> -				tst_resm(TPASS,
> -					 "found all %d that were created",
> -					 nfiles);
> -			} else if (cnt > nfiles) {
> -				tst_resm(TFAIL,
> -					 "found more files than were created");
> -				tst_resm(TINFO, "created: %d, found: %d",
> -					 nfiles, cnt);
> -			} else {
> -				tst_resm(TFAIL,
> -					 "found less files than were created");
> -				tst_resm(TINFO, "created: %d, found: %d",
> -					 nfiles, cnt);
> -			}
> -		}
> -
> -		/* Here we clean up after the test case so we can do another iteration.
> -		 */
> -		for (cnt = 0; cnt < nfiles; cnt++) {
> -
> -			sprintf(fname, "%s%d", Basename, cnt);
> -
> -			if (unlink(fname) == -1) {
> -				tst_resm(TWARN,
> -					"unlink(%s) Failed, errno=%d : %s",
> -					Fname, errno, strerror(errno));
> -			}
> -		}
> -
> +	test_dir = SAFE_OPENDIR(".");
> +	while ((dptr = SAFE_READDIR(test_dir)) != 0) {
> +		if (strcmp(dptr->d_name, ".")
> +			&& strcmp(dptr->d_name, ".."))
> +			cnt++;
>  	}

I would have probably written this as:

	while ((ent = SAFE_READDIR(test_dir))) {
		if (!strcmp(ent->d_name, "." || !strcmp(ent->d_name, ".")
			continue;

		cnt++;
	}

Also I guess that we can check that the filename is filled correctly as
well, it has to start with prefix at least.

> -    /***************************************************************
> -     * cleanup and exit
> -     ***************************************************************/
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/***************************************************************
> - * help
> - ***************************************************************/
> -/* The custom help() function is really simple.  Just write your help message to
> - * standard out.  Your help function will be called after the standard options
> - * have been printed
> - */
> -void help(void)
> -{
> -	printf("  -N #files : create #files files every iteration\n");
> -}
> -
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> -{
> -	/* You will want to enable some signal handling so you can capture
> -	 * unexpected signals like SIGSEGV.
> -	 */
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
> -	 * fork the test with the -c option.  You want to make sure you do this
> -	 * before you create your temporary directory.
> -	 */
> -	TEST_PAUSE;
> -
> -	/* If you are doing any file work, you should use a temporary directory.  We
> -	 * provide tst_tmpdir() which will create a uniquely named temporary
> -	 * directory and cd into it.  You can now create files in the current
> -	 * directory without worrying.
> -	 */
> -	tst_tmpdir();
> -
> -	sprintf(Basename, "%s_%d.", BASENAME, getpid());
> +	if (cnt == nfiles) {
> +		tst_res(TPASS,
> +				"found all %d that were created",
> +				nfiles);
> +	} else {
> +		tst_res(TFAIL,
> +				"found %s files than were created, created: %d, found: %d",
> +				cnt > nfiles ? "more" : "less", nfiles, cnt);
> +	}

Why the newline after TPASS, TFAIL, ? We indent the format string as if
it continued after the TFAIL/TPASS anyways.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
