Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE833C3DA7D
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 21:44:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78D2D3CCD36
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 22:44:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D97333CB62D
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 22:44:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 543EA1400BF6
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 22:44:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EE698C048;
 Thu,  5 Jan 2023 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672955065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkgzwCwEbD6jHedN///TWGQsNG8ND+yKW0934dxNQdA=;
 b=AmFt/OpssEARTqPH5QgjqJWvxsx7O3/ws0OqfjPBZIe4BccZD+jYepZqb5G2fT/7btsnzI
 lztdUTKhS1qX7jyrWBtFvqD9fM1oeuq1r0mwm2+Ipe5XgX6De461ShLPUl5lnk+nwT176p
 90xMCNvYFTcTUgvA/H3u9C6PioD3UKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672955065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkgzwCwEbD6jHedN///TWGQsNG8ND+yKW0934dxNQdA=;
 b=D1z/sClQrd9tqYlIACEwfo9eQddcVHK8xGU816jCYJck0igHLrWgizqiphN/RKCpP4nJ+L
 WnloEyAfKeFBL2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62D14138DF;
 Thu,  5 Jan 2023 21:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MYhdFrlEt2PiSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jan 2023 21:44:25 +0000
Date: Thu, 5 Jan 2023 22:44:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y7dEtzz+QZkWyIjf@pevik>
References: <20230105134416.15853-1-mdoucha@suse.cz> <Y7bu3jaL+nLIc/+0@pevik>
 <a94f5417-c580-8b05-dca6-3bb968ef5afb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a94f5417-c580-8b05-dca6-3bb968ef5afb@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ltp-aiodio.part4: Run DIT000 with only 1 reader
 process
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

Hi Martin,

> On 05. 01. 23 16:38, Petr Vorel wrote:
> > But I wonder why changing just the first dio_truncate will fix it
> > (obviously not). Could we detect RT and force -n 1 for it?
> > (utsname.version should have "PREEMPT RT"). Obviously only from version which
> > got affected.

> It'll fix only one of the three tests. But I like having some direct I/O
> stress tests for regular kernels so I've modified only one dio_truncate
> instance. The other can be skipped manually on RT kernels.

Make sense.

> But let's add a warning to dio_truncate if it's running on RT kernel with
> too many children so that users know that the failure is sometimes expected.

Thank you!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
