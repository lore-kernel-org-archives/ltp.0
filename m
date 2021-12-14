Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9507C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 18:55:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C7AC3C8D6B
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 19:55:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D963C2BBF
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 19:54:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E5812100034B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 19:54:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCB7A1F381;
 Tue, 14 Dec 2021 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639508091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fa14ragNfLvoFDkEJ0LhbYTY4Vx5GOeSO1rGasGA8fM=;
 b=plwCkH2pp19bu5WQQd+bMFTNL3ltZ8tL8eozdQ1uSg4xsSa+zQvQJWbE/oOnXeZsQApFAH
 m+Q3fTMrFEzYUrm5hHUtIvvhmzWs3IzbKEwW8eYmrADp9pxvD7OdxbCDEsrq44D1FWzxq1
 0/yOtLQl4wT7si49C3puHPd3NEqzhTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639508091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fa14ragNfLvoFDkEJ0LhbYTY4Vx5GOeSO1rGasGA8fM=;
 b=pYyYrd/ohZ3yAUy/DZMEaBSRKUZoeDvlhwmNe/osAmsMYeBB6slQLr7QmIR3pzxWWGgEqA
 aqe3t7FxxzuqewAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83A0113ECB;
 Tue, 14 Dec 2021 18:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XZxUHXvouGF9QAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 18:54:51 +0000
Date: Tue, 14 Dec 2021 19:54:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tim.Bird@sony.com
Message-ID: <YbjoeQ/lVsf01JJx@pevik>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
 <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjKkic5F0j4c3bD@pevik> <YbjNExvj1vjnjb93@pevik>
 <BYAPR13MB250371A7DC839014B8219104FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB250371A7DC839014B8219104FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tim,
> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>

> > > Hi Tim,

> > > > > +	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");

> > > > I think this should this be: "Timeout multiplier (must be a number >=1, should be an integer)

> > > Also makes sense, thanks!
> > Although it does not have to be integer.
> > => "Timeout multiplier (must be a number >=1"

> > For C API it's used any value:
> > ./open01
> > tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s

> > LTP_TIMEOUT_MUL=1.15 ./open01
> > tst_test.c:1409: TINFO: Timeout per run is 0h 05m 45s

> When I grepped the source code I saw the usage in testcases/lib/tst_test.sh,
> but somehow missed the usage in lib/tst_test.c (sloppy on my part!)
FYI this help is for C API. We should print variables also in shell API,
but I wanted to keep this patchset small.

> Thanks for pointing this out.

> > For shell API:
> > ./zram02.sh
> > zram02 1 TINFO: timeout per run is 0h 5m 0s
> > zram02 1 TINFO: timeout per run is 0h 7m 30s

> > LTP_TIMEOUT_MUL=1.15 ./zram02.sh
> > zram02 1 TINFO: ceiling LTP_TIMEOUT_MUL to 2
> > zram02 1 TINFO: timeout per run is 0h 10m 0s
> > zram02 1 TINFO: timeout per run is 0h 15m 0s

> > Doc [1] explain it: Variable is also used in shell tests, but ceiled to int.

> Would it be useful to add a bit of code to tst_test.sh to handle
> floating point?  The shell construct of '$((timeout * LTP_TIMEOUT_MUL))'
> can't handle floating point, but floating point could be done pretty easily
> with a callout to awk or bc.

> I'm willing to look at this and submit a patch.  But does the shell
> test system try to avoid dependencies on other utility programs (like awk or bc)?

> Maybe rounding timeouts up is preferred behavior anyway, so
> this is not needed.  What do you think?

[ Cc Joerg, Li and Cyril, who were involved in shell timeout ]
We spent quite a lot of time before we end-up with ceiling, I'd have to search
for the reasons. We also didn't think that it's a big problem to not being
precise on shell. But feel free to improve things. Just, generally we prefer to
wrote small C code instead adding new dependencies (bc etc) or trying to make
shell portable. Actually writing C parser would be few lines of code.

> In any event, I retract my "should be an integer" suggestion. :-)
You pointed out also wrong spelling, which I'm going to update.
Thanks a lot for your review!

Kind regards,
Petr

>  -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
