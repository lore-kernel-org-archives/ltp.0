Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D845C43334
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 06:24:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58833CA0EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 08:24:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D2473C87EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:24:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C43521400061
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:24:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 17D772241E;
 Tue,  5 Jul 2022 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657002243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j6O5CFxsz750EFX5XJoWGPh+0emeRXYXGYQHETTy5fo=;
 b=NfmJDI3TJOpmgnosU3p7sN09k4Ivk8w+M89gMSKXROlRpyV+zq519HRUgQfoNP0P8A3L3v
 36x+kEYhlGi7JW4FmpknlJigqJed7+nRzhu4s+4hDfHyjdR+RHPq97xG+mON8DZe7W2kTX
 Vp7COOL5BI4iULjpEHum2zQ4PRhCj/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657002243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j6O5CFxsz750EFX5XJoWGPh+0emeRXYXGYQHETTy5fo=;
 b=6JXZI1Xd1ONRQs4LooFjFxH+VGjZcaWQB2rFj96KhJeyz5QCIbeR2Xo+Evw8qOoedtDozs
 F8wFgoN4mQOlrEDw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C20D62C141;
 Tue,  5 Jul 2022 06:24:02 +0000 (UTC)
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-4-lkml@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 05 Jul 2022 07:22:20 +0100
In-reply-to: <20220627125321.1560677-4-lkml@jv-coder.de>
Message-ID: <878rp8rsal.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] configure: Integrate open posix testsuite
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox.de>
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
> ---
>  configure.ac           | 11 +++++++++++
>  include/mk/automake.mk |  7 ++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 69b145b5f..5ac23421c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -334,8 +334,19 @@ AC_ARG_WITH([open-posix-testsuite],
>    [with_open_posix_testsuite=$withval],
>    [with_open_posix_testsuite=no]
>  )
> +
> +# Allow setting the directoy, where the open posix testsuite is
> installed to.

This should be the help string for this option

> +# If nothing is defined, we have to pass our default value to submake
> +AC_ARG_WITH([open-posix-testdir],
> +  [AS_HELP_STRING([--with-open-posix-testdir=<dir>],
> +    [compile and install the open posix testsuite])],

This is the  help string for --with-open-posix-testsuite

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
>  
>  AUTOCONFED_SUBDIRS	= \
> -			testcases/realtime
> +			testcases/realtime \
> +			testcases/open_posix_testsuite
>  
>  # We want to run this every single time to ensure that all of the prereq files
>  # are there.
> @@ -35,6 +36,10 @@ AUTOCONFED_SUBDIRS	= \
>  testcases/realtime/configure:
>  	$(MAKE) -C $(@D) autotools
>  
> +.PHONY: testcases/open_posix_testsuite/configure
> +testcases/open_posix_testsuite/configure:
> +	$(MAKE) -C $(@D) autotools
> +
>  .PHONY: autotools
>  autotools: aclocal autoconf autoheader automake $(addsuffix /configure,$(AUTOCONFED_SUBDIRS))
>  
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
