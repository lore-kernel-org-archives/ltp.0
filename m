Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFB8C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:56:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B38743C1BAE
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:56:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59B43C0209
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:56:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4A5F601A6E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:56:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17EE61F38A
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646909762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dAQZv8HmQ68CgoayYQh0SWp/WOXiftO8jXitl1URKnk=;
 b=EpDW6YsLJKM//DMfCw3Q9IMS3dTDUybx0m0u2UBtIy0QNKjGBimr/aFHOK/cUqfMVEnnuG
 6RwpsTMH8cIJvfJ80hLs4hPtN6TJOsTk8cdjoy7WmtXU3c2GhwbYUZwkArK44wKmSI6ZcX
 l+zhaRN+h/r8ZUiJCP90E214ycQnvGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646909762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dAQZv8HmQ68CgoayYQh0SWp/WOXiftO8jXitl1URKnk=;
 b=mMUy6eiSO/0jDDDX4OieerpbeoVH1M2Bxd9K8HQAcrf0+kZCqJJFaRHJ5W32+UfTR6Ga36
 OkFx5IXxtg5QPDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03FCB13A3D
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FX9EO0HZKWJQfQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:56:01 +0000
Date: Thu, 10 Mar 2022 11:58:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YinZzNWCiKalyWhd@yuki>
References: <20220310105533.3012-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310105533.3012-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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

Hi!
> While integer division by zero does trap on x86_64 and causes the SIGFPE
> signal to be delivered it's not the case on all architecutes. At least
> on ARM and PPC64LE division by zero simply returns undefined result
> instead.
> 
> This patch adds raise(SIGFPE) at the end of the child as a fallback to
> make sure the process is killed with the right signal on all
> architectures.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> index 869ef18bd..8c351d120 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -28,7 +28,10 @@ static void run(void)
>  		volatile int a, zero = 0;
>  
>  		a = 1 / zero;
> -		exit(a);
> +
> +		tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");

This patch inroduces 'set but not used' warning for the a variable so
maybe the message should look like:

		tst_res(TINFO, "1/0 = %i raising SIGFPE", a);

> +		raise(SIGFPE);
>  	}
>  
>  	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
