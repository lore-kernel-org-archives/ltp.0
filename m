Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8701C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24BD3C9536
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 12:03:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A94D3C54C9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:03:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C645860096A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:03:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D4D721900;
 Tue, 25 Jan 2022 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643108616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1FQ1mxGnnW+96i92Z59GoxpcB2bgC9FwGWB2ohPfIo=;
 b=vL6DxTtGyMOh6cgNB+BuhXZgJuSrnZrQmVd8kAespjdPlFao6rImbEibYAXRh38pxLoaQ0
 HBFTyMWjrS+tfamy4DwceygoZxk68zxhIVxcfSxkmLadq5PLCoqjpR+GvDttUmDOYqlvJG
 byv1Zg/VUFOEVWilP9Q7bZ5nYe3JukU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643108616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1FQ1mxGnnW+96i92Z59GoxpcB2bgC9FwGWB2ohPfIo=;
 b=IfjJxcUMLycHSyMSLcuvw8EbTQ4GqPGwSTIjHkjlqcIhXVCQ+rwv1AsEq0bE+khbbOK23b
 HgL06yFrGeMDBYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C48F13DB8;
 Tue, 25 Jan 2022 11:03:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DI/xIAfZ72EvfAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jan 2022 11:03:35 +0000
Date: Tue, 25 Jan 2022 12:05:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <Ye/Zc9S9OiBOWhE2@yuki>
References: <20220125024534.sdrsppor2n7s3pjb@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125024534.sdrsppor2n7s3pjb@xzhoux.usersys.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/mk/env_pre.mk: remove dup makefile
 sourcing
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
> This will cause file not found errors.
> 
> Signed-off-by: Murphy Zhou <jencce2002@gmail.com>
> ---
>  include/mk/env_pre.mk | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> index f36215167..f913eb5fd 100644
> --- a/include/mk/env_pre.mk
> +++ b/include/mk/env_pre.mk
> @@ -88,9 +88,6 @@ endif
>  # autotools, *clean, and help don't require config.mk, features.mk, etc...
>  ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)
>  
> -include $(abs_top_builddir)/include/mk/config.mk
> -include $(abs_top_builddir)/include/mk/features.mk

NACK.

These files are generated by running configure script.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
