Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F29C19F2A
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 17:24:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35ACD3C8C6C
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 19:23:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00B773C0282
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 19:23:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72583601472
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 19:23:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDD1F5BDCD;
 Fri, 29 Jul 2022 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659115421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1X59ZQqLOqEA/iXhhdM3S93H7JnaJtmi7MsBVbTMwDA=;
 b=I6YhCopQGh6HN3gOnAccRbOYZ+pgRq+febi8FLFdNPS/S+hS5N2O+IJ3GOLE77/kCDyeBm
 uCPRs4pU5+blYjcSVSLatC+izFQukgNWP56S1/807lbRsx6fYDo81TItl35ZFs1INq35+P
 YsEn/US/0+C3ICmZnqG2j/FDJ/3g+ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659115421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1X59ZQqLOqEA/iXhhdM3S93H7JnaJtmi7MsBVbTMwDA=;
 b=LwYrxDlasH7Cdm067D1Iw1HuFadC1cbJvsF06U94aqAjS1u3klhSn5O4Dg8r3QDriqcYTD
 f0QokpCIXfAORZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7300C13A1B;
 Fri, 29 Jul 2022 17:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K5hhGp0X5GL6IwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 17:23:41 +0000
Date: Fri, 29 Jul 2022 19:23:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YuQXnCgSjBT1mGFH@pevik>
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-4-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727053307.3009235-4-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hi Joerg,

[ Cc automated-testing@lists.yoctoproject.org ]

> From: Joerg Vehlow <joerg.vehlow@aox.de>

> This changes the default installation location
> of the open posix testsuite from
> $prefix
> to
> $prefix/testcases/open_posix_testsuite
I need to have a deeper look on this patchset next week.
But it looks to me strange, that running LTP top level configure causes
installation into /opt/ltp/testcases/open_posix_testsuite/, but after running
./configure in testcases/open_posix_testsuite make install goes by default to
/opt/openposix_testsuite.

Also openposix does not use LTP API, when we're touching it, wouldn't it make
more sense to put it into separate git repository? IMHO that would cause work
for other people (clone separate git, need to fix CI and tools which are using
it), but openposix embedded in LTP always looked strange to me.

Kind regards,
Petr

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
