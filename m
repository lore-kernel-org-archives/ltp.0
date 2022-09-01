Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACB9ECAAD2
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 20:49:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4FD83CA710
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 22:49:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70C6D3CA70B
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 22:49:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A797E1A010FD
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 22:49:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED35833881;
 Thu,  1 Sep 2022 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662065360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ZPZecApxKQKIe4B3zbVBSv6XcxvCXc2Lehng3C7nM=;
 b=NF7K8bAlyp1jbZPWlEb6NhHa4bpde7+xWiRvb0rGvnDRelmHEYEYwWwpD0lPCYNTXfmSNv
 iUBx1n5bqMrSxRZgV4FfO3AjmNXilADkbc3zQ0rFt9mQTmg0osFSPH829WA58F0CsOGO0g
 gdznbpV3ogCTZgfPf6mEKycdpAvJF8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662065360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ZPZecApxKQKIe4B3zbVBSv6XcxvCXc2Lehng3C7nM=;
 b=5jQ7d6WSGldP/1YGxuFpUuxVXgKYWPE6dgYTvfhsKyjAS6B/8snbOhHCKs15tNk0VDs/sW
 HzS9BM0O4HcHtsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A958F13A79;
 Thu,  1 Sep 2022 20:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B+ogJ9AaEWNUeAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 20:49:20 +0000
Date: Thu, 1 Sep 2022 22:49:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxEazcN3+vkU/lVQ@pevik>
References: <20220714060722.18894-1-akumar@suse.de> <YxBSF1ZgU5wSlpi+@pevik>
 <8989849.CDJkKcVGEf@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8989849.CDJkKcVGEf@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> > I suggest to merge with these fixes:

> > * added free (if needed - that was in the original source)
> > * fixed cleanup (don't run SAFE_CLOSE() if previous SAFE_OPEN() or SAFE_MALLOC()
> >   failed)
> > * use TST_EXP_FAIL() - the same result as TST_EXP_FAIL2() with shorter code
> TST_EXP_FAIL2() is correct here as you mentioned in previous reply.

> > * allocate memory needed (it's actually -2)
> fds_limit(1024) - first(3) is correct as we need to allocate memory for1021 int fds.
> Test executes fine even with (fds_limit - first - 2) probably because malloc allocating
> more than requested memory.

Yes, thank you for correcting me, I forget the basic (the alignment of
dynamically allocating memory).

> > * #define FNAME "open04"

> > If it's ok, I'll merge it.
> please go ahead and merge with rest of the suggestions, or let me know if I should
> sent v2.

Merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
