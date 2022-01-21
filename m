Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D1CC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:10:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 541903C970A
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:10:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32B303C96C9
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:09:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 97480600704
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:09:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8BDB1F884;
 Fri, 21 Jan 2022 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642756193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7i5i26SNncPlPzumrCoe5EcWuKZKd/pnHDg4xA2Riks=;
 b=zweFnHwtbi4p6+/Kw6tSCD6zrWo2jPgx9Ha85ZMifwFTgb8Fe5Ylqvg/BDkNVOkPTBtlVw
 W3yJFMWSuRQgS3WVZ4k3NyM8HstEYri0o9Rtbtl/G1LlYw8t7NmFbPo7issViGmS8avn1B
 KoGxxrA8hdBil1nbqDq6nycUVA2Dwyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642756193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7i5i26SNncPlPzumrCoe5EcWuKZKd/pnHDg4xA2Riks=;
 b=GqFff8rgOOtBNf30lUKgczQRDkiNC+FVheKjYpIP6yNnTdw8Upwy9ase3WY58zwfp6UQ/H
 BqB9gPiILr2FzbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB5113345;
 Fri, 21 Jan 2022 09:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N24uIWF46mEgSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 09:09:53 +0000
Date: Fri, 21 Jan 2022 10:11:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kautuk Consul <kautuk.consul.80@gmail.com>
Message-ID: <Yep4yrsnTZuNPCKL@yuki>
References: <CAKWYkK3a-Qp5bZNyL67JkTtzD=_55c0tk7eb69rsikYr+r=QqA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKWYkK3a-Qp5bZNyL67JkTtzD=_55c0tk7eb69rsikYr+r=QqA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msgstress03: "Fork failed (may be OK if under stress)"
 problem observed on qemu.
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
Hi!
> The reason why other test-cases like msgstress04 dont fail is because
> the nprocs value is set with a different calculation.
> Specifically, I observe that the msgstress04 testcase uses only
> free_pids / 2 pids instead of the full free_pids number of processes.
> 
> Can someone confirm my findings ? If needed I can also send out a
> patch with my above nprocs/2 changes if required.
> Or, if there is any better fix or opinion kindly reply back to us.

Actually these test are broken much more than this, they need to be
redesigned and rewritten properly. There is even a work-in-progress
patchset, but unfortunatelly it wasn't updated for nearly a year, see:

https://patchwork.ozlabs.org/project/ltp/list/?series=233661

https://github.com/linux-test-project/ltp/issues/509

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
