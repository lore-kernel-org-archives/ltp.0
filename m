Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEAEFA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 17:39:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 117373CABF7
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 18:39:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46E1E3C0FBC
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:39:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 464621A00243
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:39:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B97F1F8D2;
 Mon, 31 Oct 2022 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667237976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+X7XwnoeJz8aTw0+NsrbI69QQcWNtiUHqI1LHfT0Kp4=;
 b=xDj9sCLbzi7B48f8D2fBvAnRI6Qs5eWkfO8h3ylM5P33UXaVeY/DrG0cm+bK7BirUhWiMO
 BIp2dZ8F87klPy65YS1jZ6Xewi1Q56ldOv/uDW24TwyLVTW5Mpn2LhrguGIXRceqjKrLDQ
 TsqY+lmp/aZJjOBkL8UOGwHD/mhtom0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667237976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+X7XwnoeJz8aTw0+NsrbI69QQcWNtiUHqI1LHfT0Kp4=;
 b=Ug1I0/hHjA4OYq4EDCy8EewJm6lyGJA+4vW0OYegfN5i7VpE1NUw59bg3AdJuk2tPo/efQ
 ilDMTd56SWivilAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0719413AAD;
 Mon, 31 Oct 2022 17:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QlFRNVcIYGNbXQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Oct 2022 17:39:35 +0000
Date: Mon, 31 Oct 2022 18:41:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y2AItxvngzUPG8U1@yuki>
References: <20221027163654.414017-1-teo.coupriediaz@arm.com>
 <20221027163654.414017-2-teo.coupriediaz@arm.com>
 <Y1/Oh4VCUiUSFIvK@yuki>
 <99c55c0c-1f51-5282-6198-dbcb6d919ea3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99c55c0c-1f51-5282-6198-dbcb6d919ea3@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] regen.sh: Use intptr_t for tst_syscall
 return
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
> I agree, I wouldn't want to merge it.
> As mentioned in the cover, I wanted to share the list of tests I have 
> tested the patch with,
> both for people to test themselves if they want to and as a way to ask 
> if there was anything I missed
> while testing with that.
> I didn't really know how to share this, so I added it as part of the 
> commit for the RFC. Maybe it would
> fit better as part of the cover letter ? Or after the commit description 
> with the shortlog ?
> It might be better removed altogether and people can test with a larger 
> scope anyway !

Maybe just a separate patch with [DO NOT MERGE] in the tittle?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
