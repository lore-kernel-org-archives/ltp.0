Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B631EC43219
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 08:11:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3DC33CB170
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:11:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED96D3CA95C
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:11:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4401E600D2B
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:11:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9D32E1F8D9;
 Thu, 20 Oct 2022 08:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666253495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxaD2LCnkiwBmohUPHxSPgxq3Sny30fk1UgE1ZCLOYw=;
 b=JVuBm1Ubqu2H0VfAfj0NKJIlEJ5BsTVlYCyu47TDvX/H0ZISMiy8MpInKjtIKqe0LXvzGh
 GYGv4Wd2D+Ld6iz+aDFRptRwSMqBPhsWQ1ZrmYFZhqftWk/8xq7ocTJqCng6SCOMldhCSH
 TlE5iimyZneecou/aS/P4P7APY0Pk3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666253495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxaD2LCnkiwBmohUPHxSPgxq3Sny30fk1UgE1ZCLOYw=;
 b=+OxIgFVTh3SPr4aepTUPyAihib1D9du5YDbzcFvfUKAZF6ikMGw3+pq8q+YNaLtdEVL5Uc
 /2PiVosxRYQBACAQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 48DEF2C141;
 Thu, 20 Oct 2022 08:11:35 +0000 (UTC)
References: <20221009065520.3236525-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 09:11:26 +0100
In-reply-to: <20221009065520.3236525-1-liwang@redhat.com>
Message-ID: <87a65qx6bu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] getitimer02: add ITIMER_VIRTUAL timer error
 check
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

Merged, thanks!

Li Wang <liwang@redhat.com> writes:

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/getitimer/getitimer02.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
> index 863e8e0a8..cd98dcce8 100644
> --- a/testcases/kernel/syscalls/getitimer/getitimer02.c
> +++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
> @@ -27,8 +27,9 @@ static struct tcase {
>         struct itimerval **val;
>         int exp_errno;
>  } tcases[] = {
> -       {ITIMER_REAL, &invalid, EFAULT},
> -       {-ITIMER_PROF, &value, EINVAL},
> +       {ITIMER_REAL,    &invalid, EFAULT},
> +       {ITIMER_VIRTUAL, &invalid, EFAULT},
> +       {-ITIMER_PROF,   &value,   EINVAL},
>  };
>  
>  static int sys_getitimer(int which, void *curr_value)
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
