Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41AEC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 12:36:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98F2B3C945E
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 14:36:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB0883C8CC0
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 14:36:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13EE1600908
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 14:36:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3175821ABE;
 Tue, 21 Jun 2022 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655814996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iT/7UAXjPv34HwmrZTQRclM6anMz6/gjkcEA7TUjUhU=;
 b=cwy/EzaPmpKgPCOZHvWdKTy+F0k+gv2ElHvT6PJmDLyDPcj9rr2r24/qiiA81YVwupH6dy
 xUmDPqkOX54Ymfp6sFOeMcHaqYmRU5qS/uYejc5oxtw4qzNuPoQxb/la9jNjzKMrWIIWEI
 XXmWqVgWMNbGh4erFXVYtzfm5w66LEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655814996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iT/7UAXjPv34HwmrZTQRclM6anMz6/gjkcEA7TUjUhU=;
 b=eyVxfPbA3I9C2kJ0A7FffAwwJnT4kYcebPodFHj4UTupMBCmCqpMZGn6q4Q14uC8K9diHt
 RGIwwogI7vH5VdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CEF213638;
 Tue, 21 Jun 2022 12:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j3HSBVS7sWIjEAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 12:36:36 +0000
Date: Tue, 21 Jun 2022 14:38:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YrG705WokoVxD4eM@yuki>
References: <20220617172025.23975-1-akumar@suse.de>
 <20220617172025.23975-5-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220617172025.23975-5-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] Rewrite utime04.c using new LTP API
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
> +#define FILE_MODE	0444
> +#define NEW_MODF_TIME	10000
> +#define NEW_ACCESS_TIME	20000
>  
> -struct utimbuf times;		/* struct. buffer for utime() */
> +static struct utimbuf times;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	struct stat stat_buf;	/* struct buffer to hold file info. */
> -	int lc;
> -	time_t modf_time, access_time;
> -	/* file modification/access time */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Invoke utime(2) to set TEMP_FILE access and
> -		 * modification times to that specified by
> -		 * times argument.
> -		 */
> -		TEST(utime(TEMP_FILE, &times));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
> -		} else {
> -			/*
> -			 * Get the modification and access times of
> -			 * temporary file using stat(2).
> -			 */
> -			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
> -			modf_time = stat_buf.st_mtime;
> -			access_time = stat_buf.st_atime;
> -
> -			/* Now do the actual verification */
> -			if ((modf_time != NEW_TIME) ||
> -			    (access_time != NEW_TIME)) {
> -				tst_resm(TFAIL, "%s access and "
> -					 "modification times not set",
> -					 TEMP_FILE);
> -			} else {
> -				tst_resm(TPASS, "Functionality of "
> -					 "utime(%s, &times) successful",
> -					 TEMP_FILE);
> -			}
> -		}
> -		tst_count++;	/* incr TEST_LOOP counter */
> -	}
> +	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
>  
> -	cleanup();
> -	tst_exit();
> +	times.modtime = NEW_MODF_TIME;
> +	times.actime = NEW_ACCESS_TIME;

The times structure can be initialized inline as:

static struct utimbuf times = {
	.modtime = NEW_MOD_TIME,
	.actime = NEW_ACC_TIME,
};

>  }
>  
> -/*
> - * void
> - * setup() - performs all ONE TIME setup for this test.
> - *  Create a temporary directory and change directory to it.
> - *  Create a test file under temporary directory and close it
> - */
> -void setup(void)
> +static void run(void)
>  {
> -	int fildes;		/* file handle for temp file */
> -
> -	tst_require_root();
> +	struct stat stat_buf;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	TST_EXP_PASS(utime(TEMP_FILE, &times), "utime(%s, &times)", TEMP_FILE);
>  
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	/* Creat a temporary file under above directory */
> -	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
> +	if (!TST_PASS) {
> +		tst_res(TFAIL | TTERRNO, "utime(%s, &times) failed", TEMP_FILE);

The PASS/FAIL message is already printed by the TST_EXP_PASS() macro,
all that you need to to do here is return.

> +		return;
> +	}
>  
> -	/* Close the temporary file created */
> -	SAFE_CLOSE(cleanup, fildes);
> +	SAFE_STAT(TEMP_FILE, &stat_buf);
>  
> -	/* Initialize the modification and access time in the times arg */
> -	times.actime = NEW_TIME;
> -	times.modtime = NEW_TIME;
> +	if (stat_buf.st_mtime != NEW_MODF_TIME)
> +		tst_res(TFAIL, "utime() did not set expected mtime");
>  
> +	if (stat_buf.st_atime != NEW_ACCESS_TIME)
> +		tst_res(TFAIL, "utime() did not set expected atime");

We do have macros for these kind of checks as well, please use them as:

	TST_EXP_EQ_LI(stat_buf.st_atime, NEW_ACC_TIME);

>  }
>  
> -/*
> - * void
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *  Remove the test directory and testfile created in the setup.
> - */
> -void cleanup(void)
> -{
> -
> -	tst_rmdir();
> -
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.36.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
