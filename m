Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A7EC54EBC
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 13:18:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8BDA3CCA9C
	for <ltp@archiver.kernel.org>; Wed, 11 Jan 2023 14:18:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6123CA19D
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 14:18:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A70E1400543
 for <ltp@lists.linux.it>; Wed, 11 Jan 2023 14:18:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6257C5D088;
 Wed, 11 Jan 2023 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673443111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zbTXFvZ3o1fDAkk/1MfKwK9GaUbabxNhUl4Mug1WGU=;
 b=XUAyZx7KcNZI95/2a7bb+g7LdwIFGyAfAfY97PwbhV0qKSi5JH5Jl8JGUTffgzEc0wYHOT
 mtlSUIcCWTawijT4TE+Y23wMmr5oZrb3PUul0PyOYsOKTzFrt6bZEkTJ4+l7uHBpUpvD+b
 Hpegqs53aKF3DSnx8frxMwWncS9Yi7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673443111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zbTXFvZ3o1fDAkk/1MfKwK9GaUbabxNhUl4Mug1WGU=;
 b=axkq21XJmEOaHKEwPmsOuKoiEdFgfp/3UqkZrSlz9ahJaFQTxZvLf6oyFFOzd5FGXO68jz
 Ju85CmVA4LMT70Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96B4E1358A;
 Wed, 11 Jan 2023 13:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fYu0FSa3vmOpZQAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 11 Jan 2023 13:18:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Jan 2023 18:48:27 +0530
Message-ID: <2068101.vSGb3dL7Gk@localhost>
Organization: SUSE
In-Reply-To: <20230110183555.6915-1-pvorel@suse.cz>
References: <20230110183555.6915-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Add 'LTP_' prefix
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

On Wednesday, January 11, 2023 12:05:55 AM IST Petr Vorel wrote:
> Follow the approach of the shell API:
> 
>     TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")
> 
> Prefix helps to see directories mounted by LTP.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_tmpdir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index d1419a1a40..b73b5c66f7 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -269,7 +269,7 @@ void tst_tmpdir(void)
>  	 * use our default TEMPDIR.
>  	 */
>  	env_tmpdir = tst_get_tmpdir_root();
> -	snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
> +	snprintf(template, PATH_MAX, "%s/LTP_%.3sXXXXXX", env_tmpdir, TCID);
>  
>  	/* Make the temporary directory in one shot using mkdtemp. */
>  	if (mkdtemp(template) == NULL) {
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
