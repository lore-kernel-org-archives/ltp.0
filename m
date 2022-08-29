Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE5FECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 05:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFC423CA50C
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 07:49:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC553C6817
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 07:49:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 186301A00706
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 07:49:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C2CB222E1;
 Mon, 29 Aug 2022 05:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661752173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SEGh/KhAz2ehFvBTJh8dlCqMVNRSjt6B3m6WexGBx8=;
 b=0ZCl2ctnXWzF2GgUpmjaMa7s5KVZ07+iASwH8eUeN/U9FIZm9qF8+bUhjzIjDq9k1Y1JWs
 tDeE9f+pQl7I8D181JkTnRYsAAun20KPekF4FWcnKnSt8rrmsRKYtHT4+rwDQL8ZrA7kDC
 NNMyxy2FXlBsRZTk37dnJhuQnZ2BWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661752173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SEGh/KhAz2ehFvBTJh8dlCqMVNRSjt6B3m6WexGBx8=;
 b=kPzMz9CZ037xVwPLEblPChNnV+7+l5/uDnNx88MLuI5xnQcZrUozgwSbaJKDULBjO6OO2T
 QUzYLlw8CVQKd4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFE25133A6;
 Mon, 29 Aug 2022 05:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eK/AOGxTDGMiSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 05:49:32 +0000
Date: Mon, 29 Aug 2022 07:49:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YwxTawqy36p3RU2j@pevik>
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-3-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220727053307.3009235-3-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] openposix: Setup autoconf and fix
 installation layout
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

Hi Joerg,

[ Cc Li ]

> This allows installation of the tests to a different directory
> than directly under $prefix.

> Before the layout was:
> $prefix/bin/{run-*,t0,run-tests.h,Makefile}
> $prefix/conformance
> $prefix/functional
> $prefix/stress

> with prefix being /opt/openposix_testsuite on linux and
> /usr/local/openposix_testsuite on other systems
> OR the value of the env-var $prefix.

> With this change, the prefix defaults to /opt/openposix_testsuite
> and can be changed the usual way using configure (./configure ---prefix=foo)
> Additionally the path of the tests below $prefix can be changed, using
> configure --with-open-posix-testdir=<foo>. This allows clean installation as
> part of ltp:

> $prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
> $prefix/$testdir/bin/{run-tests.sh,t0}
> $prefix/$testdir/conformance
> $prefix/$testdir/functional
> $prefix/$testdir/stress

> Only the two directly callable shell scripts are kept under $prefix/bin,
> the two other executables are moved to testdir, because they are only
> used by the implementation of the test execution scripts (run.sh)
> $prefix/bin/Makefile is not installed anymore, because it is not required.

It took me a while to do a bit of testing.
Whole improvements LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/open_posix_testsuite/bin/Makefile
> @@ -4,18 +4,32 @@
>  # Ngie Cooper, July 2010


> -top_srcdir?=		..
> +top_srcdir ?= ..

> -srcdir=			$(top_srcdir)/bin
> +include $(top_srcdir)/include/mk/config.mk

> -prefix?=		`$(top_srcdir)/scripts/print-prefix.sh`
> -
> -bindir?=		$(prefix)/bin
> +INSTALL_BIN_TARGETS = run-all-posix-option-group-tests.sh run-posix-option-group-test.sh
> +INSTALL_TESTCASE_BIN_TARGETS = run-tests.sh t0

> +.PHONY: clean
>  clean:
>  	@rm -f t0.val

> -install: clean
> -	@set -e; for i in `ls *`; do \
> -	    install -m 0755 $$i $(DESTDIR)/$(bindir)/. ;\
> +.PHONY: install
> +install: clean $(DESTDIR)/$(bindir) $(DESTDIR)/$(testdir_bin)
> +	set -e; for file in $(INSTALL_BIN_TARGETS); do           \
> +		install -m 00755 $$file $(DESTDIR)/$(bindir)/$$file; \
> +	done
> +
> +	sed -i 's~TESTPATH=""~TESTPATH="$(testdir_rel)"~' $(DESTDIR)/$(bindir)/run-posix-option-group-test.sh
nit: TESTPATH="" below could be just TESTPATH=. Obviously sed here would need to
be adjusted.
> +
> +	set -e; for file in $(INSTALL_TESTCASE_BIN_TARGETS); do	      \
> +		install -m 00755 $$file $(DESTDIR)/$(testdir_bin)/$$file; \
>  	done
> +
> +
> +$(DESTDIR)/$(bindir):
> +	mkdir -p $@
> +
> +$(DESTDIR)/$(testdir_bin):
> +	mkdir -p $@
> diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> index 1bbdddfd5..e90c252a3 100755
> --- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> +++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
> @@ -8,7 +8,9 @@

>  # Use to build and run tests for a specific area

> -BASEDIR="$(dirname "$0")/../conformance/interfaces"
> +TESTPATH=""
> +
> +BASEDIR="$(dirname "$0")/../${TESTPATH}/conformance/interfaces"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
