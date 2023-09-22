Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50476C04AAB
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 12:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 492C13CDE8A
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 14:13:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 592E93CDE37
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:13:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E7EB100B79D
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:13:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1B522190B;
 Fri, 22 Sep 2023 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695384786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++zfTZbeZTU/7XNZcwTaWeO/C/ejIBw1iuXxgsqxtuY=;
 b=PeZ1BMgRIXKxDW/cuohgXdNxfIVXPWJ/v667R2x4y6t+M0l6VfmJFfvRnu4KahlNdvRSm5
 VtoPRuP7Tf6ASw8Q9U+Q3CXTRxPIq6Xe5+zJcbR5rUhO7TW4ywC7kHloQ8zHZ6YZ9kGOmi
 E+akMuUaqX1lq2Vcjkn0UwSOzYaw/j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695384786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++zfTZbeZTU/7XNZcwTaWeO/C/ejIBw1iuXxgsqxtuY=;
 b=vbNfbbsUv2tvpLuI7qAfEEWwffy14vLviK4FHhOGe3xy4CsX3FqK0o5dX7Az0I2IBFdkiS
 T6LObhlUUXkm1YBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA19B13478;
 Fri, 22 Sep 2023 12:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f0FrM9GEDWXvNQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 12:13:05 +0000
Date: Fri, 22 Sep 2023 14:13:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZQ2E_pKz2QSG61LY@yuki>
References: <20230920153145.30891-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920153145.30891-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns05: Use tst_getpid()
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
> --- a/testcases/kernel/containers/pidns/pidns05.c
> +++ b/testcases/kernel/containers/pidns/pidns05.c
> @@ -28,7 +28,7 @@ static void child_func(int *level)
>  {
>  	pid_t cpid, ppid;
>  
> -	cpid = getpid();
> +	cpid = tst_getpid();
>  	ppid = getppid();
>  
>  	TST_EXP_EQ_LI(cpid, 1);
> @@ -55,7 +55,7 @@ static int find_cinit_pids(pid_t *pids)
>  	int next = 0;
>  	pid_t parentpid, pgid, pgid2;
>  
> -	parentpid = getpid();
> +	parentpid = tst_getpid();

I suppose that this one is not strictly required, but it does not harm
to consistently use tst_getpid()


Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
