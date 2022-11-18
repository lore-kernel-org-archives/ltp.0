Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CF6C4332F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 13:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27AD03CCE9D
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 14:38:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D8A83CCE59
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:38:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E3AD629D5BA
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 14:38:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 187C21FA76;
 Fri, 18 Nov 2022 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668778697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGSAn2OD8IosBAQU84w538LqotecnId00c6IoY0LndM=;
 b=ox1TDEfRassAd5SZWxA+VJ2ImFhGMT7QiBxSB7A/n8pl1lYuMF2SrJ0ho8SL75FZiZB+W4
 6oc7B1PIk2y9CT4fap8xR/j0DED1FrUIzxobJbbW8wKYj4mLEkrN5GjLYH+hSnf7h/ksc/
 zUpPxWWYPcdXZxhxbDpFNwbSAh0FX9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668778697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGSAn2OD8IosBAQU84w538LqotecnId00c6IoY0LndM=;
 b=aBJKg5UF18YNW4VmK0UckAoxeojIfbbycaSl5MPYaEQTJAEuACtfFMAxsIdD50UXu2dBdg
 fUbz4m1SBr4WyuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04B9513A66;
 Fri, 18 Nov 2022 13:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Lw89O8iKd2MpLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Nov 2022 13:38:16 +0000
Date: Fri, 18 Nov 2022 14:39:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y3eLHM6Q/W+5Ndcg@yuki>
References: <20221118065751.4120847-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221118065751.4120847-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl02: make use of .max_runtime
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

Hi!
> --- a/testcases/kernel/syscalls/keyctl/keyctl02.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
> @@ -81,6 +81,11 @@ static void do_test(void)
>  		SAFE_PTHREAD_JOIN(pth[1], NULL);
>  		SAFE_PTHREAD_JOIN(pth[2], NULL);
>  		SAFE_PTHREAD_JOIN(pth[3], NULL);
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Runtime exhausted, exiting at %i looping times", i);
                                                              ^
							      maybe it
							      would be
							      better:
							      "exiting after %i loops"
> +			break;
> +		}
>  	}

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
