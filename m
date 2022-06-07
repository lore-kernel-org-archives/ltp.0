Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60F8C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 13:12:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1B7A3C8E78
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 15:12:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07E303C02C2
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 15:12:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5102B100096B
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 15:12:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C020D218B0;
 Tue,  7 Jun 2022 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654607545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0RSqicW03b8Yg4vJcqBR3/m/8k4lyviJ3AF6Lq5Mnc=;
 b=iEamN0v9ZsdEhFn4VuGkMPwEqs+BE4tHph9667CNtf6v10BtCAQH6wTzdMcgAguGqOpqaw
 CfFl68Y1PiAt0S4vMSJsQDEYiO3EEKqTtLxZegrOB4ruSLBHPZWkUK89C4JAQ84L149E0w
 UQ3pXyVGlf+kMfaiHyrl1uMN8lfPNMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654607545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0RSqicW03b8Yg4vJcqBR3/m/8k4lyviJ3AF6Lq5Mnc=;
 b=eGzx4y8N/wElywO/T0AHjOslhLDzwpulgjtkHYvp/ueL5S2CdSNwGTxz7afZI1Fp6g3kcB
 OAYh02+/ALfsyBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A341813A88;
 Tue,  7 Jun 2022 13:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8Xj3JLlOn2KtIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Jun 2022 13:12:25 +0000
Date: Tue, 7 Jun 2022 15:12:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Yp9OpshD7SOkK7QR@rei>
References: <20220607025435.184105-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220607025435.184105-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] futex_waitv01: Add test verifies
 EAGIN/ETIMEDOUT
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
> +static void test_mismatch_between_uaddr_and_val(void)
> +{
> +	struct timespec to;
> +
> +	waitv->uaddr = (uintptr_t)futex;
> +	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +	waitv->val = 1;
> +
> +	init_timeout(&to);
> +
> +	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC), EAGAIN,
> +			"futex_waitv mismatch between value of uaddr and val");

The init_timeout(&to) inits the timeout with CLOCK_REALTIME time, so we
should pass CLOCK_REALTIME to the futex_waitv() as well.
 
> +}
> +
> +static void test_timeout(void)
> +{
> +	struct timespec to;
> +
> +	waitv->uaddr = (uintptr_t)futex;
> +	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +	waitv->val = 0;
> +
> +	init_timeout(&to);

I guess that we can as well just do:

SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &to);

Which would make the test much faster as we will not have to wait for
one second for the timeout.

Eventually we can as well add a few miliseconds to the timeout, we do
have a nice functions to work with different time structures in this
case we can just do:

	to = tst_timespec_add_us(to, 10000);

To add 10ms to the timeout.

> +	TST_EXP_FAIL(futex_waitv(waitv, 1, 0, &to, CLOCK_REALTIME), ETIMEDOUT,
> +			"futex_waitv timeout");
> +
> +}
> +
>  static void cleanup(void)
>  {
>  	free(futex);
> @@ -126,6 +154,8 @@ static void run(void)
>  	test_null_waiters();
>  	test_invalid_clockid();
>  	test_invalid_nr_futexes();
> +	test_mismatch_between_uaddr_and_val();
> +	test_timeout();
>  }
> 
>  static struct tst_test test = {
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
