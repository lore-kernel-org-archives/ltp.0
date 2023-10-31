Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC6C4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 15:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 031883CF391
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:31:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61E233CC971
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:31:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 95D8B60108F
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:31:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4644C21AF7;
 Tue, 31 Oct 2023 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698766288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z2JutqgR15BZg1qahNbfajpUD/+4emyK9uBjtUppFfM=;
 b=MlbLpvzyO/XpFGmPSU5GUUSllmh4zQfBoyXZdBGEqqGhSZrVxMsACebBGxo76ffeZDOKUG
 WM7DTCSE+RwREQgr0szTs2W1bziIO9dPLEj3dF7bY2jB4JB7wgkwd+rOGJLbtoMKdu3Err
 iAJyiU1nSrfj32haiQdLVPjP0hEs7dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698766288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z2JutqgR15BZg1qahNbfajpUD/+4emyK9uBjtUppFfM=;
 b=lexEeiLv1icYn+MlkUMVsOdguTPe7Zsz9NxcKFNz3fxjM1DwIViVD/dfUy1tlgaTa3IDzg
 FaJwT9S32C3fbwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E86981391B;
 Tue, 31 Oct 2023 15:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bNX3Ns8dQWW/NQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 31 Oct 2023 15:31:27 +0000
Date: Tue, 31 Oct 2023 16:31:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZUEd79N7aiC_VCDO@yuki>
References: <87pm2yffmx.fsf@suse.de>
 <20230905160143.1076-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230905160143.1076-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mmap15: Rewrite test using new LTP API
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
> +	if (TST_RET_PTR != MAP_FAILED) {
> +		tst_res(TFAIL, "mmap() into high mem region succeeded unexpectedly");
> +		SAFE_MUNMAP(TST_RET_PTR, page_size);
> +		return;
> +	} else if (TST_RET_PTR == MAP_FAILED && (TST_ERR == ENOMEM || TST_ERR == EINVAL)) {

There is no reason for an else branch if we do return in the previous
one.

Also we do return so TST_RET_PTR is always MAP_FAILED here, no need to
test it again.

> +		tst_res(TPASS | TERRNO, "mmap() failed with expected errno");
> +	} else {
> +		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected errno");
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	SAFE_CLOSE(fd);
>  }
>  
>  static void setup(void)
>  {
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
>  	page_size = getpagesize();
> -
> -	TEST_PAUSE;
>  }
>  
>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_root = 1,

Do we really need root?

> +	.needs_tmpdir = 1
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
