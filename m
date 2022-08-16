Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E0DC25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 12:44:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AD4A3C98BF
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 14:43:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 970633C0895
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 14:43:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28A6810000CA
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 14:43:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 779E01FCE9;
 Tue, 16 Aug 2022 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660653827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z3UuzzgADrkBbPW2j8W88qcTAl7MIyD0V2rYJADW3EM=;
 b=SsN52NpZN7KDa63fJxuMkV6slmI6fKpHOqSTWKKO0W8NyaKs0zW/CyqNatcJGXClxDjMxW
 nGQ537FLTSyBzTtcwQEHccBkNHKWk0K1GNP6Cmrt4gXZ/UPQJX/rQs6L9XyYTJFtPk/+Wh
 DrC4dVjKSCD09jwPYMo4ghsn0qVxSRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660653827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z3UuzzgADrkBbPW2j8W88qcTAl7MIyD0V2rYJADW3EM=;
 b=wzaEKpfzXpGiTYT1c1oNWx+OiqSRTAxKLVfFqHL3nL19ic8luVu7yoC7i+/3p5SnoKBd+e
 uoL7gU2VNx+sbeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3148C1345B;
 Tue, 16 Aug 2022 12:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I+x5CQOR+2KVVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 12:43:47 +0000
Date: Tue, 16 Aug 2022 14:43:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvuRAR1DSi67PDzh@pevik>
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvUhZ/9Yf7eZ4a32@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> Hi!
> > I think I finally understand what you mean by this now; it is rather
> > strange that the volatility of D does not protect loop from being
> > optimized away by the compiler.  I don't have a good explanation as to
> > why it's happening but I'm not sure how to evaluate what's going on
> > either.  Should I do anything to move this patch forward?

> It all boils down if we want to work around something that looks like a
> compiler bug in tests or not. I would be inclined not to do so since LTP
> was littered with quite a lot of workarounds for glibc/compiler bugs and
> we spend quite some time cleaning that mess up. But in this case I can
> agree that this is a borderland issue so I'm not strongly against that
> either.

Edward, which which clang version requires it? It'd be nice to document it, so
that it can be removed in the future.
Is there any bug report for it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
