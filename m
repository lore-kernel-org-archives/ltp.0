Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD8BC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 14:50:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 541433C909A
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 15:50:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66C223C71AA
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:49:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DFFCB602390
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:49:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31EC21F394;
 Fri, 17 Dec 2021 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639752590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqKu7mB5BqQrPue+Ny60Wn+uHo+/rdkJIgn7H96wLX8=;
 b=H1uUIl4Z1MrJEWDmvPjhk/b4eFwCO/MgP+gI5ufmP6QbJF2QHD6ZaEPKOSH98KaAfjZRVF
 wCnTr3QtXYblBieAMsq5K4A+3JZ9aEl2jG87dwkEvuixgDpce9K1nOZAd5ZlFjL5aowg3w
 Ax6TvXEnAd/71lQODH3MvMzPa3NQ/+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639752590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqKu7mB5BqQrPue+Ny60Wn+uHo+/rdkJIgn7H96wLX8=;
 b=oEljM7KPD3ODeQqa8BSlGkIDycnGifbk5NoG50rHywV4jkRZUz5QMjVD1QFJHuba/Q4ual
 omyeFnTN58iBzhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DAAD13E1C;
 Fri, 17 Dec 2021 14:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lE4kBo6jvGGgLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Dec 2021 14:49:50 +0000
Date: Fri, 17 Dec 2021 15:51:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybyj5nEb7k+5dtmb@yuki>
References: <20211217113751.359613-1-liwang@redhat.com>
 <20211217113751.359613-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217113751.359613-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] oom: enable OOM protection for mem lib
 process
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
> Just simply invoke oom protection on mem library to make
> it can collect full state of children.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/mem/lib/mem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index ac890491c..566e29055 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -129,8 +129,11 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
>  	pid_t pid;
>  	int status, threads;
>  
> +	tst_enable_oom_protection(getpid());
> +
>  	switch (pid = SAFE_FORK()) {
>  	case 0:
> +		tst_cancel_oom_protection(getpid());
>  		threads = MAX(1, tst_ncpus() - 1);
>  		child_alloc(testcase, lite, threads);
>  	default:

Looking at the code we have, we always pass getpid(). We may as well
change the library to use /proc/self/oom_score_adj if 0 is passed
instead of the pid.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
