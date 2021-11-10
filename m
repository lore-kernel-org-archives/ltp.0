Return-Path: <SRS0=1g5g=P5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98692C433F5
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C63611BF
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 11:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13C63611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE0343C0E9F
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 12:05:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993F93C0732
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 12:05:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CCE760102D
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 12:05:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4CC71FD6C;
 Wed, 10 Nov 2021 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636542314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rXUzq+YwWPuTpop2fmNjtsSru6YCap9VukqTjHS54o=;
 b=CETKUDHmJeqFJjwOgYm/NzH0GQKghyMyDqaIr6UlI9qG9hvwnBVZe3HvpFmOGlemh/8FgW
 EDgFy5P4IDAXkn0Ca5jqxGxwb/n0rXl92x16gtM4bOwkCBB2kREmWKbiYJsfV+bXzKiqXy
 zZl680KkIYEXKX5K36XVvcFqa2qsv+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636542314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rXUzq+YwWPuTpop2fmNjtsSru6YCap9VukqTjHS54o=;
 b=9R29eWSqT4fCvfw1T79bysZ3jI+w8jVwblIcdiAIX6CoTATwNzmzbGAq7YvMIXmr5RCVd6
 vbxKG63L10BJ9FCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B04AB13BAC;
 Wed, 10 Nov 2021 11:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6TQDK2qni2EqTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Nov 2021 11:05:14 +0000
Date: Wed, 10 Nov 2021 12:06:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: tangmeng <tangmeng@uniontech.com>
Message-ID: <YYunqaGXPcPfPvNc@yuki>
References: <20211109085745.21531-1-tangmeng@uniontech.com>
 <20211109085745.21531-2-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211109085745.21531-2-tangmeng@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] getuid/getuid03: Convert to new API
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
> +static void verify_getuid(void)
>  {
>  	struct passwd *pwent;
> -	int lc;
>  	uid_t uid;
> 
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	TEST(GETUID());
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "getuid failed");
> 
> -		tst_count = 0;
> +	uid = getuid();

We have the return from getuid() stored in TST_RET at this point, why do
we call it again here?

> +	pwent = getpwuid(uid);
> 
> -		TEST(GETUID(cleanup));
> +	if (pwent == NULL)
> +		tst_res(TFAIL | TERRNO, "getpwuid failed");

I guess that we should exit the test here, otherwise it will segfault,
so this should be tst_brk(TBROK | TERRNO, ...);

Also I do wonder if comparing the return from getuid() to the return
from getpwuid(getguid()) makes any sense. We lookup password entry given
an uid then check that the password entry uid matches. That sounds like
a test for getpwuid() more than anything else.

I wonder what would be better check. We should rather than this check
the return value against the /proc/self/status where all the UIDs are
listed as well.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
