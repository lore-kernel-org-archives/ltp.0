Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A35C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 09:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA2E3C21EA
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 10:50:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5133C21EA
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 10:50:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F02F601C77
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 10:50:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 783DF212C1;
 Thu, 16 Dec 2021 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639648234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVK4UNee8x4XD7KQh/J7aGEp18PcdZOm+Y2GPxQxWuk=;
 b=JXSXrtzwaiumhtAZ5DKkRYx8xx8NLr1Zi2hjWNbQy4quNqxxJaWrk4EbU+t4IamDzbNe5X
 zLR+wB5U+LwXUI3GL+OA1qJ5LdAIyxEL+1fvUcGZcal5K9+PkTRFXsq1+Ys9wf3rsv3T+P
 DVxgn/KPSjERCPqlakISLKUkNvJD+jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639648234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVK4UNee8x4XD7KQh/J7aGEp18PcdZOm+Y2GPxQxWuk=;
 b=CIOXeMlcKbK2NQt7ER65cGiFEl2mS0v8KeV0AN6/Mq8sTkXNorcX/X52STmYHqM36D8hg2
 VXy/dqx3vxibhnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 634FD13C32;
 Thu, 16 Dec 2021 09:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JOB5FuoLu2HfDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 16 Dec 2021 09:50:34 +0000
Message-ID: <e396e4c3-605f-2fa6-094a-59194bbc0c3c@suse.cz>
Date: Thu, 16 Dec 2021 10:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <20211216034125.255907-1-liwang@redhat.com>
 <20211216034125.255907-2-liwang@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20211216034125.255907-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ltp: enable OOM protection for main and test
 harness process
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 16. 12. 21 4:41, Li Wang wrote:
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index ce2b8239d..f3ae48240 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1441,11 +1441,15 @@ static int fork_testrun(void)
>  
>  	SAFE_SIGNAL(SIGINT, sigint_handler);
>  
> +	tst_enable_oom_protection(getppid());

this is exactly what you should *NOT* do because then the OOM protection
will also be inherited by all non-LTP processes executed by the same
shell (or whatever the parent process is).

> +	tst_enable_oom_protection(getpid());
> +
>  	test_pid = fork();
>  	if (test_pid < 0)
>  		tst_brk(TBROK | TERRNO, "fork()");
>  
>  	if (!test_pid) {
> +		tst_cancel_oom_protection(getpid());
>  		SAFE_SIGNAL(SIGALRM, SIG_DFL);
>  		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
>  		SAFE_SIGNAL(SIGINT, SIG_DFL);
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
