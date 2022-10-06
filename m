Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA30C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 11:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5AA03CAE17
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 13:53:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0CF33CA8BB
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:53:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B936020096C
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 13:53:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2C251F908;
 Thu,  6 Oct 2022 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665057221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dj7FJ05Oo8M/pjp+S6bvqEj0DIQWGZg3jRmvwSX+Y2Y=;
 b=3BMFFq1JMPFO2wJ9CUnomGFJpFawSTQVjLH6TyFz5EeC6K6qQ6xMHRScH/E+k9EAaaXUNs
 28DCoVCji9tpGsvLEdfNgO/QAqQqRpaeaL/rh0buSZnKT99I5m1j8w09CqJaHKSAUCdrsw
 FNhg7aGzg5UHkvnK2dzmMvUbw0jrBeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665057221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dj7FJ05Oo8M/pjp+S6bvqEj0DIQWGZg3jRmvwSX+Y2Y=;
 b=PH8lX/J3jMlBsdW8INDT+x16nhAhS23Laa2SExa4KvfeKj2YuvbjP24+QPnkeWazYuwB/H
 ZSKnwT3diWqFQXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83FF31376E;
 Thu,  6 Oct 2022 11:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZtUmHsXBPmMkHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Oct 2022 11:53:41 +0000
Date: Thu, 6 Oct 2022 13:53:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yz7BwzN+Uzr2DtyT@pevik>
References: <20220824080638.23012-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220824080638.23012-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add more madvise testcases in madvise01
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
Cc: Sandeep Patil <sspatil@google.com>, Steve Muckle <smuckle@google.com>,
 Minchan Kim <minchan@kernel.org>, kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

[ Cc the author of the kernel commit and android folks ]

Obviously correct, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Added MADV_COLD and MADV_PAGEOUT madvise modes and created two new
> testcases in madvise01 for them. Supported by kernel >= 5.4.



> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/mmap.h                           | 8 ++++++++
>  testcases/kernel/syscalls/madvise/madvise01.c | 2 ++
>  2 files changed, 10 insertions(+)

> diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> index 12845b76e..49108338b 100644
> --- a/include/lapi/mmap.h
> +++ b/include/lapi/mmap.h
> @@ -66,6 +66,14 @@
>  # define MADV_KEEPONFORK 19
>  #endif

> +#ifndef MADV_COLD
> +# define MADV_COLD	20
> +#endif
> +
> +#ifndef MADV_PAGEOUT
> +# define MADV_PAGEOUT	21
> +#endif
> +
>  #ifndef MAP_FIXED_NOREPLACE

>  #ifdef __alpha__
> diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
> index de5daf34a..ec64a1db3 100644
> --- a/testcases/kernel/syscalls/madvise/madvise01.c
> +++ b/testcases/kernel/syscalls/madvise/madvise01.c
> @@ -55,6 +55,8 @@ static struct tcase {
>  	{MADV_FREE,        "MADV_FREE",        &amem},  /* since Linux 4.5 */
>  	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &amem},  /* since Linux 4.14 */
>  	{MADV_KEEPONFORK,  "MADV_KEEPONFORK",  &amem},  /* since Linux 4.14 */
> +	{MADV_COLD,        "MADV_COLD",        &amem},  /* since Linux 5.4 */
> +	{MADV_PAGEOUT,     "MADV_PAGEOUT",     &amem},  /* since Linux 5.4 */

>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
