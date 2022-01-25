Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344BC433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 10:48:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6680B3C93B7
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:48:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE40F3C54C9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:48:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B246140004C
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:48:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82708218E6;
 Tue, 25 Jan 2022 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643107700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBMl4ufKIqX/IcO1L+wcg+y9kvWywnNPZ9oH5HDZj1g=;
 b=yK/4miI4/kHkeEuTdLkHQNc2rm/b8wHNkHC4aCetVtoBi5YvfQ0iB1/AqQk9oXL8eW8sST
 dFcWGJZCCi+TPVnESrEe85fjPJbGujnq2Jq1Coz8M5GUyB394ZoMz5wkpaHftZXrSfetYF
 B9/Eo7Y01diTMNExBM70UiEzgKNyRSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643107700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBMl4ufKIqX/IcO1L+wcg+y9kvWywnNPZ9oH5HDZj1g=;
 b=ilyO5uezPXDN7xl5fAuLue8lfk2P7xMcJ4DdomuYzOl1K3tYVEImW6z1m3XPzZLbmLIBs2
 Bt5s4ZWM2di+rfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 701BD13DB8;
 Tue, 25 Jan 2022 10:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UxklGnTV72F1cwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jan 2022 10:48:20 +0000
Date: Tue, 25 Jan 2022 11:50:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ye/V4CoUHqwE5eGs@yuki>
References: <20211220201814.31596-1-pvorel@suse.cz> <YcH7m45TKEWaDrG3@yuki>
 <Ye615gN0Yv1/WskD@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye615gN0Yv1/WskD@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sched_get_priority_max01: Add more policies
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
> > I supposed that we need this for SCHED_DEADLINE right? What about
> > alternative libc implementations, does they define SCHED_DEADLINE as
> > well? Do we need a fallback?
> 
> Sorry for the delay (I did write a reply, but probably forget to sent).
> musl and glibc support all of them, but uclibc-ng doesn't have SCHED_DEADLINE.
> (and SCHED_RESET_ON_FORK). I'll send v2 with SCHED_DEADLINE fallback.

Sounds good.

> I guess SCHED_RESET_ON_FORK would deserve it's own test (man sched(7):
> when set, children created by fork(2) do not inherit privileged scheduling
> policies).

Yes please. Either write the test or at least create a github issue.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
