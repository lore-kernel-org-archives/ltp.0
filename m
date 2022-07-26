Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A46C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:55:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72BB43CA00A
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:55:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1813C9427
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:55:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D2FC1000643
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:55:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FD3734E49;
 Tue, 26 Jul 2022 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658836517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxkwAw1gclasYY9egdRVBHMexlQd+gnS4nEovb4t/8g=;
 b=vQFw3NAbgeG5RjQj9nKV0RrVnur+9L8gZYGmKJnW//eQ5hel3wNf/msPjNjZBZcwXDP55t
 iDYGbRZTXooi4PH9JFwKZpntVr8lP9PVF3cdv4d+DTU2BPI+nxByFnQfz+cMIabiKpbnHo
 MkJeGB/Oc6SuGgeiwU4Yw96Z/HmJbmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658836517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxkwAw1gclasYY9egdRVBHMexlQd+gnS4nEovb4t/8g=;
 b=EkVgIl+sXQRCIE4wl1fYVKodPb38UksgtHjrN33yS0qfZoZJstNtTjEGU5Ei5Dm/GRwtUy
 5PSd75GXduQvrrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FCF413322;
 Tue, 26 Jul 2022 11:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7LDoGCXW32I3bwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 11:55:17 +0000
Date: Tue, 26 Jul 2022 13:55:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <Yt/WI0ABJpMfXLjk@pevik>
References: <1658386911-890-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1658386911-890-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] float: convert to new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hongchen,

thank you for your effort, but much more needs to be done.

Code in whole project (all sources in testcases/misc/math/float) is very old and
IMHO weird. I still wonder why testing float / math functions requires creating
files, using pthread (in thread_code.c), ... It'd be worth to have look whether
current approach is really useful before spending time to rewrite it.

Some notes to your rewrite. main.c and thread_code.c should be turned into
header file (e.g. float.h) with functions being static inline. Because
including C files is no-go.

>  testcases/misc/math/float/main.c | 446 +++++++++------------------------------
...
> -const int nb_func = NB_FUNC;
> +static char *Dopt, *lopt, *nopt, *vopt;
> +static struct tst_option opt[] = {
> +	{"D:", &Dopt,   "DATA directory's absolute path"},
IMHO this should not be needed, everything should be in test temporary
directory, there is no need to put it elsewhere.
> +	{"l:", &lopt, "set number of loops per function"},
> +	{"n:", &nopt, "set number of threads per function"},
> +	{"v", &vopt, "debug level"},
I'd get rid of the debugging (important things should be always printed).

> +	{}
> +};

>  int generate(char *datadir, char *bin_path)
>  {
>  	char *cmdline;
>  	char *fmt = "cd %s; %s/%s %s";

> -	cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) + strlen(GENERATOR) + strlen(fmt));
> +	cmdline = malloc(2 * strlen(bin_path) + strlen(datadir) +
> +				strlen(GENERATOR) + strlen(fmt));
>  	if (cmdline == NULL)
>  		return (1);
There is SAFE_MALLOC(), no need to check for NULL.

>  	sprintf(cmdline, fmt, datadir, bin_path, GENERATOR, bin_path);
> @@ -93,345 +55,137 @@ int generate(char *datadir, char *bin_path)
>  	return (0);

Also code style suggests it's very old. brackets around integer in return is
quite strange (i.e. "return (0);").
>  }


>  	ltproot = getenv("LTPROOT");
>  	if (ltproot == NULL || strlen(ltproot) == 0) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brk(TBROK,
>  			 "You must set $LTPROOT before executing this test");

generate() function which runs binary should be replaced with tst_cmd().
IMHO we don't need to check for $LTPROOT, because we expect PATH to be set
correctly.

>  	}
>  	bin_path = malloc(strlen(ltproot) + 16);
>  	if (bin_path == NULL) {
SAFE_MALLOC() (in many places)
> -		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
> +		tst_brk(TBROK, "malloc failed");
>  	}
...

> +void run(unsigned int n)
> +{
> +	void *exit_value;
> +	pthread_attr_t newattr;
> +	size_t stacksize = 2093056;
I'm not sure if this is portable for all archs and I'd use #define at the top.

...
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.options = opt,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.tcnt = NB_FUNC,
> +};

struct tst_test test should be defined in float*.c tests, not in this
common file included by tests.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
