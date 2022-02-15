Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB278C433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 12:57:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E3603CA068
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 13:57:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B37A83CA010
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 13:57:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23C03200D36
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 13:57:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 557DD1F382;
 Tue, 15 Feb 2022 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644929853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bacIf5313cv5NaKDCJ4fl6oqNIMHkNd0QqaKasCUDC8=;
 b=2oJWq8giMg1F+RAJqObgFAlbL4736ywA6y2oi7utm54WqYy6XdgHMn/TYo/HKbfft35QnC
 rvL79Y7jsf5nPg8WLlB2wa9Mh+KNu38GB8Ya9+pFH/g2AvHNbt1551VE/iPu1i4Qnv3sNW
 dXMtYRKG1ToTcXITWY6hiHHupktbskw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644929853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bacIf5313cv5NaKDCJ4fl6oqNIMHkNd0QqaKasCUDC8=;
 b=fdoD46G2BaAbtEXeUsMBJS3qAWFRyNyAS9JvqY9qp5zlGjb7V9foTsehcQa/6QvUOmQCBB
 bB4K5LbQU7Er3kAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40DDA13C75;
 Tue, 15 Feb 2022 12:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JNWDDT2jC2JdbwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 15 Feb 2022 12:57:33 +0000
Date: Tue, 15 Feb 2022 13:59:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Message-ID: <YgujvFcL0TIwoE5f@yuki>
References: <VI1PR04MB49583062AFA205712ABA54B793309@VI1PR04MB4958.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB49583062AFA205712ABA54B793309@VI1PR04MB4958.eurprd04.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] lib/safe_file_ops.c: Fix resource leak
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> safe_file_scanf and safe_file_vprintf suffered
> from resource leak, as opened file descriptor
> was not closed in case of error.
>
> Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
> ---
>  lib/safe_file_ops.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index f803691d8..d7231df4d 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -130,7 +130,7 @@ void safe_file_scanf(const char *file, const int lineno,
>         if (f == NULL) {
>                 tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>                         "Failed to open FILE '%s' for reading", path);
> -               return;
> +               goto out;

This one is wrong, we just tested that f == NULL

>         }
>  
>         exp_convs = tst_count_scanf_conversions(fmt);
> @@ -142,14 +142,14 @@ void safe_file_scanf(const char *file, const int lineno,
>         if (ret == EOF) {
>                 tst_brkm_(file, lineno, TBROK, cleanup_fn,
>                         "The FILE '%s' ended prematurely", path);
> -               return;

Technically this tst_brkm_() call does not return unless we are in the
test cleanup. During the rest of the test execution it ends up calling
exit(TBROK). So this return is reached only if something fails during
the test cleanup. I guess that we can fix it like this, but the test
will exit shortly after anyways.

> +               goto out;
>         }
>  
>         if (ret != exp_convs) {
>                 tst_brkm_(file, lineno, TBROK, cleanup_fn,
>                         "Expected %i conversions got %i FILE '%s'",
>                         exp_convs, ret, path);
> -               return;
> +               goto out;
>         }
>  
>         if (fclose(f)) {
> @@ -157,6 +157,8 @@ void safe_file_scanf(const char *file, const int lineno,
>                         "Failed to close FILE '%s'", path);
>                 return;
>         }
> +out:
> +       fclose(f);
>  }
>  
>  
> @@ -261,13 +263,13 @@ static void safe_file_vprintf(const char *file, const int lineno,
>         if (f == NULL) {
>                 tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>                         "Failed to open FILE '%s' for writing", path);
> -               return;
> +               goto out;

And here as well.

>         }
>  
>         if (vfprintf(f, fmt, va) < 0) {
>                 tst_brkm_(file, lineno, TBROK, cleanup_fn,
>                         "Failed to print to FILE '%s'", path);
> -               return;
> +               goto out;
>         }
>  
>         if (fclose(f)) {
> @@ -275,6 +277,8 @@ static void safe_file_vprintf(const char *file, const int lineno,
>                         "Failed to close FILE '%s'", path);
>                 return;
>         }
> +out:
> +       fclose(f);
>  }
>  
>  void safe_file_printf(const char *file, const int lineno,
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
