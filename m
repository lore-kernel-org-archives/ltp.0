Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF015C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 12:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F34173C94F5
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 14:38:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 344D33C0F84
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 14:38:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5228A1A00348
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 14:38:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 378E521C61;
 Thu, 23 Jun 2022 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655987903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBjssUYP0vGreiOFhJFZvOHYr/h0wKuopftQ2QaJkvU=;
 b=LX+M3qW1OQUO2QaMvaYYneh+yRbhj8wezHua7DcjaJPg5V9vgkHCiWZl93KGd9N/v5n5Hd
 rp12HNa1/ppWw4Zf4x7dTDu69iEQWlfQe/etA/wJbmj0CBTc6xEJIcXMNqNQ153AawgnDc
 M9dMDLWzzqCPoRKtsy3860bGjoQtEUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655987903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBjssUYP0vGreiOFhJFZvOHYr/h0wKuopftQ2QaJkvU=;
 b=+xrDdHwV0I6tcFYdBqwX0FOc4lxv081kMPVb/YHz2yKLgO3N5EQLrsdqY5Daaz6224DJbk
 1CWKU/5J5h/eGhCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 265CB133A6;
 Thu, 23 Jun 2022 12:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p/NqCL9etGLBDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 23 Jun 2022 12:38:23 +0000
Message-ID: <0168e60b-9c56-af45-d754-75ce09b359fc@suse.cz>
Date: Thu, 23 Jun 2022 14:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20220620092146.7604-1-chrubis@suse.cz>
 <20220620092146.7604-8-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220620092146.7604-8-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] opeposix: pthread_barrierattr_getpshared/2-1:
 Simplify codeflow
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

Hi,
one small suggestion below, otherwise for the whole patchset:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 20. 06. 22 11:21, Cyril Hrubis wrote:
> This actually fixes a 'no return in nonvoid function' warning since gcc
> may get confused during the codeflow analysis.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../interfaces/pthread_barrierattr_getpshared/2-1.c   | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
> index a21a5a507..52c074173 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
> @@ -141,7 +141,9 @@ int main(void)
>  	if (pid == -1) {
>  		perror("Error at fork()");
>  		return PTS_UNRESOLVED;
> -	} else if (pid == 0) {
> +	}
> +
> +	if (pid == 0) {
>  		/* Child */
>  		/* Map the shared object to child's memory */
>  		barrier =
> @@ -209,10 +211,7 @@ int main(void)
>  
>  		printf("Test PASSED\n");
>  		return PTS_PASS;
> +	} else {
> +		return serial;

The return can be unconditional.

>  	}
> -
> -	if (pid == 0) {
> -		exit(serial);
> -	}
> -
>  }


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
