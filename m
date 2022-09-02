Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CB3C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:38:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808A93CA8BF
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:38:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDAC83CA708
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:38:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADAFB6012CF
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:38:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CF168342C0;
 Fri,  2 Sep 2022 09:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662111516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L57+m5EthPTSJ/V6bcgdlHivSbiAh8feIkrj4555Rs0=;
 b=pSbEZR7+05FJLQzMQdn2Xdhr8Fe/8LSyDdSSSg9w95kOmp+DFEv4uVb8mN58N8j1EEug6a
 kTWU2FKUulVJUjPLVWZqr+V4hJe/ytkl73CVD72VpEEO1uocCeMe4EkhrIPUKZJPb0EiWD
 AIhGV1eNkfcGbXX+Ll0I5BP63I8qG/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662111516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L57+m5EthPTSJ/V6bcgdlHivSbiAh8feIkrj4555Rs0=;
 b=LAYdSwQC47hx1ZDk19ZDnQ0QMcK3b9cMEnZvief+gh2CizFh7JY9KGMsQC9jqE0Z8/giHK
 AASEe9DSf3uiRoBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5E9802C141;
 Fri,  2 Sep 2022 09:38:31 +0000 (UTC)
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-7-pvorel@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 02 Sep 2022 10:38:22 +0100
In-reply-to: <20220804121946.19564-7-pvorel@suse.cz>
Message-ID: <87tu5q15gj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 06/10] tst_supported_fs: Support skip list when
 query single fs
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
Cc: ltp@lists.linux.it, automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi,

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Petr Vorel <pvorel@suse.cz> writes:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v3
>
>  include/tst_fs.h                 | 10 ++++++++++
>  lib/tst_supported_fs_types.c     | 18 ++++++++++++++++++
>  testcases/lib/tst_supported_fs.c |  2 +-
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index 8159b99eb..2fe97f174 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -182,6 +182,16 @@ enum tst_fs_impl {
>   */
>  enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
>  
> +/*
> + * Check filesystem support (@see tst_fs_is_supported()), but consider also
> + * filesystems to skip.
> + *
> + * @fs_type A filesystem name to check the support for.
> + * @skiplist A NULL terminated array of filesystems to skip.
> + */
> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> +					      *const *skiplist);
> +
>  /*
>   * Returns NULL-terminated array of kernel-supported filesystems.
>   *
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 9726d193a..8c9379c1b 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
>  	return TST_FS_UNSUPPORTED;
>  }
>  
> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> +					      *const *skiplist)
> +{
> +	int ret;
> +
> +	ret = tst_fs_is_supported(fs_type);
> +
> +	if (!ret)
> +		return ret;
> +
> +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> +		tst_brk(TCONF, "%s is not supported by the test",
> +			fs_type);
> +	}
> +
> +	return ret;
> +}
> +
>  const char **tst_get_supported_fs_types(const char *const *skiplist)
>  {
>  	unsigned int i, j = 0;
> diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
> index 87be2b759..75945c809 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -70,7 +70,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	if (optind < argc)
> -		return !tst_fs_is_supported(argv[optind]);
> +		return !tst_fs_is_supported_skiplist(argv[optind], (const char * const*)skiplist);
>  
>  	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
>  	for (i = 0; filesystems[i]; i++)
> -- 
> 2.37.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
