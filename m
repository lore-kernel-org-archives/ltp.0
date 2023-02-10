Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C663EC636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 10:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42C13CC06F
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 11:47:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7867C3C2461
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 11:47:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8373D60150D
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 11:47:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2EF3FEC6;
 Fri, 10 Feb 2023 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676026063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fOppjXGt+PgFUIZlrofWIPUanuu8QpSls/GvPml/10=;
 b=VyPMTaaaJeSO8cZwEGd/p7RGcg1gAhUkPUDbT7CZ+89VnwjqcXZaXD6Hy69VOsf9nUFVUk
 sk0OgXjcSedOZ5+oTt71s3BaBN4xTL6urOEtkjxSqJIKMAQIffmRSiQxL2cxf4TdeQcJ0f
 CpugGDsuXhCWd5cAZx8jCNtI6vvbVkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676026063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fOppjXGt+PgFUIZlrofWIPUanuu8QpSls/GvPml/10=;
 b=Sy2C7SxVkwQoPioihc7KuEboaFSqIzr7zHeUkgyLStdJK+AMAoxnuaBx0Fh7yGaEfOI4Bc
 u6NWiY8r9EDkQ7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5855D1325E;
 Fri, 10 Feb 2023 10:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OfUJFM8g5mNqVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Feb 2023 10:47:43 +0000
Date: Fri, 10 Feb 2023 11:46:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiaoshoukui <xiaoshoukui@gmail.com>
Message-ID: <Y+YglzySGK8ts8y3@rei>
References: <20230210084408.8360-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230210084408.8360-1-xiaoshoukui@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS
 lock imbalance
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
> +static void verify_ioctl_loop(void)
> +{
> +	struct tcase *tc = &tcases[0];
> +	pthread_t th1, th2;
> +
> +	pthread_create(&th1, NULL, ioctl_thread, tc);
> +	usleep(500000);
> +	pthread_create(&th2, NULL, ioctl_thread, tc + 1);
> +	usleep(500000);

This part looks strange, why do we run the code that calls the ioctl in
a separate thread if we are sleeping after the thread has been created
and quite likely the thread will finish before the main thread returns
from the sleep?

Why can we just call the ioctl_thread() sequentially here?

> +	if (!find_kmsg(lock_imbalance))
> +		tst_res(TFAIL, "Trigger lock imbalance");
> +	else
> +		tst_res(TPASS, "Nothing bad happened, probably");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_ioctl_loop,
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +					    "CONFIG_LOCKDEP=y",
> +					    NULL },
> +	.tags = (const struct tst_tag[]) {
> +					  { "linux-git", "bdac616db9bb "},
> +					  {}
> +					   },
> +	.needs_drivers = (const char *const[]) {
> +						"loop",
> +						NULL }

The whitespaces here are all messed up.

> +};
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
