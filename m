Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE687ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 11:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2C803CACB0
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 13:43:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B90B43CAC40
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 13:43:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C85E60329F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 13:43:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AB1333AF3;
 Fri, 16 Sep 2022 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663328591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIeQSiDAhpjpD2KVqobOfP0ptKdGb4VAeX7ZIZTicLs=;
 b=1xtCsSSizEyvCl1nIOG/3xMBocayWerehUbcZFtvyhn+qD8USqeS9ajXKHlkE0ThjouuvS
 ebeVJVrEverZJfbAHLDm8aW1jWP3EzfsdAhuOD8eg/AF6MBPgVy0Sj16UYqWhp/33qDyCp
 4mbP5keWPAP0ugkJMk/OTA+n2oFnq3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663328591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PIeQSiDAhpjpD2KVqobOfP0ptKdGb4VAeX7ZIZTicLs=;
 b=MMwxJnpWLksKOFeBUK5TXRVhAcV+MNjSXvF9cLy2aP+sRkRJTOQoYoXiEs1Nafwh+LtVQW
 wsDFk8gagJLjofCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB64F1332E;
 Fri, 16 Sep 2022 11:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sgB+N05hJGPLFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 11:43:10 +0000
Date: Fri, 16 Sep 2022 13:45:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YyRhxDnUoIDG0OCa@yuki>
References: <20220915093639.2261-1-pvorel@suse.cz>
 <20220915093639.2261-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915093639.2261-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/8] tst_supported_fs: Support skip list when
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> And use this feature in zram01.sh.

This looks like an leftover.

> Also print TINFO if test it supported by the test, quit with TCONF
> otherwise (code from do_test_setup() tst_test.c).
> 
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_supported_fs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
> index 2b42d5bb3..e2261244d 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -80,14 +80,19 @@ int main(int argc, char *argv[])
>  		return 2;
>  	}
>  
> -	if (optind < argc)
> -		return !tst_fs_is_supported(argv[optind]);
> +	if (optind < argc) {
> +		if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
> +			tst_brk(TCONF, "%s is not supported by the test", argv[optind]);
>  
> +		tst_res(TINFO, "%s is supported by the test", argv[optind]);
> +
> +		return 0;
> +	}

So we now do not check if filesystem is supported just check against the
skiplist?

I guess that it would mqake sense if -s option was present, but
shouldn't we check for mkfs and kernel support without -s if filesystem
was specified?

>  	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
>  
>  	if (!filesystems[0])
> -		tst_brk(TCONF, "There are no supported filesystems");
> +		tst_brk(TCONF, "There are no supported filesystems or all skipped");
>  
>  	for (i = 0; filesystems[i]; i++)
>  		printf("%s\n", filesystems[i]);
> -- 
> 2.37.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
