Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D79AC433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 19:26:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 880E13C8143
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 20:26:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742753C1DB8
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 20:26:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 95E891A00A5F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 20:26:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48671210EC;
 Thu,  9 Dec 2021 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639077985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/ecaULBXLZ0ZLMfCPmrEqZl+GyVGJY9FUkegYXQwXM=;
 b=awIaMc+IUJnRtHOBMG3rVxSiGt92/jPM6KpiRJTGUre7Pxb8GwywzK4g7T+pI3zsB+pq7n
 XWRuIPLic9jYHDlrT/A2n8aGUig2kY5IGmi4zcYTNLiFFgfJ7JTYjHKuXXJjaUg071lYlE
 jg2XCyq1vF+XvAf77uscx+evbaMi+dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639077985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/ecaULBXLZ0ZLMfCPmrEqZl+GyVGJY9FUkegYXQwXM=;
 b=b+ruhNZxm8iwIdWLKE7+hSJcq+gtWJuDBzqH6IKl/4RJo2vFCeut76pfdNHFrtLcJjgI1P
 /7Lo6bBkz6Yes/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D99413D79;
 Thu,  9 Dec 2021 19:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jFCoCmFYsmFZKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Dec 2021 19:26:25 +0000
Date: Thu, 9 Dec 2021 20:27:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YbJYq5B5ysfbFdwB@yuki>
References: <20211209105359.17251-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209105359.17251-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactoring dio_sparse.c using LTP API
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
This version is nearly perfect.
> -		case 'a':
> -			alignment = strtol(optarg, &endp, 0);
> -			alignment = scale_by_kmg(alignment, *endp);
> -			break;

The only missing piece is that it does not support the -a option anymore
and if you grep the runtest files:

cd ltp/runtest; git grep dio_sparse

You will see that there are several entries that actually pass the
alignment to the test. I do not think that having the memory aligned
more than the minimal requirement makes any difference, but we still
have to fix the entries if we decide to get rid of that parameter.


Also the minimal aligment requirement is not page size but the result
from ioctl(2) BLKSSZGET which is the blocksize for the underlying
device and while the page size is likely multiple of that we should
really use the ioctl(), we already use that in the aiocp.c test.

> -		case 'w':
> -			writesize = strtol(optarg, &endp, 0);
> -			writesize = scale_by_kmg(writesize, *endp);
> -			break;
> -		case 's':
> -			filesize = strtol(optarg, &endp, 0);
> -			filesize = scale_by_kmg(filesize, *endp);
> -			break;
> -		case 'o':
> -			offset = strtol(optarg, &endp, 0);
> -			offset = scale_by_kmg(offset, *endp);
> -			break;
> -		case 'n':
> -			num_children = atoi(optarg);
> -			if (num_children > NUM_CHILDREN) {
> -				fprintf(stderr,
> -					"number of children limited to %d\n",
> -					NUM_CHILDREN);
> -				num_children = NUM_CHILDREN;
> -			}
> -			break;
> -		case '?':
> -			usage();
> -			break;
> -		}
> -	}
> -
> -	setup();
> -	tst_resm(TINFO, "Dirtying free blocks");
> -	dirty_freeblocks(filesize);
> -
> -	fd = SAFE_OPEN(cleanup, filename,
> -		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
> -	SAFE_FTRUNCATE(cleanup, fd, filesize);
> -
> -	tst_resm(TINFO, "Starting I/O tests");
> -	signal(SIGTERM, SIG_DFL);
> -	for (i = 0; i < num_children; i++) {
> -		switch (pid[i] = fork()) {
> -		case 0:
> -			SAFE_CLOSE(NULL, fd);
> -			read_sparse(filename, filesize);
> -			break;
> -		case -1:
> -			while (i-- > 0)
> -				kill(pid[i], SIGTERM);
> -
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
> -		default:
> -			continue;
> -		}
> -	}
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	ret = dio_sparse(fd, alignment, writesize, filesize, offset);
> -
> -	tst_resm(TINFO, "Killing childrens(s)");
>  
> -	for (i = 0; i < num_children; i++)
> -		kill(pid[i], SIGTERM);
> +	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	SAFE_FTRUNCATE(fd, filesize);
>  
> -	for (i = 0; i < num_children; i++) {
> -		int status;
> -		pid_t p;
> +	*run_child = 1;
>  
> -		p = waitpid(pid[i], &status, 0);
> -		if (p < 0) {
> -			tst_resm(TBROK | TERRNO, "waitpid()");
> -		} else {
> -			if (WIFEXITED(status) && WEXITSTATUS(status) == 10)
> -				children_errors++;
> +	for (i = 0; i < numchildren; i++) {
> +		if (!SAFE_FORK()) {
> +			io_read(filename, filesize, run_child);
> +			return;
>  		}
>  	}
>  
> -	if (children_errors)
> -		tst_resm(TFAIL, "%i children(s) exited abnormally",
> -			 children_errors);
> +	dio_sparse(fd, filesize, writesize, offset);
>  
> -	if (!children_errors && !ret)
> -		tst_resm(TPASS, "Test passed");
> +	if (SAFE_WAITPID(-1, &status, WNOHANG))
> +		tst_res(TFAIL, "Non zero bytes read");
> +	else
> +		tst_res(TPASS, "All bytes read were zeroed");
>  
> -	cleanup();
> -	tst_exit();
> +	*run_child = 0;
>  }
>  
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	tst_tmpdir();
> -}
> -
> -static void cleanup(void)
> -{
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close file");
> -
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.options = options,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
