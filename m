Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD9C25B0E
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 15:05:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34C2D3C9739
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 17:05:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 845653C0134
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 17:05:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4510020004D
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 17:05:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7923734270;
 Mon, 15 Aug 2022 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660575946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xoj6LSjO5fzZR+xFPkcQdHdSiBKsJYLByt78qCwz6Ak=;
 b=ihEJnh2MHYjrkyi7dt7nnaPr5tLojboqjIslQVCm05loCFdSkQxShTIuPV4BLTpQ1ekoHV
 aEpGE6xi7MP+gSb1EGJ3dytMw00pYA2Pk0WB9nNyZmtpU9E73L+Iyk/kZIH42CRQhpGI7T
 ik/Vi8/Thw60LDfbcvZVBs4OSmjC5Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660575946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xoj6LSjO5fzZR+xFPkcQdHdSiBKsJYLByt78qCwz6Ak=;
 b=ZcDjAPuw4yECp7dZkV8fA6L6E+LNNteMtkFufpu4yBkpdS46H0NTaTZIMaDfsMby7mshh0
 QbMcYfrVh7Idu7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6759E13A99;
 Mon, 15 Aug 2022 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4NYuGMpg+mJscAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Aug 2022 15:05:46 +0000
Date: Mon, 15 Aug 2022 17:07:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvphPfNzlDY6MM9r@yuki>
References: <20220812075005.16920-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220812075005.16920-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor pidns30 test using new LTP API
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
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
> -	char buf[256];
> -	struct mq_attr attr;
> -
> -	if (si->si_signo != SIGUSR1) {
> -		printf("received signal = %d unexpectedly\n", si->si_signo);
> +	if (si->si_signo != SIGUSR1 || si->si_code != SI_MESGQ || si->si_pid != 0)
>  		return;
> -	}
>  
> -	if (si->si_code != SI_MESGQ) {
> -		printf("expected signal code SI_MESGQ; got %d instead\n",
> -		       si->si_code);
> -		return;
> -	}
> -
> -	if (si->si_pid) {
> -		printf("expected signal originator PID = 0; got %d instead\n",
> -		       si->si_pid);
> -		return;
> -	} else {
> -		printf("signal originator PID = 0\n");
> -		result = TPASS;
> -	}
> -
> -	/*
> -	 * Now read the message - Be silent on errors since this is not the
> -	 * test purpose.
> -	 */
> -	rc = mq_getattr(si->si_int, &attr);
> -	if (rc != -1)
> -		mq_receive(si->si_int, buf, attr.mq_msgsize, NULL);
> +	received++;

I do not like that much that we lost most of the information about the
failure here. Can we store at least the si_signo and si_pid so that they
can be printed in the case of the failure?

> -int main(void)
> +static void run(void)
>  {
> -	int status;
> -	char buf[5];
> -	pid_t cpid;
> -
> -	setup();
> -
> -	if (pipe(child_to_father) == -1 || pipe(father_to_child) == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
> -	}
> +	int ret;
>  
> -	tst_syscall(__NR_mq_unlink, mqname);
> +	remove_mqueue(mqd);
>  
> -	/* container creation on PID namespace */
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> -	if (cpid == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  
> -	mqd =
> -	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
> -		    NULL);
> +	mqd = mq_open(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, 0);
>  	if (mqd == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
> -	else
> -		tst_resm(TINFO, "successfully created posix mqueue");
> +		tst_brk(TBROK | TERRNO, "mq_open failed");

We allready have SAFE_MQ_OPEN() I guess that we may add the rest of the
SAFE_MQ_* calls as well and use them here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
