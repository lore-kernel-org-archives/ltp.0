Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FE8ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 16:43:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB13E3CA5BF
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 18:43:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40233CA487
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:42:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C99F42009AB
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:42:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BEDC22779;
 Mon, 29 Aug 2022 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661791369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJ+AiU6hPWr2T6bFu0tugCPiNjBsHaVLDYa4tqH+YCc=;
 b=rbGTcPa5In9RLmRSJdCzcrZYKR0vFEcDyK8p2GZcsTnYUY+7jercuOdE1O3JPKTGmM7OwX
 C5MxLfxiYnzd2NJ74yClwnJhygqYyN0IBwQfwOKqBhqlNs/HMrwocGC2uTzQnl54syKiJl
 Wleknhp+Pr7dv2Hpd9Hdf3KI7+K2st4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661791369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJ+AiU6hPWr2T6bFu0tugCPiNjBsHaVLDYa4tqH+YCc=;
 b=3yMDTv7dn6ryoRsfVWLZJJLj44pCSWbKL38CCcmQ7pBgyhbjIPoiMg2suW8D0Dm2V+0F0L
 AXZmgeg+IhVwFnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E66421352A;
 Mon, 29 Aug 2022 16:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UzsmNojsDGP1JgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 16:42:48 +0000
Date: Mon, 29 Aug 2022 18:42:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YwzshytEfks104tc@pevik>
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-4-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727053307.3009235-4-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] configure: Integrate open posix testsuite
 configure
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Joerg, all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

[ Cc: automated-testing@lists.yoctoproject.org ]
Please have look at open posix testsuite patchset:
https://patchwork.ozlabs.org/project/ltp/list/?series=311446&state=*
https://lore.kernel.org/ltp/20220727053307.3009235-1-lkml@jv-coder.de/

First commit has been merged and I plan to merge the other two sometimes this
week.

Kind regards,
Petr

> From: Joerg Vehlow <joerg.vehlow@aox.de>

> This changes the default installation location
> of the open posix testsuite from
> $prefix
> to
> $prefix/testcases/open_posix_testsuite

> Scripts for execution of the testsuite (run-all-posix-option-group-tests.sh,
> run-posix-option-group-test.sh) will still be installed under $prefix/bin.

> To revert back to the old installation behavior, just use
> ./configure -with-open-posix-testdir=.

> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
> ---
>  configure.ac           | 11 +++++++++++
>  include/mk/automake.mk |  7 ++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

> diff --git a/configure.ac b/configure.ac
> index 69b145b5f..4256b3113 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -334,8 +334,19 @@ AC_ARG_WITH([open-posix-testsuite],
>    [with_open_posix_testsuite=$withval],
>    [with_open_posix_testsuite=no]
>  )
> +
> +# Allow setting the directoy, where the open posix testsuite is installed to.
> +# If nothing is defined, we have to pass our default value to submake
> +AC_ARG_WITH([open-posix-testdir],
> +  [AS_HELP_STRING([--with-open-posix-testdir=<dir>],
> +    [set the directory, where the open posix testsuite will be installed under prefix])],
> +  [],
> +  [ac_configure_args="$ac_configure_args --with-open-posix-testdir=testcases/open_posix_testsuite"]
> +)
> +
>  if test "x$with_open_posix_testsuite" = xyes; then
>      AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["yes"])
> +    AC_CONFIG_SUBDIRS([testcases/open_posix_testsuite])
>  else
>      AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["no"])
>  fi
> diff --git a/include/mk/automake.mk b/include/mk/automake.mk
> index 219d015d0..ee3b7f1b8 100644
> --- a/include/mk/automake.mk
> +++ b/include/mk/automake.mk
> @@ -27,7 +27,8 @@ AUTOHEADER	?= autoheader
>  AUTOMAKE	?= automake

>  AUTOCONFED_SUBDIRS	= \
> -			testcases/realtime
> +			testcases/realtime \
> +			testcases/open_posix_testsuite

>  # We want to run this every single time to ensure that all of the prereq files
>  # are there.
> @@ -35,6 +36,10 @@ AUTOCONFED_SUBDIRS	= \
>  testcases/realtime/configure:
>  	$(MAKE) -C $(@D) autotools

> +.PHONY: testcases/open_posix_testsuite/configure
> +testcases/open_posix_testsuite/configure:
> +	$(MAKE) -C $(@D) autotools
> +
>  .PHONY: autotools
>  autotools: aclocal autoconf autoheader automake $(addsuffix /configure,$(AUTOCONFED_SUBDIRS))

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
