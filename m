Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D08C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:50:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42FF3CAAF6
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 14:50:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B1A3C2157
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:49:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE4E51A008BD
 for <ltp@lists.linux.it>; Thu, 19 May 2022 14:49:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3664A1FD3C;
 Thu, 19 May 2022 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652964591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9ENC/VFGv2m2pw7wr0VPAOWxUl91wSwGbEjJ+ULP0Q=;
 b=hzTmXrIQBmLB7ISfeg/75kWjf5WhUVKJCjE4ZMXXBVBk1pZ5woHmc/GOI/TCUrNCcXH/zt
 QJCca1J+BO7PrL33pD53tnyO6bNIUt4xwSIpeJYJN35S7IP7SjolJB2qg8Exm3qh9upsIZ
 yroa5chIxWJHaoEi12aeSb+c7MU/oTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652964591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9ENC/VFGv2m2pw7wr0VPAOWxUl91wSwGbEjJ+ULP0Q=;
 b=Bnhdk6Yt+YQ7b84snk0jRszpwM/J7qOHELgamT0MI9hK3nps7SmKfaAjk6Qa+S1st5xu4o
 PrfbMGn/yQu3jUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2429D13AF8;
 Thu, 19 May 2022 12:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lnjsB+88hmLrEwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 May 2022 12:49:51 +0000
Date: Thu, 19 May 2022 14:52:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YoY9c4I7bGX+Nkrn@yuki>
References: <20220506142125.15564-1-mdoucha@suse.cz>
 <20220506142125.15564-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220506142125.15564-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] kvm: Allow running multiple iterations of a
 test
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
> This fixes running the test with "-i N" for N>1. It's a lazy fix but
> the alternative would be saving the initial CPU state in up to 3 separate
> buffers and then restoring it after each test run. And the number of buffers
> differs on different archs. And ARM64 has an extra ioctl() instead...
> 
> I also wonder whether I should implement LTP library function to free
> individual guarded buffers because I don't like calling tst_free_all()
> directly.

Well I guess that we can do that later on. It should be easy enough if
we switch to a double linked list and do a linear search, after all I
doubt that we will allocate more than a few buffers this way.

>  testcases/kernel/kvm/lib_host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
> index b8994f34e..2782e68b0 100644
> --- a/testcases/kernel/kvm/lib_host.c
> +++ b/testcases/kernel/kvm/lib_host.c
> @@ -269,16 +269,20 @@ void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
>  		SAFE_CLOSE(inst->vcpu_fd);
>  
>  	SAFE_CLOSE(inst->vm_fd);
> +	memset(inst->ram, 0, sizeof(inst->ram));
>  }
>  
>  void tst_kvm_setup(void)
>  {
> -	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
> +
>  }
>  
>  void tst_kvm_run(void)
>  {
> +	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
>  	tst_kvm_run_instance(&test_vm);
> +	tst_kvm_destroy_instance(&test_vm);
> +	tst_free_all();
>  }

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
