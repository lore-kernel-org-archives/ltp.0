Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C13C77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 07:56:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 370EE3CBB62
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:56:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 634123C8DAE
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:56:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 26A4D1A000B0
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:56:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B49C21A04;
 Wed, 26 Apr 2023 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682495795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNMCwmw3gEWn3DZdtiSw/tddogfaAIQRHkmCZdadb/o=;
 b=QzagL7ggSMTy0m9zJPYikVXzB+MMjCNm8tiSMe0U/dg2U8IqZEI0OVC5oXcZI1/AVAkhhV
 uO9B0J0eR/7S5OfRzxKS3VjzUp7+BvhrXTF5zOSjVYxcMspeD6yHczQqvCI7NrSGvOq2gz
 kqeZEwZK5Amy4rnbubh1+gWIGaXh7TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682495795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNMCwmw3gEWn3DZdtiSw/tddogfaAIQRHkmCZdadb/o=;
 b=4d0iBQqBKEFH24J0e+GXEaG5gl5z2KUv9Mp/gfn08eRL/RDTFhTwyKehh7zVqLU8q+DNlj
 fKNuR2X+0J5FgGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0885913421;
 Wed, 26 Apr 2023 07:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OTYJAjPZSGTeBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 07:56:35 +0000
Date: Wed, 26 Apr 2023 09:57:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZEjZcgJMluP0eEie@yuki>
References: <20230421145746.5704-1-mdoucha@suse.cz>
 <20230421145746.5704-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230421145746.5704-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] KVM: Fix infinite loop in ptr2hex()
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
Cc: ltp@lists.linux.it, nstange@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Contrary to the C standard, (x >> 64) is equivalent to (x >> 0) on x86.

As far as I can tell right shift larger than the left operand size are
undefined, at least in C99.

Other than that the patch looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> This can cause infinite loop in ptr2hex() if the highest nibble
> in the second argument is non-zero. Use temporary variable to avoid
> bit-shifting by large values.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/kvm/lib_guest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
> index d237293fc..d3b2ac3d5 100644
> --- a/testcases/kernel/kvm/lib_guest.c
> +++ b/testcases/kernel/kvm/lib_guest.c
> @@ -82,7 +82,7 @@ char *ptr2hex(char *dest, uintptr_t val)
>  	uintptr_t tmp;
>  	char *ret = dest;
>  
> -	for (i = 4; val >> i; i += 4)
> +	for (i = 4, tmp = val >> 4; tmp; i += 4, tmp >>= 4)
>  		;
>  
>  	do {
> -- 
> 2.40.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
