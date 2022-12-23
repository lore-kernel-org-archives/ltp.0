Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE5AC4167B
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 08:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 266913CB98D
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 09:53:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94AE63C0F12
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 09:53:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 367D76011B4
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 09:53:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 070C72625B;
 Fri, 23 Dec 2022 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671785605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gpvvAdgK2J1XDC1A4olDel5y5y75vP98fl6495VKJE=;
 b=kKqb+cHDyhrjVo/m35PPens600BjNC+QooCSiI81/hqBRIJA/NNiHFzZIl5wA1XutonxIY
 W4lPmSjRDLtbMNbE+d1+6chwyCjU0qkXHyzMvBgAoh+mzejkA0tsZPSF7jVq/4QFGVst3h
 ekxnMHOJ5xjjFSG043HzQ4pbK8JZ/Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671785605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gpvvAdgK2J1XDC1A4olDel5y5y75vP98fl6495VKJE=;
 b=6TDmfjQ6bS69fq58V1B1EZx3bFpEgN4+POGD7ft1m9EpPMUywhT+TsfX9VzUbYbYmOMjoi
 FU5s9r7Dl7FSz1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D42F113913;
 Fri, 23 Dec 2022 08:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OeQTMoRspWPGYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Dec 2022 08:53:24 +0000
Date: Fri, 23 Dec 2022 09:53:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y6Vsgkx/VcY/78vs@pevik>
References: <20221221075220.14353-1-akumar@suse.de>
 <87ili3stt2.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ili3stt2.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setreuid01.c: Rewrite using new LTP API and use
 TST_EXP* macros
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

> Hello,

> Avinesh Kumar <akumar@suse.de> writes:

> > Hi,
> > I changed this simple setreuid() test to new LTP API but I think
> > this is a subset of setreuid03.c test and can be removed altogether.
> > Please share your opinion. If this should be removed, I'll post new
> > patch for that.

> Yes, I think that is reasonable.

+1. Also setreuid03.c tests as nobody, but we have no garancy setreuid01.c is
run as non-root user (it can be root or UID 1000, which has enhanced
privileges).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
