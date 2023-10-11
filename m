Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD24ECD6E53
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 09:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E73233CD4E1
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 11:29:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56AEC3C62DB
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 11:29:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0BE0206C2C
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 11:29:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 23DB9211C2;
 Wed, 11 Oct 2023 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697016589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQkyMDRCDV39lielmBu7dSdw70sXgwk+vQB3IWE8pcc=;
 b=kVe9ORq3M7FeJ7dxjk8kScHKW9k7/PX4/kJWtb/tzmZ+hQjiyIhgePq+ynUPt78DDyr7jG
 j/c1x8zIA1heUyALnVte9J5ZUa4pZBLSrtCKHc6+yWpPDXj5KrKgxZPO/onl+DdnMixxf3
 CCVQ5w1PSFW0J4nBiW1aDpcmIBzRa9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697016589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQkyMDRCDV39lielmBu7dSdw70sXgwk+vQB3IWE8pcc=;
 b=KnDGCuiLUFeygNjq7UsuqAXr6AqQ24P2XM49tgxDnclgqtxFj75gpI70G3RUycnSDd60v3
 RiGsK3mNnwZwk+Ag==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C92752C665;
 Wed, 11 Oct 2023 09:29:48 +0000 (UTC)
References: <20230908092822.27085-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Oct 2023 10:29:31 +0100
Organization: Linux Private Site
In-reply-to: <20230908092822.27085-1-andrea.cervesato@suse.de>
Message-ID: <87bkd5zeur.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Merge fork06 and fork11 into new test
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> fork06 and fork11 worked in the same way, spawning multiple processes
> inside parent and waiting until they complete by checking wait() pid
> result. fork06 was spawning 1000 children, fork11 was spawning 100
> children. For this reason, fork_procs now merges both of them,
> including an option that selects amount of processes we want to spawn.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Merged, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
