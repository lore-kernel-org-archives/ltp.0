Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CEFECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 12:52:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59F103CAC31
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 14:52:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EA933C972D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 14:52:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7637D1000F4A
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 14:52:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEBB421D35;
 Thu, 15 Sep 2022 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663246342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4d6/DECLYJPIgCLT1PB6chwnk5xP7Qdv4X4dYzyEiw=;
 b=vTqZt/TZXvcEcFKztjg7xOdwvb8f9kRcvhbXBzrocioE1EA2sI2LWlzXcms1HlYyQn05Nf
 qhNTC+X1gxU7/ORxQ3A782vYRoELuxkl/Wk8fYeRP1+aP0C87pjZBXmGka6zQ+zVc0ZhMj
 bI8HFIKcphYRl+ATNO0Le/VJ3tj7iYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663246342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4d6/DECLYJPIgCLT1PB6chwnk5xP7Qdv4X4dYzyEiw=;
 b=K2lWlM3rxZ6SXgej4vf/7oMBr65lpV6aX3cOx31qZZcs9uyJo+HbKt0t+IEt2QN2JA3JBP
 KMhfx8tN5oTEysCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6BB2133B6;
 Thu, 15 Sep 2022 12:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1pXXJwYgI2O+TgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 12:52:22 +0000
Date: Thu, 15 Sep 2022 14:52:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyMgBQu+phGCulxV@pevik>
References: <20220915031020.2633347-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915031020.2633347-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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

Hi LI,

> [pre-release testing fix]

> Test in automation easily get EMFILE error before reaching the fds_limit,
> but hard to reproduce it again manually. The possible reason is that some
> shared fd being opened in the parent shell and occupying the fd numbers
> which inherited by test then results in open failed with EMFILE early.

> This patch adds back of the EMFILE check in the open() loops, to flexible
> test fd limitation.

>   open04.c:36: TBROK: open(open04.1020,66,0777) failed: EMFILE (24)
>   open04.c:53: TWARN: close(0) failed: EBADF (9)

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/open/open04.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
> index d452405d4..01a8b12d6 100644
> --- a/testcases/kernel/syscalls/open/open04.c
> +++ b/testcases/kernel/syscalls/open/open04.c
> @@ -33,7 +33,12 @@ static void setup(void)

>  	for (i = first + 1; i < fds_limit; i++) {
>  		sprintf(fname, FNAME ".%d", i);
> -		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
> +		fd = open(fname, O_RDWR | O_CREAT, 0777);
> +		if (fd == -1) {
> +			if (errno != EMFILE)
> +				tst_brk(TBROK, "Expected EMFILE but got %d", errno);
> +			break;
> +		}
>  		fds[i - first] = fd;
>  	}
>  }

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
