Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54577C6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 09:07:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2E413CC1C5
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 11:07:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 970A53C9762
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:07:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 680401400FB6
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:07:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77A711F750;
 Tue, 29 Aug 2023 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693300057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y4X7W+0FJmxngFnf2z8pZ03avzhGK9dZUq9FP24JfQ=;
 b=K4eII02sJp0ZUVEA9vmmYn0enRfr4xpkOzakNpsZ4wYVsEBnfmKCYHUS72JmcUXRNodegR
 ugCiu3xKLKQ4ET0pKzsjWai6GLkfHqMqp7UYEBnpG6LcrvmADgQY1QCWeOr8TiB8iOf3VW
 WaXNLF5UVkQaqSEM9i0yj/uuZDf/lps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693300057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y4X7W+0FJmxngFnf2z8pZ03avzhGK9dZUq9FP24JfQ=;
 b=gtwdBsSPtHRHsOFIhC5gbsBjSU5JvECnIbcQzTaNyanCTlGBnIj9wccotOTTdYl4ntyi4M
 jQEOnJKuoXsR+eBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CA6D13301;
 Tue, 29 Aug 2023 09:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4dFODli17WTHUAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Aug 2023 09:07:36 +0000
Date: Tue, 29 Aug 2023 11:07:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZO21RSSoRyeQmXBZ@rei>
References: <20230818112023.18159-1-akumar@suse.de>
 <20230818112023.18159-3-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230818112023.18159-3-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] syscalls/mmap02: Rewrite the test using new
 LTP API
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
>  static void setup(void)
>  {
> -	char *tst_buff;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	char *buf;
>  
>  	page_sz = getpagesize();
> +	buf = SAFE_CALLOC(page_sz, sizeof(char));
                                   ^
				   this is 1 by definition

So we can do just SAFE_MALLOC(page_sz);

> +	memset(buf, 'A', page_sz);
>  
> -	/* Allocate space for the test buffer */
> -	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
> -	}
> -
> -	/* Fill the test buffer with the known data */
> -	memset(tst_buff, 'A', page_sz);
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
> +	free(buf);
> +	SAFE_FCHMOD(fd, 0444);
> +	SAFE_CLOSE(fd);
>  
> -	tst_tmpdir();
> -
> -	/* Creat a temporary file used for mapping */
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		free(tst_buff);
> -		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
> -			 TEMPFILE);
> -	}
> -
> -	/* Write test buffer contents into temporary file */
> -	if (write(fildes, tst_buff, page_sz) < (int)page_sz) {
> -		free(tst_buff);
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "writing to %s failed", TEMPFILE);
> -	}
> -
> -	/* Free the memory allocated for test buffer */
> -	free(tst_buff);
> -
> -	/* Change Mode permissions on Temporary file */
> -	if (fchmod(fildes, 0444) < 0) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "fchmod(%s, 0444) failed",
> -			 TEMPFILE);
> -	}
> +	fd = SAFE_OPEN(TEMPFILE, O_RDONLY);
> +	dummy = SAFE_CALLOC(page_sz, sizeof(char));

Why do we allocate second buffer? Cant we just keep the buf? Bonus point
is that the buf was alread filled with data we expect in the file, so we
don't have to read them with read() in the run() function.

> +}
>  
> -	/* Close the temporary file */
> -	if (close(fildes) < 0) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "closing %s failed",
> -			 TEMPFILE);
> +static void run(void)
> +{
> +	addr = mmap(0, page_sz, PROT_READ, MAP_FILE | MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
> +		return;
>  	}
>  
> -	/* Open the temporary file again, - Readonly mode */
> -	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
> -		tst_brkm(TFAIL, cleanup, "reopening %s readonly failed",
> -			 TEMPFILE);
> -	}
> +	SAFE_READ(1, fd, dummy, page_sz);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>  
> -	/* Allocate and initialize dummy string of system page size bytes */
> -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> -	}
> +	if (memcmp(dummy, addr, page_sz) == 0)
> +		tst_res(TPASS, "mmap() functionality successful");
> +	else
> +		tst_res(TFAIL, "mapped memory area contains invalid data");
>  
> +	SAFE_MUNMAP(addr, page_sz);
>  }
>  
>  static void cleanup(void)
>  {
> -	close(fildes);
> -	free(dummy);
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	if (dummy)
> +		free(dummy);

free(NULL) is no-op so there is no need for the if ().

>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
