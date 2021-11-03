Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15829C433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:17:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577D161076
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 577D161076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 926D83C7210
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:17:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B5D3C129E
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 14:17:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C08C8600705
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 14:17:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11C72218EE;
 Wed,  3 Nov 2021 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635945451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFrRPt3fpS5a1dypm6AtEnJ7W307oT3wM3wlRDg+HnE=;
 b=dqKHwZ5URuHGRuf3TbqG3dJh2Wd6VqB0nUprlif0ZPdbsY+6GUcyKW6rEjEQ9obt8FX3gO
 fwUDNiyuTkXtWhZtOsqtMeXMVdG5pdhUjmDQapwjNqVDZKGIZGA0pWx+Z0gHwJnOzBZ4TW
 j/cAj9jBkReRfwLO/5ENdwelmmL5oOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635945451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFrRPt3fpS5a1dypm6AtEnJ7W307oT3wM3wlRDg+HnE=;
 b=sbe4c0ZWXHHJ/dOBEzus/C/EddZbVHViAojBDf43F1VcI4aX4WjshndeYRiGYoWOCwcx1J
 IE4n1TwUgeZt3ZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8CA313AA2;
 Wed,  3 Nov 2021 13:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hXhwNOqLgmE6bgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 13:17:30 +0000
Date: Wed, 3 Nov 2021 14:18:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YYKMIuHDheI1PK8x@yuki>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-8-chrubis@suse.cz> <YYKI9I05hEjiKNiE@pevik>
 <YYKLnxZL44ftguOx@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYKLnxZL44ftguOx@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] docparse: Split into metadata and docparse
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
> Actually it's the
> 
> MAKE_TARGETS := ltp.json docparse
> 
> which treats the docparse as a actuall file.
> 
> So I guess that we need this:
> 
> diff --git a/metadata/Makefile b/metadata/Makefile
> index 6c36cd210..522af4270 100644
> --- a/metadata/Makefile
> +++ b/metadata/Makefile
> @@ -6,7 +6,7 @@ top_srcdir              ?= ..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  include $(top_srcdir)/include/mk/functions.mk
> 
> -MAKE_TARGETS           := ltp.json docparse
> +MAKE_TARGETS           := ltp.json
>  HOST_MAKE_TARGETS      := metaparse
>  INSTALL_DIR            = metadata
> 
> @@ -14,13 +14,16 @@ INSTALL_DIR         = metadata
> 
>  ltp.json: metaparse
>         $(abs_srcdir)/parse.sh > ltp.json
> -
> -docparse: ltp.json
>  ifeq ($(WITH_METADATA),yes)
>         mkdir -p $(abs_top_builddir)/docparse
>         $(MAKE) -C $(abs_top_builddir)/docparse/ -f $(abs_top_srcdir)/docparse/Makefile
>  endif

And obviously if we do not want to install the html pages we can remove
this part:

> +ifeq ($(WITH_METADATA),yes)
> +install:
> +       $(MAKE) -C $(abs_top_builddir)/docparse/ -f $(abs_top_srcdir)/docparse/Makefile install
> +endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
