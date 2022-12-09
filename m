Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DA2C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 12:37:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF193CC003
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 13:37:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08F263C62EC
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 13:37:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 696262009A4
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 13:37:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77EA122C5B;
 Fri,  9 Dec 2022 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670589464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/eBjSPWSZPaqQ8jk311b31HcBtn8brlwEuQT7VHVEDQ=;
 b=kNEe3ESrKFswJRDAJwAbtP6WU+m4zUQbD4TAeOGDTvWeytVuBF7dJKt3R9SFc/NEGbGznV
 lySqAyt3Arw9W9bkReTcd1bvr85Qxw3ySuNktVdLWouYti+TSqmUGUZDHjOksGZomynj2P
 pHGGqFRwObwbp96koKZGK13y8x7qsVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670589464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/eBjSPWSZPaqQ8jk311b31HcBtn8brlwEuQT7VHVEDQ=;
 b=PFnnqBQEY1riqmDwIkzYM237jOO7VSKpALPNDd4rXPwLsm6W8o5TDQkcvTaZa3wq/r1wIY
 H25tZhDoCw753tBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ABE3138E0;
 Fri,  9 Dec 2022 12:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PhP/Exgsk2PMUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Dec 2022 12:37:44 +0000
Date: Fri, 9 Dec 2022 13:37:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y5MsDM0RlyfdA058@rei>
References: <20221130135451.28399-1-andrea.cervesato@suse.com>
 <20221130135451.28399-2-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130135451.28399-2-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 1/2] Rewrite aio-stress test using LTP API
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
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,

One more thing, this needs runtime treatement since if you pass large
enough file size the test will timeout.

First of all we should add large enough max runtime as we do for the
rest of the aio tests, i.e. .max_runtime = 1800,

And secondly, I would do that in a subsequent patchset, we should add
check for running out of runtime into the worker loop.

> +	.options = (struct tst_option[]){
> +		{ "a:", &str_iterations, "Total number of ayncs I/O the program will run (default 500)" },
> +		{ "b:", &str_max_io_submit, "Max number of iocbs to give io_submit at once" },
> +		{ "c:", &str_num_contexts, "Number of io contexts per file" },
> +		{ "d:", &str_depth, "Number of pending aio requests for each file (default 64)" },
> +		{ "e:", &str_io_iter, "Number of I/O per file sent before switching to the next file (default 8)" },
> +		{ "f:", &str_num_files, "Number of files to generate" },
> +		{ "g:", &str_context_offset, "Offset between contexts (default 2M)" },
> +		{ "l", &latency_stats, "Print io_submit latencies after each stage" },
> +		{ "L", &completion_latency_stats, "Print io completion latencies after each stage" },
> +		{ "m", &str_use_shm, "SHM use ipc shared memory for io buffers instead of malloc" },
> +		{ "n", &no_fsync_stages, "No fsyncs between write stage and read stage" },
> +		{ "o:", &str_stages, "Add an operation to the list: write=0, read=1, random write=2, random read=3" },
> +		{ "O", &str_o_flag, "Use O_DIRECT" },
> +		{ "r:", &str_rec_len, "Record size in KB used for each io (default 64K)" },
> +		{ "s:", &str_file_size, "Size in MB of the test file(s) (default 1024M)" },
> +		{ "t:", &str_num_threads, "Number of threads to run" },
> +		{ "u", &unlink_files, "Unlink files after completion" },
> +		{ "v", &verify, "Verification of bytes written" },
> +		{ "x", &no_stonewall, "Turn off thread stonewalling" },
> +		{},
> +	},
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
