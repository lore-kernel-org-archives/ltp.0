Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD13C7EE22
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 21:21:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5863CEE45
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 23:21:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4E33CDCA4
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:21:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 126F810009F5
 for <ltp@lists.linux.it>; Wed, 17 May 2023 23:21:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D81BB22671;
 Wed, 17 May 2023 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684358505;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udNe+XJHwQdQ4vaNUgmVb73GhIljrUn+hDKB4ULnSHk=;
 b=KkFcClY9xlwxSPK7J2Zw6bfoQ0gGmU268nb6kaWVU1N0fR2BvALJmz6z+PwdIsmDcU0TzG
 a6v0m+nR9gSxneHH12H8P6gLc3TL9E8m+7mEhQoVCoKpEgfPzlqmykqvaNO8vvf/6AsHkD
 sF+WqG0QRTl6YNMXsvz+Dzgwk+v0Dwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684358505;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udNe+XJHwQdQ4vaNUgmVb73GhIljrUn+hDKB4ULnSHk=;
 b=fNM2qpMtznEctTQIxrKLAH2ehE7FVdewN184z8kAy0+qjfZnUKAXpgOIh/o8SrKQXGO+Iz
 EcekgXuROpL29wBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF83513358;
 Wed, 17 May 2023 21:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fWpMKWlFZWRiHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 May 2023 21:21:45 +0000
Date: Thu, 18 May 2023 00:47:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230517224746.GC8914@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-5-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230517153642.26919-5-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] KVM: Add async communication helper functions
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Acked-by: Petr Vorel <pvorel@suse.cz>

>  /*
>   * Result value indicating end of test. If the test program exits using
>   * the HLT instruction with any valid result value other than KVM_TEXIT or
> diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
> index ec13c5845..96f246155 100644
> --- a/testcases/kernel/kvm/include/kvm_guest.h
> +++ b/testcases/kernel/kvm/include/kvm_guest.h
> @@ -64,6 +64,20 @@ void tst_brk_(const char *file, const int lineno, int result,
>  	const char *message) __attribute__((noreturn));
>  #define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))

BTW (unrelated to this commit, as it was not added to this commit) tst_brk()
definition from include/tst_test.h contains also
TST_BRK_SUPPORTS_ONLY_TCONF_TBROK().

And tst_res() has also TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN().

We could rename tst_res_flags.h to tst_res.h and add there tst_brk() and
tst_res() definitions and tst_brk_() and tst_res_() signatures.

> +
>  #endif /* KVM_HOST_H_ */
> diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
> index d3b2ac3d5..f3e21d3d6 100644
> --- a/testcases/kernel/kvm/lib_guest.c
> +++ b/testcases/kernel/kvm/lib_guest.c
> @@ -155,6 +155,22 @@ void tst_brk_(const char *file, const int lineno, int result,
>  	kvm_exit();
>  }

> +void tst_signal_host(void *data)
> +{
> +	test_result->file_addr = (uintptr_t)data;
> +	test_result->result = KVM_TSYNC;
> +}
> +
> +void tst_wait_host(void *data)
> +{
> +	volatile int32_t *vres = &test_result->result;
> +
> +	tst_signal_host(data);
> +
> +	while (*vres != KVM_TNONE)
> +		;
Interesting there is no any usleep().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
