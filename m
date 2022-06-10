Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBB7C43334
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 13:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09CF33C925A
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 15:34:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A2103C0162
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 15:33:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87519200D53
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 15:33:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC29322034;
 Fri, 10 Jun 2022 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654868022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Yx/g7GHMJDgjD1mP/ean0wj14uUiXpQFomLXlFp9Q=;
 b=faCAUdFS18c6XFpq2hY+9Pbk839/vqo1rBu/sryRfj7S7qSbJxnQ6lRqWFshrqVsVrtJAH
 nuKuqsixnqbBUsIXKvdrD8wso0QAw0t0Tf8B0qQOwiVD2xdDHh1iYRwy8/2vODbBdPoc2G
 bv8t4hG4Rt4UZVMbc2OppEgPZfhQAao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654868022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Yx/g7GHMJDgjD1mP/ean0wj14uUiXpQFomLXlFp9Q=;
 b=ix0UA4lGbAOV4DmnuTpFXeG8DzkcFoRH5AcnxVJGilT3cXNhYuMxzwiB2NrDcczKvhD6se
 6GmPIx6wTnRPKIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA5B513AF8;
 Fri, 10 Jun 2022 13:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JYo6MDZIo2J7TAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jun 2022 13:33:42 +0000
Date: Fri, 10 Jun 2022 15:33:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YqNIIb/NFVBjsZdb@rei>
References: <20220610131442.5032-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610131442.5032-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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
> Some toolchains don't fully support the KVM linker scripts. Disable KVM tests
> if linker check fails in configure script.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  configure.ac              | 14 ++++++++++++++
>  include/mk/features.mk.in |  3 +++
>  testcases/kernel/Makefile |  5 ++++-
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 816ebf820..88ecbafda 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -397,6 +397,20 @@ LTP_CHECK_TASKSTATS
>  test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
>  LTP_DETECT_HOST_CPU
>  
> +AC_MSG_CHECKING([whether linker can handle KVM payloads])
> +ltp_backup_ldflags=$LDFLAGS
> +LDFLAGS="$LDFLAGS -T ${srcdir}/testcases/kernel/kvm/linker/${HOST_CPU}.lds"
> +AC_LINK_IFELSE([AC_LANG_PROGRAM()],
> +  [
> +    AC_MSG_RESULT([yes])
> +    AC_SUBST([WITH_KVM_TESTSUITE],["yes"])
> +  ],
> +  [
> +    AC_MSG_RESULT([no])
> +    AC_SUBST([WITH_KVM_TESTSUITE],["no"])
> +  ])
> +LDFLAGS="$ltp_backup_ldflags"
> +
>  AC_OUTPUT
>  
>  cat << EOF
> diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
> index ecb15a0f7..802ee0ba8 100644
> --- a/include/mk/features.mk.in
> +++ b/include/mk/features.mk.in
> @@ -52,3 +52,6 @@ WITH_REALTIME_TESTSUITE		:= no
>  else
>  WITH_REALTIME_TESTSUITE		:= @WITH_REALTIME_TESTSUITE@
>  endif
> +
> +# Enable testcases/kernel/kvm compile and install?
> +WITH_KVM_TESTSUITE		:= @WITH_KVM_TESTSUITE@
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index c0fa24147..bf890e175 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -29,7 +29,6 @@ SUBDIRS			+= connectors \
>  			   io \
>  			   ipc \
>  			   irq \
> -			   kvm \
>  			   logging \
>  			   mem \
>  			   numa \
> @@ -45,6 +44,10 @@ ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
>  SUBDIRS			+= power_management
>  endif
>  
> +ifeq ($(WITH_KVM_TESTSUITE),yes)
> +SUBDIRS			+= kvm
> +endif

Skipping the whole directory will actually cause problems too, since the
runltp files does include the kvm_pagefault01 now which will obvious
fail because the binary would be missing.

I'm not sure what the best solution would be, maybe install dummy
libraries that just print TCONF in a case that linker does now work?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
