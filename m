Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C20C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 08:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACFD13CD1EB
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 09:26:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E8263CA4C4
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 09:26:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8B0B1A00E6F
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 09:26:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA89F219B8;
 Fri, 24 Mar 2023 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679646380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0c2A/gUuy6CNPc4NdCF58VpmJqo1a2SRJ/lINp407dM=;
 b=x/OAkLRsANE0tiTKkU4q1Z8qqufgyevUW/KCGh1dPyl7W3Vodr0Ff0/TvFsjypDoTtivwP
 Cdrh9iIOKOS0qzJ8RaR7RJ58BkPlhR7nBXoPIrnOYVDDh1FwMgJ3xZQbc+st7eKfb05sFD
 NwXLs9N3YUkUQ+Xs1nWYrXIfTi49NqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679646380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0c2A/gUuy6CNPc4NdCF58VpmJqo1a2SRJ/lINp407dM=;
 b=worKSztrteLOyrU7obup2Cc9QxDqkNoigYdQEPbSfuG+lc8Q/Pfvu9E6Cblpar12kb2WFr
 APsPzdBkOok7NODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EB2313A26;
 Fri, 24 Mar 2023 08:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kdhiJaxeHWRzewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 08:26:20 +0000
Date: Fri, 24 Mar 2023 09:26:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230324082619.GA544254@pevik>
References: <20230226003526.8733-1-wegao@suse.com>
 <20230323092655.GF405493@pevik> <20230323121757.GA30319@localhost>
 <20230324063254.GA520087@pevik> <20230324065436.GA10116@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324065436.GA10116@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] clone3: Add clone3's clone_args cgroup
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Fri, Mar 24, 2023 at 07:32:54AM +0100, Petr Vorel wrote:
> > Hi Wei,
> > > On Thu, Mar 23, 2023 at 10:26:55AM +0100, Petr Vorel wrote:
> > > > Hi Wei,

> > > > Do you plan to use this somewhere? Otherwise I don't see the point to just
> > > > add it.
> > > Sorry i need add another commit above this and start using new added args, will
> > > create test case later, maybe you can put ChangRequest firstly, thanks.

> > I'd prefer to merge them once they are actually needed. But Richie might have a
> > different opinion.

> @Petr So i need continue add case or not? 
That's up to you. I'm just saying I would not merge code which is not use.

Kind regards,
Petr

> @Richie what's your plan?
> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
