Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12730ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 07:10:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 794873C8765
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 09:10:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B3633C8765
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 09:09:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D6B1600709
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 09:09:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5748133687;
 Fri, 26 Aug 2022 07:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661497793;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPCFMFA7TxQbO747zcfQpkimqhPsI5coYJeefNzHoTk=;
 b=Pe8VxsYCnhlegYVY5Z9HH0GZYh0v+x2bDD3Q212AlarkOSNFnEbU6NeTPX37ugt0OOh9gn
 RVzXLxkvGxRkogD3o0nPqzzAX6IRUFcW+QRLsA+Gl5V73brngVQIn3SNMArtFN+HfhKmhf
 uaeDJGG/1BhxfMZ7Hc/qzlQMkWAmpQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661497793;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPCFMFA7TxQbO747zcfQpkimqhPsI5coYJeefNzHoTk=;
 b=ZqnAo6yQygOyZHoT1ERXhotejjcjV6f7oT+WxwtxkqVLnsdjpbN59A94wZO04+dlWxbwXo
 xNqzdPzF4q4haHDg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 239CA2C141;
 Fri, 26 Aug 2022 07:09:53 +0000 (UTC)
References: <20220824124017.14286-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Fri, 26 Aug 2022 08:04:21 +0100
In-reply-to: <20220824124017.14286-1-andrea.cervesato@suse.com>
Message-ID: <87bks71nwg.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> -static void cma_test_invalid_perm(void)
> +static void test_invalid_perm(void)
>  {
>  	char nobody_uid[] = "nobody";
>  	struct passwd *ltpuser;
> -	int status;
>  	struct process_vm_params *params;
>  	pid_t child_pid;
>  	pid_t parent_pid;
> -	int ret = 0;
> +	int status;
> +
> +	tst_res(TINFO, "Testing invalid permissions on given PID");
>  
> -	tst_resm(TINFO, "test_invalid_perm");
>  	parent_pid = getpid();
> -	child_pid = fork();
> -	switch (child_pid) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> -		break;
> -	case 0:
> -		ltpuser = getpwnam(nobody_uid);
> -		if (ltpuser == NULL)
> -			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
> -		SAFE_SETUID(NULL, ltpuser->pw_uid);
> -
> -		params = cma_alloc_sane_params();
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		ltpuser = SAFE_GETPWNAM(nobody_uid);
> +		SAFE_SETUID(ltpuser->pw_uid);
> +
> +		params = alloc_params();
>  		params->pid = parent_pid;
> -		cma_test_params(params);
> -		ret |= cma_check_ret(-1, TEST_RETURN);
> -		ret |= cma_check_errno(EPERM);
> -		cma_free_params(params);
> -		exit(ret);
> -	default:
> -		SAFE_WAITPID(cleanup, child_pid, &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child returns %d", status);
> +		test_params(params);
> +		TST_EXP_EQ_LI(TST_RET, -1);
> +		check_errno(EPERM);
> +		free_params(params);
> +		return;
>  	}
> +
> +	SAFE_WAITPID(child_pid, &status, 0);

We want to use tst_reap_children() here which will check the exit
status.

In fact, if SAFE_WAITPID is removed altogether then the exit status will
be checked automatically at the end of the test when the lib calls
reap_children.

Otherwise LGTM!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
