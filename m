Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FAEC6FA83
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 13:36:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5D13CAAED
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 15:36:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F6B73C953D
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 15:35:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9F5BA1400177
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 15:35:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 742F93384D;
 Mon, 12 Sep 2022 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662989754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZyGYdS4B6Jil3ZnOahXASeO0MgFvNnkEpAq1CfF/p1Q=;
 b=hNFEAbeaLxPNOP8abj+xR8K+0mfLIu8FE4myKW3nPPfJlZdy+BFf72q0DGZrX6Iu/tXiKL
 auutVraDYbKi9VVR31O/v/QKS1gmGa7ZdZFMupNcmMB5epA6k5UZtGAfi0dLVu5VfAsUqs
 SZsAuefbncQTQj+6QfX8r//5tLwy9P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662989754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZyGYdS4B6Jil3ZnOahXASeO0MgFvNnkEpAq1CfF/p1Q=;
 b=fkht8vuxhSBeMC/8ttwnCVJMvIhGcYK3aigCo1lzDXv+/hpeGghxQ1tQlpMlc5DssoOA+Y
 zPcs2zodYbiFH4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61668139E0;
 Mon, 12 Sep 2022 13:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sSVbF7o1H2MiMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 13:35:54 +0000
Date: Mon, 12 Sep 2022 15:37:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yx82LL6AX/TxDbbQ@yuki>
References: <20220912101948.4425-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220912101948.4425-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/user-guide: LTP_RUNTIME_MUL is only for C
 API
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
> Not yet implemented in shell API.
> + fix indent.
> 
> Fixes: 0f72d519a ("Introduce a concept of max runtime")

Should we rather then add "Not yet implemented" instead of "only for C
API" to the actual documentation too?

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/user-guide.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> index 0dc0c958e..fdd74ca41 100644
> --- a/doc/user-guide.txt
> +++ b/doc/user-guide.txt
> @@ -27,8 +27,8 @@ For running LTP network tests see `testcases/network/README.md`.
>                            Variable is also used in shell tests, but ceiled to int.
>  | 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
>                            that run for more than a second or two are capped on
> -			  runtime. You can scale the default runtime both up
> -			  and down with this multiplier.
> +                          runtime. You can scale the default runtime both up
> +                          and down with this multiplier. NOTE: only for C API.
>  | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
>                            library. Setting it to empty string tell the library
>                            that system is not a virtual machine. Other possible
> -- 
> 2.37.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
