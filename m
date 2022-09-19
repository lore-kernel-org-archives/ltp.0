Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02714ECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 07:48:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE42C3CACB2
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 09:47:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB6593C1BC5
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 09:47:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F65110005F1
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 09:47:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C57871F9D2;
 Mon, 19 Sep 2022 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663573667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/eobln0qacXFFBbV1DBipeZMIMKjKSH5lKyMs3MM1w=;
 b=VpmY3u3uGFouxupV98p+TMy1zBAfxvaEHgvBeYupv1LSZ85/NzUdEUSYYVQzDBllWzKBqF
 GoODqBLqhA773Pqm32R8fZujfjOjfR7ScFjjmnSl+0HisM/MnDTd5/Y1G0c5pkk6FvIUnc
 RuQBExzXqTbPs64j95nep66ZFvFcSZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663573667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/eobln0qacXFFBbV1DBipeZMIMKjKSH5lKyMs3MM1w=;
 b=lkoHh3Z9Bf+1tDP6nzA+yg2+8Jk3ohPsoaDsd6966OG0SqS06yOMkxT6YcT3BwQ6HAXUMh
 pzoBjBmiuJcQNNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B18F013ABD;
 Mon, 19 Sep 2022 07:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W1gDKqMeKGNeKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 19 Sep 2022 07:47:47 +0000
Date: Mon, 19 Sep 2022 09:49:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YygfGEU8YRftJ1fj@yuki>
References: <20220906054612.9790-1-pvorel@suse.cz> <YySDWP9I46TDIgEK@yuki>
 <YyTIvPWfkkEoUflB@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyTIvPWfkkEoUflB@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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
> FYI the error is from fanotify.h (kind of lapi file for fanotify:
<
> #ifndef __kernel_fsid_t
> typedef struct {
> 	int	val[2];
> } lapi_fsid_t;
> #define __kernel_fsid_t lapi_fsid_t
> #endif /* __kernel_fsid_t */
> 
> which we added in b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")
> "Instead of including <asm/posix_types.h> where it's defined we just
> define the missing bit." (fix for musl).

I'm aware of that, and while typedef is mostly wrong there are a few
places where it's required.

> But if you prefer to keep this check, I'm ok to merge it without it.
> 
> The long term solution could be to add variable to Makefile to pass extra
> parameters, e.g.:
> check_fanotify.h: CHECKPATCH_IGNORE += NEW_TYPEDEFS

Case by case decisions like this for typedef sounds better to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
