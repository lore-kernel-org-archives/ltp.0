Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D113ECAAD1
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 16:08:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A897E3CA8A3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 18:08:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 858B13CA744
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 18:07:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE87F60118C
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 18:07:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 404BA22B2B;
 Thu,  1 Sep 2022 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662048471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00/yhQrJi0xJEvgmDhp9TvLqPrbyyitNmom8rHGSz/Y=;
 b=GD8xNlDCTwYngDVc1hgVm4q5I6NHtLi5lpb2LO4J8aAhCyCSPj7TzBfG9EqjPhKLqGoKYd
 b6CtVg7jk8CFR0yBM1OhwArZ7pfSJHcVsfIaaIW4TUgpQXFVUNdyYttufRm/lwpKXfT1CE
 lX1YQOwq0+sU+hme2vToJ1VFedBms2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662048471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00/yhQrJi0xJEvgmDhp9TvLqPrbyyitNmom8rHGSz/Y=;
 b=LHZTBQHLqPpLy4aNAPMqSzIx0+njkrhGW2/oMCR3E9plOG3X1OPZ51oCt/JlZCZVqMRKo9
 nWVeooBM9LgsLzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30EFE13A89;
 Thu,  1 Sep 2022 16:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d0mDN9XYEGP8CwAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 01 Sep 2022 16:07:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 01 Sep 2022 21:37:47 +0530
Message-ID: <8989849.CDJkKcVGEf@localhost>
Organization: SUSE
In-Reply-To: <YxBSF1ZgU5wSlpi+@pevik>
References: <20220714060722.18894-1-akumar@suse.de> <YxBSF1ZgU5wSlpi+@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04.c: convert to new LTP API
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

Hi Petr,

On Thursday, September 1, 2022 12:02:55 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> I suggest to merge with these fixes:
> 
> * added free (if needed - that was in the original source)
> * fixed cleanup (don't run SAFE_CLOSE() if previous SAFE_OPEN() or SAFE_MALLOC()
>   failed)
> * use TST_EXP_FAIL() - the same result as TST_EXP_FAIL2() with shorter code
TST_EXP_FAIL2() is correct here as you mentioned in previous reply.
> * allocate memory needed (it's actually -2)
fds_limit(1024) - first(3) is correct as we need to allocate memory for1021 int fds.
Test executes fine even with (fds_limit - first - 2) probably because malloc allocating
more than requested memory.

> * #define FNAME "open04"
> 
> If it's ok, I'll merge it.
please go ahead and merge with rest of the suggestions, or let me know if I should
sent v2.


Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
