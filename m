Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A53C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B838F3CC101
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:43:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00A23C1D84
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:43:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A85F1A00A56
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:43:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E91AC2254E;
 Thu, 16 Feb 2023 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676547787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvzRASPQdJVoYkj/2kpKHAi5pikOaF2GZbRfLqqnnDE=;
 b=u9QSVmJKZGf3r7REbP9po+43eYKSJatVetH44+2bjjsQdTwu1Tuv5XcfKr50eIuOTx5Y/X
 Nm2mnhEtS1N0Juo02+yyXoboVUq87e8H3MSFjtUG2R0/pR1w62GBahhvkA3TfOI9l+oBDB
 o1/AjFx36brCdP2JYYUw5BB96ZwlTVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676547787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvzRASPQdJVoYkj/2kpKHAi5pikOaF2GZbRfLqqnnDE=;
 b=7fsH8iVDMb6naSjO4WtP+xAFYfQ8qgmW4+3Pe7+Xq9jTc01dxzhhOQI9wqTjEcczwfYy6b
 wzWWtYXkV+Xw64Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D64DB131FD;
 Thu, 16 Feb 2023 11:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bMwcM8sW7mN4IgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 16 Feb 2023 11:43:07 +0000
Date: Thu, 16 Feb 2023 12:44:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrei Gherzan <andrei.gherzan@canonical.com>
Message-ID: <Y+4XIho55E7quLTz@yuki>
References: <Y+zcqqNE01cNcm1Y@qwirkle> <Y+38qMc2Kdh2DPA7@yuki>
 <Y+4GEbRopmw5QA5r@qwirkle> <Y+4KJ3tgxRiIr7JN@yuki>
 <Y+4PA8sAFBlBo1R6@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+4PA8sAFBlBo1R6@qwirkle>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP fs_fill test on vfat - ENOSPC
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
> > > I have tested, and we will locally go with my proposed 3rd option for
> > > now. Does that sound resonable for a push to upstrem too? 
> > 
> > Sure, this sounds reasonable as well.
> 
> Great. What's the default in LTP: GitHub PR or mailing list patches?

We do prefer mailing list.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
