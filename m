Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6726CC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 14:47:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2703CA1BA
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 15:47:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93DFE3C96B4
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:47:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11A8114000AD
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:47:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D82141F39D;
 Tue, 22 Feb 2022 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645541220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOeq2hKGsKfe1Vb2rvHMzMvKBuPRW7Yx4eJ1y7/u7es=;
 b=N1e3VUNRqAl2VxcWvD3DNuG5HGImz5ao9Cnnbh2U3OebhQcE66HBccYq5e6r9uEXt7nbxx
 nhrf/bC7Xs4KNQhp0KabC4uvlQM6QYZJeCoV5MD4VbmvNWVFAixF22I+ZLyH+hEWPpE0t2
 M1lBJpUDFkIIPhoGYJQqrbRWjlP84hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645541220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOeq2hKGsKfe1Vb2rvHMzMvKBuPRW7Yx4eJ1y7/u7es=;
 b=eFkaiyyuOfg8Wkzz9L2iq2rqRtc9Bm9Lxa7pnblFVwpVp6PzRrdrH49TR5RGoydXbjeyoT
 vG/1m4WCzsZFBzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6230913BC2;
 Tue, 22 Feb 2022 14:47:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FMsQFGT3FGJZDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Feb 2022 14:47:00 +0000
Date: Tue, 22 Feb 2022 15:49:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YhT36IYLmEPM2jNB@yuki>
References: <20220222143549.3286-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222143549.3286-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite waitid01.c test using new LTP API
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
> +	TST_EXP_PASS(waitid(P_ALL, getpid(), infop, WEXITED));
> +	TST_EXP_EQ_LI(infop->si_pid, pidchild);
> +	TST_EXP_EQ_LI(infop->si_status, 123);
> +	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
> +	TST_EXP_EQ_LI(infop->si_code, CLD_EXITED);
>  }

Looks good, but we should add the two different cases as well.

The one that kills the child with SIGHUP should have si_code set to
CLD_KILLED and and the si_status should be SIGHUP. And the 'division by
zero' case is supposed to have it set to CLD_DUMPED. I think that we
should add these two tests as well.

Also looking at man pages the idtype can be set to P_PIDFD since 5.4 as
well, so we should add a waitid test with a pidfd too.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.bufs =
> +		(struct tst_buffers[]){
> +			{ &infop, .size = sizeof(*infop) },
> +			{},
> +		},
> +};
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
