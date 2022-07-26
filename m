Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3161C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 09:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95B1F3C9D96
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 11:09:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 565853C1BC6
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:08:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC0D1200C81
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 11:08:53 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 30FFE1FA28
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658826533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRLg54YD5LKdq6zKmdpFNJ1kuiNBikOAQacsh2o7GrI=;
 b=yPY/DTnJX70Pcl2Mbb/KU6A4N703LjDO9DWwTIKSAQCrcREvJ9TEB0JDXJ8FxMY27qe1tG
 P1jg0H6+WFqlPg3xxRaPQhNjoHLYxPNPQr4ZHcmMtdvAcFl2/qUNsAS10VD6yFFQuC+fwk
 05piz8qQVa+7kutEOqMBQhQ6HEZ2x8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658826533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRLg54YD5LKdq6zKmdpFNJ1kuiNBikOAQacsh2o7GrI=;
 b=Eh+VICJ8hStDghwloe34f48VjKCelcLRmJxrHpiHFdZ+4IcUxDqglYthpH7O5if14eH5SZ
 +ca4lRoKIZCPGtDg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 00B5B2C15D;
 Tue, 26 Jul 2022 09:08:52 +0000 (UTC)
References: <20220726055810.15176-1-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 26 Jul 2022 10:08:05 +0100
In-reply-to: <20220726055810.15176-1-akumar@suse.de>
Message-ID: <87tu7444wr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Typo fixes in comments
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

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  include/tst_fs.h        | 2 +-
>  lib/tst_fs_link_count.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index bc6692bd4..26b8b353f 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -193,7 +193,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist);
>   * Returns 1 if filesystem is in skiplist 0 otherwise.
>   *
>   * @fs_type A filesystem type to lookup.
> - * @skiplist A NULL terminated array of fileystemsytems to skip.
> + * @skiplist A NULL terminated array of filesystems to skip.
>   */
>  int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
>  
> diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
> index b8807236d..6a6bb52b2 100644
> --- a/lib/tst_fs_link_count.c
> +++ b/lib/tst_fs_link_count.c
> @@ -119,7 +119,7 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
>  		return 0;
>  	}
>  
> -	/* for current kernel, subdir limit is not availiable for all fs */
> +	/* for current kernel, subdir limit is not available for all fs */
>  	fs_type = tst_fs_type(cleanup, dir);
>  
>  	whitelist_size = ARRAY_SIZE(subdir_limit_whitelist);
> -- 
> 2.36.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
