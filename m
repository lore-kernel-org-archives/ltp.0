Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE0C433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58960F70
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A58960F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001BE3C8F35
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 11:19:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4483C8610
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:19:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA0E42011B9
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:19:42 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id B7DB022405;
 Fri, 24 Sep 2021 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632475181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaqYV0ZS5xg6UWQuOQj8K9KgdiHKmkkjmV3jDS9yFoU=;
 b=waUuMpIbxMcvuTvhqJ7bms2X7CJRg9TWu+otmGTQJEmwOpomooSd8vNZyRN34owenBj3IN
 vqyqVGHnmpx9kCPyr8WQWGRNPwKy4EgXsT0XpSLb597tBGpnLxneUHp6UUgwt9EWl03kiA
 Ck/fek5aHc0jhbUTrkzLvsK1YM8/Jzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632475181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaqYV0ZS5xg6UWQuOQj8K9KgdiHKmkkjmV3jDS9yFoU=;
 b=d9rLfeMyk5HWmF3slfAEdvXkKce7LwGg6BZxlLcilYQjQz4LvhOv5je1W0mqcU3O5DH7Mq
 2fYXBfwnapoqtwCA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay1.suse.de (Postfix) with ESMTPS id 3E76025D40;
 Fri, 24 Sep 2021 09:19:41 +0000 (UTC)
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <20210923085224.868-2-zhanglianjie@uniontech.com>
User-agent: mu4e 1.4.15; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: zhanglianjie <zhanglianjie@uniontech.com>
In-reply-to: <20210923085224.868-2-zhanglianjie@uniontech.com>
Date: Fri, 24 Sep 2021 10:19:40 +0100
Message-ID: <87bl4il49f.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] syscalls/clone03: Convert to new API
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

This is a big improvement. However there are some things from the old
test which can be improved.

> +static void verify_clone(void)
> +{
> +	int child_pid;
>
> -		/* Close read end from parent */
> -		if ((close(pfd[0])) == -1)
> -			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
> +	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
> +				child_stack));

tst_clone is the new API.

>
> -		/* Get child's pid from pid string */
> -		child_pid = atoi(buff);
> +	if (!TST_PASS)
> +		return;
>
> -		if (TEST_RETURN == child_pid)
> -			tst_resm(TPASS, "Test passed");
> -		else
> -			tst_resm(TFAIL, "Test failed");
> +	tst_reap_children();
>
> -		if ((wait(&status)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "wait failed, status: %d", status);
> -	}
> +	child_pid = atoi(channel);

atoi is deprecated (see the man page).

>
> -	free(child_stack);
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_PASS(!(TST_RET == child_pid), "pid(%d)", child_pid);
>  }
>
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	channel = SAFE_MMAP(NULL, 10, PROT_READ | PROT_WRITE,
> +				MAP_SHARED | MAP_ANONYMOUS, -1, 0);

You could mmap a region needed for pid_t and just read and write it like
a normal variable.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
