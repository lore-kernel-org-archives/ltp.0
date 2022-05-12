Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AA5C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 15:07:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E41463CA9CA
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 17:07:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7186B3CA31D
 for <ltp@lists.linux.it>; Thu, 12 May 2022 17:06:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8FBE600556
 for <ltp@lists.linux.it>; Thu, 12 May 2022 17:06:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F27D41F93E;
 Thu, 12 May 2022 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652368016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV07vqdHr/p+XyDA68jqRpyiPdC3eRHAtzp0YwJHrL4=;
 b=B2L5XekLiin8V1vaUdiJPVNCbaeSHPDFq60iAPQRu8Ac3Knj2Ayr07I9FnkNpE5krGCZeQ
 dKa9Ls4Qza55imetL9tmmGv2i8QYTKrmY+9FxyqYU2a7Cvx0aL5Frvc86B1TTozIzt6BCE
 7sHCoHaL0pZhWN2hb9MC6WiK242ISuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652368016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV07vqdHr/p+XyDA68jqRpyiPdC3eRHAtzp0YwJHrL4=;
 b=Z/4Lql1GkoySAwzjPdW+Xvrt4RWkgFWWNxocnolfAUGoKGUaczch8w39Jjq/NBYgelZNWz
 3qZs8AsQiwYENqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 643BE13ABE;
 Thu, 12 May 2022 15:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LAXgFo8ifWJwZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 15:06:55 +0000
Date: Thu, 12 May 2022 17:06:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yn0ijb7vnNnW8BzB@pevik>
References: <20220428144308.32639-1-pvorel@suse.cz> <Yn0bxyweYWKgY8SB@yuki>
 <Yn0d2bVppx36Nwv5@pevik> <Yn0fmr2wFUcRdi1h@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yn0fmr2wFUcRdi1h@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/3] Remove RPC rup and rusers tests
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
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 automated-testing@yoctoproject.org, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, libtirpc-devel@lists.sourceforge.net,
 Trond Myklebust <trondmy@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Looks like rstatd wasn't included in distributions to begin with, so
> > > there is no point to keep tests for it.

> > > https://bugs.gentoo.org/show_bug.cgi?id=115806
> > > https://access.redhat.com/solutions/34127
> > > https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10

> > Thanks for the links.
> > FYI Debian has had it for a long time in rstatd package:
> > https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=contents&keywords=rstatd
> > https://packages.debian.org/bullseye/rstatd
> > https://tracker.debian.org/pkg/rstatd

> > but that IMHO no reason to keep these tests.

> For debian we have:

> https://qa.debian.org/popcon.php?package=rstatd

> 0.07% of debian installations installed rstatd.

Agree, both are dead, that's why I want to remove it.

Because although it'd be easy to fix failing test, I have no reason to improve
popcon statistics just to fix tests which nobody needs :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
