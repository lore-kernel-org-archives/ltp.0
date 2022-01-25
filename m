Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F1CC433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:20:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 979D43C93FE
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 12:20:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BADE63C54C9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:20:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D27B1A00933
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:20:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AC3E21111;
 Tue, 25 Jan 2022 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643109635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1U7GAUoleo9Lz4LWNRMZwC7p4TSKRomGMOlAtVIZwLY=;
 b=lMhzxDjT6fz7bs/rT2THHnm0TLcvaVi/LEAua7pZ2R321CPqxCiL4qiSlKdiay6nuNTjXj
 yTE3F4cQz4IL7ux063Ro6jZ031W9MFQb4Jakv0oHvTlVDvo6PiI8Vc3rCtXw8Iz/8BVpf1
 jXGZeJoFmBx4N+s2TIGPwbK1I8gwgdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643109635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1U7GAUoleo9Lz4LWNRMZwC7p4TSKRomGMOlAtVIZwLY=;
 b=V4+wwN9cSYZeA9wNpeC2gVYRC5uRVkwUfJ2S2TJTfCZY652Ni25K+lEkY5Zaj5wAnJHjvQ
 rlQnA/dDPIEUZ2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B945A13DBC;
 Tue, 25 Jan 2022 11:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2dMVIQLd72G/BgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 11:20:34 +0000
Date: Tue, 25 Jan 2022 12:20:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ye/c/+wNRVvwKqHI@pevik>
References: <20211220201814.31596-1-pvorel@suse.cz> <YcH7m45TKEWaDrG3@yuki>
 <Ye615gN0Yv1/WskD@pevik> <Ye/V4CoUHqwE5eGs@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye/V4CoUHqwE5eGs@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > I guess SCHED_RESET_ON_FORK would deserve it's own test (man sched(7):
> > when set, children created by fork(2) do not inherit privileged scheduling
> > policies).

> Yes please. Either write the test or at least create a github issue.

https://github.com/linux-test-project/ltp/issues/905
Marked as easyhack and wait some time to let new comers to take it before
implementing it myself.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
