Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F7C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 776C43CEC33
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:29:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501523CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:29:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DEB41A0081C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:29:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 921A61FF3F;
 Wed, 25 Oct 2023 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698226183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=auOi/cjfL8QV7pogxgHF32+JBo4/ihpVNBE+DNJsNFs=;
 b=oc2Jj5SpvU+Sc1dl3EsuK6R5K1TgMoeYGRftdeHseAPeyClkBbIXBDdgGHv9GAa+H2okeP
 jEB6JAwF4jONYSEH3JStC4RweC3ZRKdNhdaGHI33GBN34Ai43wR5f1YIYGd4OWBJo/X+RH
 NecYlIGjiEKcC6PUcEtEUWooAJyZl8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698226183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=auOi/cjfL8QV7pogxgHF32+JBo4/ihpVNBE+DNJsNFs=;
 b=g/vKSGVCbspMmKqrDIJVFTGuCdWWH5e8um1lghSswcGwsPQCf2h/gqZPNFQ0D1jfktzoOi
 5TTPgvEL0awFtMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E1FF13524;
 Wed, 25 Oct 2023 09:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wMx2HQfgOGWfHQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 25 Oct 2023 09:29:43 +0000
Date: Wed, 25 Oct 2023 11:29:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZTjgBkVwwvqgbWm1@rei>
References: <20231024084923.217110-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231024084923.217110-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] stack_clash: Guard functions used only in
 64bit
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
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Pavel Boldin <pboldin@cloudlinux.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> To avoid "defined but not used" warnings when compiled on 32bit.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/cve/stack_clash.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
> index 3a99c49bb..56b970a1b 100644
> --- a/testcases/cve/stack_clash.c
> +++ b/testcases/cve/stack_clash.c
> @@ -92,6 +92,7 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
>  		_exit(EXIT_SUCCESS);
>  }
>  
> +#ifdef __x86_64__
>  static void force_bottom_up(void)
>  {
>  	FILE *fh;
> @@ -134,6 +135,7 @@ static void force_bottom_up(void)
>  out:
>  	SAFE_FCLOSE(fh);
>  }
> +#endif

Maybe I'm blind but this function does not seem to be called from inside
of #ifdef __x86_64__.

>  unsigned long read_stack_addr_from_proc(unsigned long *stack_size)
>  {
> @@ -187,6 +189,7 @@ void __attribute__((noinline)) preallocate_stack(unsigned long required)
>  	garbage[0] = garbage[required - 1] = '\0';
>  }
>  
> +#ifdef __x86_64__
>  static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
>  {
>  	void *map_test_gap;
> @@ -208,6 +211,7 @@ static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
>  		SAFE_MUNMAP(map_test_gap, MAPPED_LEN);
>  	}
>  }
> +#endif

This part looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
