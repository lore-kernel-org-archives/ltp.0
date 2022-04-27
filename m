Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921BDC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:37:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315283CA5AF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 16:37:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD633C8977
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:37:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BEAF10006D2
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:37:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0E891F74E;
 Wed, 27 Apr 2022 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651070263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8J7VmIvZeqYemfNBcAtO8MLbtEg9CCl2HVIK4866+tg=;
 b=QqQVmSSt0sqjYhZb/0JFjDKfVmiMyEmG18JTzG04c+/Y8Y8MOF1nBTY72fHxaeefcNF8bF
 P/2fY95G0uFkw/a2fglkwxvaPenQtWFVMs9iDRpuMF6AXU5TpYaMbrVmBWTT/bLsYBAYN1
 zLTn6KkXsQPdNbhSAWCsT9ZN4HEgMK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651070263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8J7VmIvZeqYemfNBcAtO8MLbtEg9CCl2HVIK4866+tg=;
 b=gd2pR2A1lGNzevYka8Xcxjwcsy+7MWTvc4Bw+qW42arBz0D3ivW/BeicSBzzLVKMoQVRIK
 o1cv5P3MfZo4u5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A45D313A39;
 Wed, 27 Apr 2022 14:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mduMJzdVaWJsewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Apr 2022 14:37:43 +0000
Date: Wed, 27 Apr 2022 16:39:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YmlVv3QSmAmIIwA/@yuki>
References: <1651034524-18799-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1651034524-18799-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fcntl05: Convert into new api
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
> +static void verify_fcntl(void)
>  {
> -	int lc;
> +	/* F_GETLK will change flock.l_type to F_UNLCK, so need to reset */
> +	flocks.l_type = F_RDLCK;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		flocks.l_type = F_RDLCK;
> -		TEST(fcntl(fd, F_GETLK, &flocks));
> -
> -		if (TEST_RETURN == -1)
> -			tst_resm(TFAIL | TTERRNO, "fcntl failed");
> -		else {
> -			tst_resm(TPASS, "fcntl returned %ld",
> -				 TEST_RETURN);
> -		}
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_PASS(fcntl(fd, F_GETLK, &flocks), "fcntl(%d, F_GETLK, &flocks)", fd);

Can we also check that the l_type was actually set and that the rest of
the fields have not changed?

Should be as easy as:

        TST_EXP_EQ_LI(flocks.l_type, F_UNLCK);
        TST_EXP_EQ_LI(flocks.l_whence, SEEK_CUR);
        TST_EXP_EQ_LI(flocks.l_start, 0);
        ...


>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> +	char fname[255];
> +	int pid;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> +	pid = getpid();
>  
> -	sprintf(fname, "tfile_%d", getpid());
> -	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
> +	sprintf(fname, "testfile_%d", pid);
> +	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);

The test creates unique temporary directory so tehre is no need to
include the pid in the filename anymore...

The rest looks good. With the two changes applied:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
