Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1979AC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 13:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9545D3CA185
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 14:13:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11C243C21FF
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:13:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3AF83200D0C
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:13:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6076621129;
 Mon, 21 Feb 2022 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645449218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8lNq0s0xiCc3WK/HfvqJNA7JiK4WZ2QY3dgAJb+V0c=;
 b=hPh8a+zUYzC2lT8X3tazy/KIAfkR4MIImQZd7r+Sdq6pRihbA4sV8Bs67ohZ/6EWSsK6Eq
 aAgQKXe+VCOHzc7r6b8Vy+MO+MkY8qFkymNoJSBmuBCAGkBBS8YY+Er/pDaooNjC0ZZr5Z
 6a4Po2HLUn3o6bcbPiI7qP1YaMqHaAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645449218;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8lNq0s0xiCc3WK/HfvqJNA7JiK4WZ2QY3dgAJb+V0c=;
 b=ceuc6PStTZ2NBk80b66VRmnudy/tGCzGKS2W71RHisfuSNk+px1UxfWkISD1m0MiQR3zhY
 4OYHedlFEgk6tzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BD7713AF2;
 Mon, 21 Feb 2022 13:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aAu1BAKQE2IrfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 21 Feb 2022 13:13:38 +0000
Date: Mon, 21 Feb 2022 14:13:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YhOQAEHFCeMkrYsE@pevik>
References: <20220218164845.11501-1-pvorel@suse.cz>
 <YhOONDJPpHcX4bZW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhOONDJPpHcX4bZW@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC??[DO_NOT_MERGE][PATCH v2 1/1] netstress: Fix race
 between SETSID() and exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> Uff, I did found the root cause after debugging for a while.
Thanks a lot!

> The network tests rely a lot on passing data between processes by files
> by a local directory and .needs_checkpoints causes the test to run under
> a different directory, that is because checkpoints needs a backing file
> that is mapped into the process memory. And so after setting
> .need_checkpoints the client was storing the file into a different
> directory.

> This should be a minimal fix:

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 047686dc3..891472c8a 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -715,7 +715,7 @@ tst_netload()
>         fi

>         s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
> -       c_opts="${cs_opts}${c_opts}-a $c_num -r $((c_requests / run_cnt)) -d $rfile"
> +       c_opts="${cs_opts}${c_opts}-a $c_num -r $((c_requests / run_cnt)) -d $PWD/$rfile"

>         tst_res_ TINFO "run server 'netstress $s_opts'"
>         tst_res_ TINFO "run client 'netstress -l $c_opts' $run_cnt times"


Yes, this looks like enough. Do you want me to merge this proposal with added
this change? Or you send a patch or just merge fix yourself?

> However the debugging took longer than I wanted to since the network
> tests are such a mess. The server does exit by TBROK (which looks like
> it's an expected behavior), only half of the sever log is printed on a
> failure, etc. These should really deserve some cleanups...
I'd say specifically tst_netload() (in tst_net.sh) and netstress.c deserve
cleanup. Also, as we noticed several times shell tests tends to be buggy,
specially in combination with C tests. But not sure if feasible to write
everything in C.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
