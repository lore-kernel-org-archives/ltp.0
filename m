Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F8C0015E
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 10:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7823CBBD0
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 12:31:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 407B23C02F7
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 12:31:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 769941400FB8
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 12:31:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97E241F460;
 Tue, 25 Jul 2023 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690281102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbXdxLODV0r6wwGUrszRAdgeuoJThJDntmj1JvUVvi8=;
 b=wuiL87xk0Bww4j/XV9jtG0YRcrt8/U8ihR8QcaVIxv6++zvqG1YW/vZgb1ZyzGEX3wCvSs
 e1eh23Vtyr58dCdvhvl0fBhMwtmSJL1Z/kx4H276mBarl56SprBmlS3sIX1daJylQgryIk
 FgRsblutLU1WNJ2Nkduhojbsa16MATI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690281102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbXdxLODV0r6wwGUrszRAdgeuoJThJDntmj1JvUVvi8=;
 b=TvXrFiPrIBZV9sTQ6sJROMeF2+4avX9/gE02pseNjwGSEXehuc+GvMprhxwDOT6z9VOEK/
 s74gj12EaHWNJBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 814A513342;
 Tue, 25 Jul 2023 10:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c4ygHY6kv2SHfQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jul 2023 10:31:42 +0000
Date: Tue, 25 Jul 2023 12:32:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZL-ky99di6T2Udk2@yuki>
References: <20230722134949.15684-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230722134949.15684-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe07: Rewrite the test using new LTP
 API
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
> +	while ((ent = SAFE_READDIR(dir))) {
> +		if (!strcmp(ent->d_name, ".") ||
> +			!strcmp(ent->d_name, ".."))
> +			continue;
> +		fd = atoi(ent->d_name);

What about the if (fd == dir_fd) continue; why did you drop that part
from here?

> +		opened_fds = SAFE_REALLOC(opened_fds, (num_opened_fds + 1) * sizeof(int));

It's more usuall to double array size if we go out of space since
incresing the size by one element is` slow in case of realloc(). I guess
that it does not matter us much here, but I would do something as:

	int arr_size = 0;
	int arr_used = 0;
	int *array = NULL;

	if (arr_used >= arr_size) {
		arr_size = MAX(1, arr_size * 2);
		array = realloc(array, arr_size * sizeof(int));
	}

	array[arr_used++] = foo;

> +		opened_fds[num_opened_fds++] = fd;
>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
>  
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	int max_fds;
> +
> +	max_fds = getdtablesize();
> +	tst_res(TINFO, "getdtablesize() = %d", max_fds);
> +	pipe_fds = SAFE_MALLOC(max_fds * sizeof(int));
>  
>  	record_open_fds();
> +	tst_res(TINFO, "open fds before pipe() calls: %d", num_opened_fds);
> +
> +	exp_num_pipe_fds = max_fds - num_opened_fds;
> +	exp_num_pipe_fds = (exp_num_pipe_fds % 2) ?
> +						(exp_num_pipe_fds - 1) : exp_num_pipe_fds;

The previous code that compared the number of pipes was IMHO easier to
read, i.e.

	exp_num_pipes = (max_fds - num_opened_fds)/2;

Then you can use:

	2 * exp_num_pipes as the number of expected fds

> +	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipe_fds);
>  }
>  
> -static void record_open_fds(void)
> +static void run(void)
>  {
> -	DIR *dir = opendir("/proc/self/fd");
> -	int dir_fd, fd;
> -	struct dirent *file;
> +	int fds[2];
>  
> -	if (dir == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "opendir()");
> -
> -	dir_fd = dirfd(dir);
> -
> -	if (dir_fd == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "dirfd()");
> -
> -	errno = 0;
> -
> -	while ((file = readdir(dir))) {
> -		if (!strcmp(file->d_name, ".") || !strcmp(file->d_name, ".."))
> -			continue;
> -
> -		fd = atoi(file->d_name);
> -
> -		if (fd == dir_fd)
> -			continue;
> -
> -		if (rec_fds_max >= (int)ARRAY_SIZE(rec_fds)) {
> -			tst_brkm(TBROK, cleanup,
> -			         "Too much file descriptors open");
> +	do {
> +		TEST(pipe(fds));
> +		if (TST_RET != -1) {
> +			pipe_fds[num_pipe_fds++] = fds[0];
> +			pipe_fds[num_pipe_fds++] = fds[1];
>  		}
> +	} while (TST_RET != -1);
>  
> -		rec_fds[rec_fds_max++] = fd;
> -	}
> -
> -	if (errno)
> -		tst_brkm(TBROK | TERRNO, cleanup, "readdir()");
> +	TST_EXP_EQ_LI(errno, EMFILE);
> +	TST_EXP_EQ_LI(exp_num_pipe_fds, num_pipe_fds);
>  
> -	closedir(dir);
> +	for (int i = 0; i < num_pipe_fds; i++)

I suppose that this is fine since we now compile with -std=gnu99

> +		SAFE_CLOSE(pipe_fds[i]);
>  
> -	tst_resm(TINFO, "Found %u files open", rec_fds_max);
> +	num_pipe_fds = 0;
>  }
>  
> -static int not_recorded(int fd)
> +static void cleanup(void)
>  {
> -	int i;
> +	if (opened_fds)
> +		free(opened_fds);
>  
> -	for (i = 0; i < rec_fds_max; i++)
> -		if (fd == rec_fds[i])
> -			return 0;
> +	if (pipe_fds)
> +		free(pipe_fds);
>  
> -	return 1;
> -}
> -
> -static void close_test_fds(int max_fd)
> -{
> -	int i;
> -
> -	for (i = 0; i <= max_fd; i++) {
> -		if (not_recorded(i)) {
> -			if (close(i)) {
> -				if (errno == EBADF)
> -					continue;
> -				tst_resm(TWARN | TERRNO, "close(%i)", i);
> -			}
> -		}
> -	}
> +	for (int i = 0; i < num_pipe_fds; i++)
> +		if (pipe_fds[i])
                      ^
		      This should be pipe_fds[i] > 0

However this branch is never triggered as long as the loop that closes
all pipe_fds in run succeeds. I'm not sure that if we fail to close a
pipe it makes sense to contine closing the rest. Since pipes are only
backed by RAM the possible failures from close() would mean that
something horrible happend to the kernel, possibly RAM corruption or
something along the lines.

> +			SAFE_CLOSE(pipe_fds[i]);
>  }
>  
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run
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
