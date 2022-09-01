Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E54AECAAD3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 11:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D3353CA843
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 13:05:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBB593CA4A1
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:05:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D292E60062B
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:05:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01FAD1FF45;
 Thu,  1 Sep 2022 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662030327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgKJFjqsszmdH/dTFxf9i5IaCbUdIh34QOZOowxeK94=;
 b=AlSO6Vgh1Nt3MIQMVq5gx1Yqysge+mXyUhle1IbHwG/gMbkWFSP10USwwFsPPp6v1G4CLm
 0rbY5OXAjOZUYGeZactISrOvHA6LUPVF0eVfvYltVeCKW+ArjqP7glwhZnMhcI6LqCIvDo
 JIR2VzCju3zFKtnTYu06t+A1dmP/4UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662030327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgKJFjqsszmdH/dTFxf9i5IaCbUdIh34QOZOowxeK94=;
 b=3gOo+yCWFmVcFJNFfIWN/tF8ne5xU8wfxdIwXipQIg1Y2srSZgyd/6ulAqyy5jY55KJ51f
 5vhXayLnHqnHARAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 832BE13A79;
 Thu,  1 Sep 2022 11:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hFHHHPaREGOqewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 11:05:26 +0000
Date: Thu, 1 Sep 2022 13:05:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YxCR7+dkGxPvCQDn@pevik>
References: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] README: Add missing configure in openposix step
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

[ Cc Joerg ]

> Since 8071ba7("openposix: Setup autoconf and fix installation layout")
> , we need to use configure firstly.

nit: there should be Fixes: below:
Fixes: 8071ba7 ("openposix: Setup autoconf and fix installation layout")

Then you can use just 8071ba7 in the text.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  README.md | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/README.md b/README.md
> index d45d1ee44..d0ca5f4d4 100644
> --- a/README.md
> +++ b/README.md
> @@ -79,11 +79,13 @@ $ cd ../commands/foo
>  $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
>  ```

> -Open Posix Testsuite has it's own build system which needs Makefiles to be
> -generated first, then compilation should work in subdirectories as well.
> +Open Posix Testsuite has it's own configure and build system which needs
> +Makefiles to be generated first, then compilation should work in subdirectories
> +as well.

>  ```
>  $ cd testcases/open_posix_testsuite/

You miss:
$ make autotools
as this creates configure

> +$ ./configure
But if you run make autotools && ./configure in the top level, none of these two
is needed to be run in open posix directory. Maybe document it (not sure about
the comments)?

$ [ -f ./configure ] || make autotools # not needed if run in the top level
$ [ -f include/mk/config.mk ] || ./configure # not needed if the top level configure is run

Kind regards,
Petr

>  $ make generate-makefiles
>  $ cd conformance/interfaces/foo
>  $ make

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
