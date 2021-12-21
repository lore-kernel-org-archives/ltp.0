Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C84C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 08:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CFF3C9243
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:41:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B84AE3C9168
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:41:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C81DD1A01491
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:41:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46E0E1F3B3;
 Tue, 21 Dec 2021 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640076083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8KUB2bqx4/XKSeWuQhh6X2O9KAkE8rLzif4jTwV1po=;
 b=jodXOHMzp9xbfMFYieSScvGCVouRNTxE78XN5KFx7+BIo829Nc7NVdlUNe8jAbHJCr0S4z
 RnqJeLMn/01BQ2AJ8HTQyPuG5OwrnE1mM0FsaQ+pKCTjiSwMwTMpIbuZQSXxxk/EGnS1EV
 EXVyzDCwSCfNCq87BZJhtJ/aO+iiOa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640076083;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8KUB2bqx4/XKSeWuQhh6X2O9KAkE8rLzif4jTwV1po=;
 b=T4cAuzjsfCgOY82EmTqDflk9eCuGHi29YYCSOq14+T+950UPAiNcN1jOUI+u+UwmCagZh/
 1ooTvtzTDB/jh3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F18013BEC;
 Tue, 21 Dec 2021 08:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1tYhOzKTwWF3LQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 08:41:22 +0000
Date: Tue, 21 Dec 2021 09:41:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YcGTMcan0r2NOcR9@pevik>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YcBfuCPg1ENZHvud@pevik> <61C1397A.1070904@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61C1397A.1070904@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in
 this disk with allocated for this disk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr
> >> Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
> > nit: we can drop [1]
> >> used free -m changes to calculate the compression ratio.

> >> After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
> > nit: I'd add link to the doc also in this commit message.
> I don't see the link on your ltp fork:
> https://github.com/pevik/ltp/tree/yang_xu/zram-swap.v5.fixes
I haven't fixed it there, I pushed it to verify there is no build failure.

> I have tried this branch and these change seems fine.
Yes, code should have my suggestions.

> I guess I don't need to send a v6 patch and you can merge it directly(by 
> removing [1][2] linke and adding fixes tag ). Is it right?
Ah, sure, go ahead and merge. I'm sorry to pick on details.

> ps: I want to add a fixes tag for pointing to commit 4372f7a2156 ("Fix 
> compression ratio calculation in zram01").
+1, thanks!

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
