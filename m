Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626EAC43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:47:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EF3F3C9411
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 11:47:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A43153C2806
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:47:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5EF8600063
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 11:47:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BBBC21E79;
 Tue, 21 Jun 2022 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655804839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/SIHnjpCDtNGNXZVBNjid/NxszdW+bzMjsydS76j0=;
 b=rV5EPzeVv6EjAQmwQjLeDbd8F8DcVdUNuoT1FfDJ4fUwd44mFiwySiiM/CZO0WabSJs4dB
 J2xmhraGgt127jPeebEbAuDWJlUg9mI+4vBV7ZdQy+RpC4OkaZTWOCQwQKX6hshoKEdktP
 CC70YbCLPx0yQ+T1w9zB49jQCL0Osl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655804839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/SIHnjpCDtNGNXZVBNjid/NxszdW+bzMjsydS76j0=;
 b=D0O16PhsPl75o43fg4F+Qq9nNpQZh2obA2/NDwcULhAca83Py2mGXuKo4e1Ttrj+lkHXfU
 tANcPlWtwWl5Y6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDCBE13638;
 Tue, 21 Jun 2022 09:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4HSGOaaTsWL5MgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jun 2022 09:47:18 +0000
Date: Tue, 21 Jun 2022 11:49:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YrGUJmmVzhFJhlcX@yuki>
References: <2873e7f25ac44d2c103a030bfc5f1d30e0fe80a9.1655795105.git.jstancek@redhat.com>
 <6616c11cdf55d2fd89f6f3c8f9ab1a8c1a3916e7.1655800610.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6616c11cdf55d2fd89f6f3c8f9ab1a8c1a3916e7.1655800610.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/migrate_pages03: restore runtime to 5m
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
> Arches with large pages have trouble completing all loops in 30s,
> restore runtime to 5m. Also check for remaining runtime and
> exit if we run out.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> index c6afb4cce05d..2866c96e6b8d 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> @@ -127,6 +127,11 @@ static void migrate_test(void)
>  			tst_res(TFAIL | TERRNO, "migrate_pages() failed");
>  			return;
>  		}
> +
> +		if (!tst_remaining_runtime()) {
> +			tst_res(TINFO, "Out of runtime, exitting...");
                                                            ^
							    Just one
							    't' here

Sorry I tend to make this typo quite often.

With that fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
