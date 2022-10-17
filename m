Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5ADC4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 08:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974523CAFED
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:13:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069643CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:13:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0B0B200900
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:13:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 48DCE20299;
 Mon, 17 Oct 2022 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665994413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7/mSlthXGMj1ppagXk2kNiDH3nYr0r2EdNw7xnkJOg=;
 b=w/Y4cnaXPp0C9S3spokHW+/fQrDtt/daSPnIJOzZmrQbnMNiweXSUwZToRpxR8WJ7t6L+a
 ORv6eSc7a5PChhNwW5XvMx/YIjkb23n55YbWtNnQvPMmBHI1s3PxEBrxrsLHWd4kL5ZKFo
 +a+VnM3cHuVYtKIx5fdl6/flG5P9cqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665994413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7/mSlthXGMj1ppagXk2kNiDH3nYr0r2EdNw7xnkJOg=;
 b=as/LiSR91hsTkRovo3aBGltkXCPqqh5ATXoTittkOpuL3jN74ytz2lyAEa44MprEYoMfbK
 8ZCawMV1b+pgvjDQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EB1B52C141;
 Mon, 17 Oct 2022 08:13:32 +0000 (UTC)
References: <20220824080638.23012-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 17 Oct 2022 09:13:24 +0100
In-reply-to: <20220824080638.23012-1-andrea.cervesato@suse.com>
Message-ID: <87a65uq34j.fsf@suse.de>
MIME-Version: 1.0
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks!

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Added MADV_COLD and MADV_PAGEOUT madvise modes and created two new
> testcases in madvise01 for them. Supported by kernel >= 5.4.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/mmap.h                           | 8 ++++++++
>  testcases/kernel/syscalls/madvise/madvise01.c | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> index 12845b76e..49108338b 100644
> --- a/include/lapi/mmap.h
> +++ b/include/lapi/mmap.h
> @@ -66,6 +66,14 @@
>  # define MADV_KEEPONFORK 19
>  #endif
>  
> +#ifndef MADV_COLD
> +# define MADV_COLD	20
> +#endif
> +
> +#ifndef MADV_PAGEOUT
> +# define MADV_PAGEOUT	21
> +#endif
> +
>  #ifndef MAP_FIXED_NOREPLACE
>  
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
>  
>  };
>  
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
