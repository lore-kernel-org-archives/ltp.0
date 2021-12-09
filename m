Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD98C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 21:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C203C7FC9
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 22:38:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A49613C1D8F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:38:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB894140099B
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:38:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3F9B1F37F;
 Thu,  9 Dec 2021 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639085898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXFRNopEsbqf9pSJKQem4L4qkc0QQdXD4bSfPSvrhRM=;
 b=BzwFlODDGvQE3ElHBhlF/qp/ZVNfRACbGNEpnZzdTm6oGyqlxLdfaFlIr2q8IgYRCupaFq
 IxQjfdyf+pXN/5IwHX7nbNBBAEKxdDtH2pJmkKp4MzKcrNP9OQDiRkWMBJSd3Ajh7OcH8Y
 nB9ocdJ+cH5qnE2kUkLXaRE+XzgNzWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639085898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXFRNopEsbqf9pSJKQem4L4qkc0QQdXD4bSfPSvrhRM=;
 b=n6bsEFn2Eu7PB1SBriNMMejEzZH9nYwqHLtKojCy0dsXwN1SRIpcvIkyLZVAVdkobMvZSP
 fHdxNvDLJQIjekCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8243D13D9F;
 Thu,  9 Dec 2021 21:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id frHqHUp3smEYVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Dec 2021 21:38:18 +0000
Date: Thu, 9 Dec 2021 22:38:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbJ3SKsLu7iNoqZc@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
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

Hi Xu,

> Also add removing zram module step in setup, so we can avoid the situation that
> zram module is being used by zram-generator.

...
> +++ b/testcases/kernel/device-drivers/zram/zram03.c
...
> +static const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};

Again, here should be lsmod used.

Except this LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>


>  static void set_disksize(void)
>  {
> -	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
> +	tst_res(TINFO, "create a zram device with %ld bytes in size.", SIZE);
> +	SAFE_FILE_PRINTF(PATH_ZRAM "/disksize", "%ld", SIZE);
>  }

>  static void write_device(void)
> @@ -92,17 +45,16 @@ static void write_device(void)
>  	int fd;
>  	char *s;

> -	tst_resm(TINFO, "map this zram device into memory.");
> -	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
> -	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
> -		      MAP_SHARED, fd, 0);
> +	tst_res(TINFO, "map this zram device into memory.");
> +	fd = SAFE_OPEN(DEVICE, O_RDWR);
> +	s = SAFE_MMAP(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

> -	tst_resm(TINFO, "write all the memory.");
> +	tst_res(TINFO, "write all the memory.");
very nit: while at it, could you please remove unnecessary dot at the end?

...

>  static void reset(void)
>  {
> -	tst_resm(TINFO, "reset it.");
> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/reset", "1");
> -}
...
> +	tst_res(TINFO, "%s...", __func__);
> +	SAFE_FILE_PRINTF(PATH_ZRAM "/reset", "1");
>  }

checkpatch.pl complains:

$ make check-zram03
zram03.c:93: WARNING: Unnecessary ftrace-like logging - prefer using ftrace
=> nit, but checkpatch.pl is correct, previous info was better than tracing
function name. How about keep info instead of function name, e.g.:
tst_res(TINFO, "reset zram");

zram03.c:94: WARNING: Prefer using '"%s...", __func__' to using 'reset', this function's name, in a string
false positive (not sure if we should bother with renaming function to keep it quiet).

...
> +static void setup(void)
> +{
> +	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
> +
> +	if (tst_cmd(cmd_rmmod, NULL, NULL, TST_CMD_PASS_RETVAL)) {
> +		if (errno == EBUSY)
> +			tst_brk(TCONF, "zram module may being used!");
> +	}
nit: I'd add space here for a readability (it's on more places).
> +	if (errno == ENOENT)
> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
> +
> +	modprobe = 1;
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
