Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB884C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04A363C9253
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:55:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 764BA3C1482
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:55:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D21DC1A0090C
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:55:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24FFF1F37F;
 Wed,  5 Jan 2022 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641398134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaaNNi5obSS5p4chP9mHJtduiFIV8ES5iFnxKm7OvXc=;
 b=hNzpln05JllfGlLE5F1GZ33coerLa5HWk87nyZ2Es2iGoOjrVPhww9YNu14XJL80sOmFDX
 vjoEEmYrT5LCL6WNVRkewZ/I25HdsgFmr1nimNv91fqe1EE8JNkMl3eszfFoe4gnyBTbYi
 Iz+/ahLJ9RtbeuDU92hIjJQzFzbYKU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641398134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaaNNi5obSS5p4chP9mHJtduiFIV8ES5iFnxKm7OvXc=;
 b=Ds3eO0pQbmZDrq1qK4QS1sCE1rZTs/eANJS7SdpHVmx7MSkkZKvvdxs3tj5RnRHHRspEg3
 mdUbY6C0xcQlPrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0501B13BF1;
 Wed,  5 Jan 2022 15:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZDuIO3W/1WFKegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jan 2022 15:55:33 +0000
Date: Wed, 5 Jan 2022 16:57:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YdW/0BUm+vBY3PHy@yuki>
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221113042.21357-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
> Add an unstable kernel ABI flag and a runtest file for unstable
> tests. This means we can add tests which are likely to be broken by
> changes in the kernel ABI. Without disrupting LTP releases which are
> required to be stable.
> 
> Users who require stability can filter the tests with this flag
> or not schedule the unstable runtest file(s).
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> How about adding this to the fanotify22 patch?
> 
>  include/tst_test.h        | 12 ++++++++++++
>  lib/tst_test.c            |  6 ++++++
>  runtest/syscalls-unstable |  3 +++
>  3 files changed, 21 insertions(+)
>  create mode 100644 runtest/syscalls-unstable
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 450ddf086..ff31e972e 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -174,6 +174,18 @@ struct tst_test {
>  	int skip_in_lockdown:1;
>  	int skip_in_compat:1;
>  
> +	/*
> +	 * Test is for a feature that has not been added to the stable
> +	 * kernel ABI. That is, it's for a feature only available in
> +	 * linux-next, an RC or some other development branch.
> +	 *
> +	 * This string should be set to some text describing the
> +	 * kernel branch and version the test was developed
> +	 * against. e.g. "5.16 RC2", "linux-next-20211220",
> +	 * "net-next".
> +	 */
> +	const char *const unstable_abi_version;

I would rather call this 'remove_after_release' or 'remove_after_kernel_release' but that is very minor.

>  	/*
>  	 * The skip_filesystem is a NULL terminated list of filesystems the
>  	 * test does not support. It can also be used to disable whole class of
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 9b51bb5be..babb250d0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1013,6 +1013,12 @@ static void do_setup(int argc, char *argv[])
>  	if (!tst_test)
>  		tst_brk(TBROK, "No tests to run");
>  
> +	if (tst_test->unstable_abi_version) {
> +		tst_res(TINFO,
> +			"This test was developed against pre-release kernel: %s",
> +			tst_test->unstable_abi_version);
> +	}
> +
>  	if (tst_test->tconf_msg)
>  		tst_brk(TCONF, "%s", tst_test->tconf_msg);
>  
> diff --git a/runtest/syscalls-unstable b/runtest/syscalls-unstable
> new file mode 100644
> index 000000000..a87284afe
> --- /dev/null
> +++ b/runtest/syscalls-unstable
> @@ -0,0 +1,3 @@
> +# Tests for kernel features which are not finalized
> +
> +fanotify22 fanotify22

I would be even tempted to add this to the default syscalls runtest file
but render the test resultless, e.g. replace the tst_res() and tst_brk()
handlers in tst_res.c so that it will print only INFO messages.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
