Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C5C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 20:21:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251956115A
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 20:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 251956115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF9B3C8F07
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 22:21:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5ECE3C32E8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 22:21:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BADA91A01475
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 22:21:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42813223D3;
 Thu,  9 Sep 2021 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631218885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fuYouy3hEzLqGWJfS9AOiV8MYNHcOhi/rAyzUcI9JbM=;
 b=3YZOh/qepCpnjm6uX+nM7KV2XQYUPpL8L+2R8mkaCOvRScZfCQuv19C5ScmQbWnTUhsgO1
 oPw2IlfR0WQ7mJTR9SOROjmbp3VPqeYe1PPntboNomz83nClsRoqWW+V8gRbv92DWBedyH
 ct3flpQ062oPAR9bx5lZi1JTvgcXqxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631218885;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fuYouy3hEzLqGWJfS9AOiV8MYNHcOhi/rAyzUcI9JbM=;
 b=+THbq2XpAILrnshImNeJD7K+Z2CYnamlfxoBs3OY2tHGWOeWRgl+t7wnQ3MMF8l0qw7aQN
 sycEf/WWGeq0x/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE4C913B29;
 Thu,  9 Sep 2021 20:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ji+xL8RsOmGBUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Sep 2021 20:21:24 +0000
Date: Thu, 9 Sep 2021 22:21:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YTpswsqlDS5tI7NC@pevik>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909165111.51038-2-alexh@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909202122.tFpfe7AJyCucyTdydFgEutS68k6sSKt0A-e6-W7yxms@z>

Hi Alex,

> Requires "ima: add gid support".
I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
versions. Thus there should be some check to prevent old kernels failing.
You could certainly wrap new things with if tst_kvcmp. If there is a chance new
functionality can be detected, we prefer it because various features are
sometimes backported to enterprise distros' kernels.

Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
although for IMA tests I usually kept everything in a single file.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -8,6 +8,7 @@

>  TST_NEEDS_CMDS="awk cut sed"
You should add sudo:

TST_NEEDS_CMDS="awk cut sed sudo"
>  TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
>  TST_CNT=3
>  TST_NEEDS_DEVICE=1

> @@ -20,6 +21,13 @@ setup()
>  	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> +
> +	cat $IMA_POLICY > policy-original
This might not work if CONFIG_IMA_READ_POLICY is not set. There is
check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

> +}
> +
> +cleanup()
> +{
> +	cat policy-original > $IMA_POLICY
Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
And this is very likely not to be set.

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
