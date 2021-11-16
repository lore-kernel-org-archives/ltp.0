Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A122C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874F561BE5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 874F561BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29C483C87B4
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 11:57:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E13D3C065E
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:56:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D29D14002C6
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:56:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96D471FCA1;
 Tue, 16 Nov 2021 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637060212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqo+lcntlh9Uips3+FQvrLiVIKDumsJfEbQtboN4RAk=;
 b=UpqLiv6z/kNE17DYIJz4vevXYb7IJ/230rFIYSxaTTsT4OTrjOa5VsxDY+JfZccw5dAIPM
 W3LKYEgdq3+04FR1culo45T8nygdIwRO7Ssqh6nj54Ff1XZCetFCU4xTISY4LgZlSB1paZ
 XyUsT27rbp67HPrs02AgZFq7CAr4CSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637060212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqo+lcntlh9Uips3+FQvrLiVIKDumsJfEbQtboN4RAk=;
 b=OeOD58ecDDUXSCdonroPn/xk2GW5K2xdomWpiiJuowQdbxkoGLdN4HMZdAiKDQdouxuYyk
 /4r3JrLZaOYUNdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A45B13C06;
 Tue, 16 Nov 2021 10:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vyRLGHSOk2GSNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Nov 2021 10:56:52 +0000
Date: Tue, 16 Nov 2021 11:56:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YZOOcmFmg+2JzK8b@pevik>
References: <20211105090200.103485-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211105090200.103485-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify07: add stop_children() to
 cleanup()
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
Cc: Matthew Bobrowski <repnop@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> When we run the testcase simultaneously, and the ulimit of open
> files is small, the testcase will fail and remain many while(1)
> tasks in system, it makes the system very stuck.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2: add stop_children() to cleanup(),suggested by Amir and Matthew.

>  testcases/kernel/syscalls/fanotify/fanotify07.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> index cc56d9019..40d1b96ce 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -86,15 +86,21 @@ static int stop_children(void)
>  	int child_ret;
>  	int i, ret = 0;

> -	for (i = 0; i < MAX_CHILDREN; i++)
> +	for (i = 0; i < MAX_CHILDREN; i++) {
> +		if (!child_pid[i])
> +			continue;
>  		SAFE_KILL(child_pid[i], SIGKILL);
> +	}

>  	for (i = 0; i < MAX_CHILDREN; i++) {
> +		if (!child_pid[i])
> +			continue;
>  		SAFE_WAITPID(child_pid[i], &child_ret, 0);
>  		if (!WIFSIGNALED(child_ret))
>  			ret = 1;
I slightly prefer instead of using memset code which Amir suggested:
		child_pid[i] = 0;
>  	}

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

NOTE: patch was corrupted, please take care next time
(error: corrupt patch at line 131)
Also

Kind regards,
Petr

> +	memset(child_pid, 0, sizeof(pid_t) * MAX_CHILDREN);
>  	return ret;
>  }

> @@ -190,6 +196,8 @@ static void setup(void)

>  static void cleanup(void)
>  {
> +	stop_children();
> +
>  	if (fd_notify > 0)
>  		SAFE_CLOSE(fd_notify);
>  }
> @@ -201,6 +209,7 @@ static struct tst_test test = {
>  	.needs_tmpdir = 1,
>  	.forks_child = 1,
>  	.needs_root = 1,
>  };

>  #else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
