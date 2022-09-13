Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F3C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 13:46:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10C543CAC04
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 15:46:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4AF3CA9FE
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:46:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 734D310000D2
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:46:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3DDC22314;
 Tue, 13 Sep 2022 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663076768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rRC/HGElSfzkqX0yIfPIU5M+6k8DqAIrz2ToE85hec=;
 b=ofxNTfr9zmTkD7gDbLuCanKufvEmLLKGoFatUjT6wtlZ7LkkrStBArKyYJXZlwuwoTGPAh
 8PN9ZNfDoQVLvn8kcDVC2W4thR5otO6+1TnM6y1gLchB6j3lCSLC2erqlrc4iqVaXkA6wM
 JyVLzzRSU5tP3TSojvOd6di+JyYZTYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663076768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rRC/HGElSfzkqX0yIfPIU5M+6k8DqAIrz2ToE85hec=;
 b=RhsfnM1OShssRo+MWp6UHowIl57z59rc5GJ1rVgXMKt2Zm17uIU4xDXGgrD3IXBwVU23N+
 JXaf8+d+gbWQfNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60EE0139B3;
 Tue, 13 Sep 2022 13:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gUyZEaCJIGPeJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 13:46:08 +0000
Date: Tue, 13 Sep 2022 15:46:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YyCJnQR7ORn3phVn@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909141840.18327-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 05/10] tst_supported_fs: Support skip list when
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

there are 2 errors, 2) needs more thinking.

> And use this feature in zram01.sh
1) zram01.sh check in "all_filesystem" mode, thus it should not be changed here,
but in the separate commit.

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
> index 9726d193a..cde162555 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -134,6 +134,22 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
>  	return TST_FS_UNSUPPORTED;
>  }

> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> +					      *const *skiplist)
> +{
> +	int ret;
> +
> +	ret = tst_fs_is_supported(fs_type);
2) while this function might be useful in the future, now it's not what is
needed... Because for single filesystem does not need check for mkfs.foo.
> +
> +	if (!ret)
> +		return ret;
> +
> +	if (tst_fs_in_skiplist(fs_type, skiplist))
> +		return TST_FS_UNSUPPORTED;
> +
> +	return ret;
> +}

There should be new function with code moved from do_test_setup():

void tst_fs_is_current_fs_supported(const char *fs_name, const char *const *skiplist)
{
	if (tst_fs_in_skiplist(fs_name, skiplist))
		tst_brk(TCONF, "%s is not supported by the test", fs_name);

	tst_res(TINFO, "%s is supported by the test", fs_name);
}

I know you want tst_res(TCONF) in the library, that means I'd have to
call tst_vbrk_(), right? Because we have message already printed.
Maybe different function prefix could help.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
