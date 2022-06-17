Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6118C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 09:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656163C8D01
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 11:11:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51B583C4F81
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 11:11:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B41806008C9
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 11:10:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2CD121D37;
 Fri, 17 Jun 2022 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655457058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gcVc3eGcXkuLqMvfz1kmPEFbczCcmqTflHTOA321w4=;
 b=CzGzNnkkBKUrum6yZU3KnJn4DGDzdHKPBxAAnE0Ufob1dVQLFiI5NMKTZkudK66FSDX/9K
 HjpXtLQC0jIP/nzDPBkJfj1BsYYQHoR6rTImfsMmTAC9JcRUAn/xgDkqF5AZV/Zg+pMFfQ
 bU+Sx5XPxbaVk08upwoUwnFZdt44Zv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655457058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gcVc3eGcXkuLqMvfz1kmPEFbczCcmqTflHTOA321w4=;
 b=WE/2hE0hhvKqz2ZIHbeNyPnqLJubgr6vIgrX39RYYzh+/GCYpY6xvuYrfj2ZlgShW+kOa2
 gRmX6qcLewE8WFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 712F213458;
 Fri, 17 Jun 2022 09:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fmj3FiJFrGL9KAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 09:10:58 +0000
Date: Fri, 17 Jun 2022 11:13:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YqxFo1iFzHatNRIl@yuki>
References: <20220616162339.19322-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616162339.19322-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] nfs05_make_tree: Restore 5 min
 timeout
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
> nfs05_make_tree is a long running test. The previous default timeout 5
> min was enough after reducing runtime in 05be61cf6.
> 
> But the new default 30 sec introduced in the concept of max runtime is
> definitely not enough. Restore the previous timeout 5 min.

Looking at the code this is actually a helper binary rather than a test
itself. I think that the problem here is that we mix the shell test
library and C library and the test is a mess of both with unexpected
consequencies.

I guess that it would probably implement main() in the nfs05_make_tree.c
instead as we do for the various tools in testcases/lib/*.c. That would
at least make sure that we will not break anything with changes intended
for tests and not for helper binaries as this one.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs05_make_tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> index fdc13bd5d..5456c1bf0 100644
> --- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> +++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> @@ -215,4 +215,5 @@ static struct tst_test test = {
>  	.options = opts,
>  	.test_all = do_test,
>  	.setup = setup,
> +	.max_runtime = 300,
>  };
> -- 
> 2.36.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
