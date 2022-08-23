Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D39C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 13:22:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970DF3CA34F
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 15:22:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833663C9882
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 15:22:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B02932003BE
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 15:22:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A175E1F86C;
 Tue, 23 Aug 2022 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661260952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt6r6QuF9VXBjzCCKCbMJ1DDjn2a6GnYiOTsr6/v788=;
 b=xWteADhgfTk1aN9TtsQSX6bYVA6t8Z0fjszzirmC0z3lbDXA/biwE/XxmaKAJvakP9d6AN
 re1JjoEhQsr4uNG+7N0KzVjqF5GsfGXKV+dA/ZZVzK4rjdDSCndM9kx+EgMoyqu8Z7FFXA
 sIdhLOmDNWoGyfFyxcGt8OBeg3uikoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661260952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt6r6QuF9VXBjzCCKCbMJ1DDjn2a6GnYiOTsr6/v788=;
 b=H/epHnLckNAYvyUt7JNzfBKtaZF/R+8PU9SWz/Cz4FtqaAwUrp83G3b2tY1CXFAMb8Tcbp
 xFfVXt9apC6W5UBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AF8113A89;
 Tue, 23 Aug 2022 13:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iZ7dIJjUBGNnYQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 23 Aug 2022 13:22:32 +0000
Date: Tue, 23 Aug 2022 15:24:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YwTVDy+KY41cx6JS@yuki>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-4-tudor.cretu@arm.com>
 <YwSg3BbsVwGcjlsx@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwSg3BbsVwGcjlsx@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/prctl04: Allow rt_sigprocmask in
 the syscall filter
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Some libcs (e.g. Musl) call rt_sigprocmask as part of their fork
> > implementation. To successfully call fork, rt_sigprocmask must be allowed
> > as well in the filter.
> 
> When tested on lastest update Alpine with 1.2.3 it in both cases fails:
> 
> prctl04.c:205: TPASS: SECCOMP_MODE_FILTER doesn't permit exit()
> prctl04.c:207: TFAIL: SECCOMP_MODE_FILTER doesn't permit exit()
>
> What can be wrong?

And does the test work without the patch?

As far as I can tell the change to the bpf is correct and shouldn't
affect anything, it just allows one more syscall to be called.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
