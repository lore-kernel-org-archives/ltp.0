Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFE3C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 13:03:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06B833C9480
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 15:03:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2FC3C25D7
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 15:03:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36D3F6008D8
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 15:03:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 546EA33F21;
 Fri,  5 Aug 2022 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659704617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHWguCMtBtRrV8JGcqW8JmpRGR7ySDK/h/4buZ7KiFU=;
 b=PU2Hi8fxmwRFa9o+2odi6SBCXCBEB4tpr9nyFyIHW3Kjvm7kDPLgSS4hzfS2YbBoXOEcSR
 Elm6nqvdv2AvIs4kS5oFdlrqrJIolUkHZsGQNofuFKdxkn7geYa6UP2dwhRwQbpcXwrwUW
 HtMv1F0eoREjMk1nYKuR5U2Tk6E1uoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659704617;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHWguCMtBtRrV8JGcqW8JmpRGR7ySDK/h/4buZ7KiFU=;
 b=GPywYl6Ijaz9SQ1R6dKF15kL8VfV8I8Hc7lwSqBQruKLxib9HiGPL/0nKDuQbrBS8iPYXx
 O5Ud58c8AKdpMyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35B3B13A9C;
 Fri,  5 Aug 2022 13:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TnNiDCkV7WKkJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 05 Aug 2022 13:03:37 +0000
Date: Fri, 5 Aug 2022 15:05:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yu0VlowxwufSYbWw@yuki>
References: <20220804133015.15150-1-andrea.cervesato@suse.com>
 <20220804133015.15150-2-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220804133015.15150-2-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] Refactor pidns04 test using new LTP API
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
> -static void cleanup(void)
> +static void run(void)
>  {
> -	close(fd[0]);
> +	int ret;
> +
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");

I think that it may be cleaner to wait() the child here since if we
manage to kill the child the test will end up with:

tst_test.c:381: TBROK: Child (26434) killed by signal SIGKILL

so maybe add:

	SAFE_WAITPID(ret, &status, 0);

	if (WIFEXITTED(status) && WEXITSTATUS(status) == 0)
		return;

	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
		tst_res(TFAIL, "Child killed by SIGKILL");
		return;
	}

	tst_res(TBROK, "Child %s", tst_strstatus(status));


But maybe the clearer message is not worth the effort here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
