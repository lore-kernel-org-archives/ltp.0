Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5406C43334
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 12:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94293C87C7
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 14:25:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E9723C2FA4
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 14:24:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97D93100024A
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 14:24:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8C521F8C5;
 Fri,  3 Jun 2022 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654259091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KK5233/MURwEBi/GL4MGbqziIZxybwlr1QuzAfSvwWc=;
 b=PCNO+6H/N9GLgK54vgPWyexDJIFwEc9K9G6SwaFI0o/pERX4iS5oUKsbFL/qLZxUaEophU
 OS04Uxchp2b/s1LhFiJvCjbNWf8uNtHJyW21ogw9Q3IxMb2Wwgg29k9fWTyPOk4lmJTgzR
 tKHMVUTo+neI69xH7x2TdRtBRwRQ2t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654259091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KK5233/MURwEBi/GL4MGbqziIZxybwlr1QuzAfSvwWc=;
 b=SvgVI2L61TLconWTWxaC4/D2VDUTjWcMrRmBWMg5YcJLUSkmKF88SOjS2/MGAyeBYD5QwE
 UN0WESeENg7AP7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BB4913AA2;
 Fri,  3 Jun 2022 12:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tNVbGJP9mWKrWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jun 2022 12:24:51 +0000
Date: Fri, 3 Jun 2022 14:24:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ypn9kQF7PTM3pA0n@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-4-pvorel@suse.cz> <YpTS99QLyFfSkrnl@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpTS99QLyFfSkrnl@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] tst_test.sh: Improve pattern for allowed
 variables
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

> Hi!
> >  	if [ -n "$TST_TEST_PATH" ]; then
> > -		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
> > +		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`'"'"'].*//'); do
>                                                                                            ^
> 											   Isn't
> 											   the
> 											   content
> 											   between
> 											   []
> 											   just
> 											   set?

> Shouldn't adding just ' between the [] suffice? The " is already there.

Well, '"'"' was my version of adding ' (quoted with " and ' at the start and end
were for ending previous '.

But this is shorter: '\'', therefore suggest

-		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
