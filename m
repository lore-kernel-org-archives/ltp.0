Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33368EB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 04:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D26173CF12F
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 06:24:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 961C33CCFE7
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 06:24:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79751600131
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 06:24:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23F2D1F8AF;
 Thu, 29 Jun 2023 04:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688012659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3g6X/m0AgcGyKvhwjw/KSs8Ci1RvFsyrEnGo0KZoNc=;
 b=q3X/3TLej1NsIw9zv7EYXG+7jstqMCs4rlaHXjoMnMx5JWsmzpheAL8MNIX7eF/D7tDg93
 MXkDTJprLIUnydCmrrBqj7LhFTL0H+GfC3VpSRgjPDAnctVlRhdv9lsF31ZcGUXS8e0DOU
 6E+TVtqCWrEgIQMJf0i+D+uF4Wcz3tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688012659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3g6X/m0AgcGyKvhwjw/KSs8Ci1RvFsyrEnGo0KZoNc=;
 b=JrRcyTYFsIM5vwGHkdytx9QNpYNGPvzUN9RGswSKoM53z3r+Ju0lJbr0SipmSCTRxtkn2Y
 EA4ZMQO7cIk0ZtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 652BB1348C;
 Thu, 29 Jun 2023 04:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fPe3CnIHnWRScQAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 29 Jun 2023 04:24:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 29 Jun 2023 09:54:08 +0530
Message-ID: <2692871.mvXUDI8C0e@localhost>
Organization: SUSE
In-Reply-To: <20230627183114.89536-1-pvorel@suse.cz>
References: <20230627183114.89536-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/C-API: Move .min_mem_avail below .min_cpus
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

Reviewed-by: Avinesh Kumar <akumar@suse.de>

On Wednesday, June 28, 2023 12:01:14 AM IST Petr Vorel wrote:
> From: Petr Vorel <petr.vorel@gmail.com>
> 
> Required minimum of CPU and RAM are related topics,
> it's better to have together.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/c-test-api.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index dcb6e1ba8..9106758d7 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2328,7 +2328,13 @@ both V1 and V2 feasible.
>  Some tests require more than specific number of CPU. It can be defined with
> `.min_cpus = N`.
> 
> -1.38 Test tags
> +1.38 Require minimum size of MemAvailable for a testcase
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Some tests require more than specific size(MB) of MemAvailable. It can be
> defined +with `.min_mem_avail = N`.
> +
> +1.39 Test tags
>  ~~~~~~~~~~~~~~
> 
>  Test tags are name-value pairs that can hold any test metadata.
> @@ -2370,7 +2376,7 @@ struct tst_test test = {
>  };
>  ---------------------------------------------------------------------------
> ----
> 
> -1.39 Testing on the specific architecture
> +1.40 Testing on the specific architecture
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Testcases for specific arch should be limited on that only being supported
>  platform to run, we now involve a .supported_archs to achieve this feature
> @@ -2406,12 +2412,6 @@ static struct tst_test test = {
>  };
>  ---------------------------------------------------------------------------
> ----
> 
> -1.40 Require minimum size of MemAvailable for a testcase
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -Some tests require more than specific size(MB) of MemAvailable. It can be
> defined -with `.min_mem_avail = N`.
> -
>  2. Common problems
>  ------------------





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
