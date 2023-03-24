Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5204CC6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 06:54:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01AC63CC4F4
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 07:54:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33CBF3CA4F3
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 07:54:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E8EB1A00E2E
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 07:54:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D08C1FE92;
 Fri, 24 Mar 2023 06:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679640880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jgssJ/jjkNQ2iC5umc9I15A75XIVXxmzMRGSqqSHLCw=;
 b=qLDHRiVzcjlcBFMLMPAA8ytAuDmidgZCmrM+QhALrWlW7cfzziZ5gEHsIVR0CXjbn6q/Ud
 B96pfhM69Kl/NZxb3qiAETCJOomiKBR3Ey0IpgHsJzDxzADAmfed6505szDbEXP4OW0tvr
 pCnntHUXAcSmx0feHmI4L10USzisduQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 461A6133E5;
 Fri, 24 Mar 2023 06:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gnH+By9JHWSWTQAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 24 Mar 2023 06:54:39 +0000
Date: Fri, 24 Mar 2023 02:54:36 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230324065436.GA10116@localhost>
References: <20230226003526.8733-1-wegao@suse.com>
 <20230323092655.GF405493@pevik> <20230323121757.GA30319@localhost>
 <20230324063254.GA520087@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324063254.GA520087@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 24, 2023 at 07:32:54AM +0100, Petr Vorel wrote:
> Hi Wei,
> > On Thu, Mar 23, 2023 at 10:26:55AM +0100, Petr Vorel wrote:
> > > Hi Wei,
> 
> > > Do you plan to use this somewhere? Otherwise I don't see the point to just
> > > add it.
> > Sorry i need add another commit above this and start using new added args, will
> > create test case later, maybe you can put ChangRequest firstly, thanks.
> 
> I'd prefer to merge them once they are actually needed. But Richie might have a
> different opinion.
> 
@Petr So i need continue add case or not? 
@Richie what's your plan?
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
