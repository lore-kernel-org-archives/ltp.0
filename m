Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF2C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:52:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65CD53CA9D8
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:52:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38B33CA897
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:52:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 292BB601177
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:52:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D3511F946;
 Thu, 12 May 2022 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652367124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RosZ0bIxWTN8r/s+Oiqc6m/fbmKUsUFW7mTc9XioBy4=;
 b=mxu3g/t3OdFbgpf1zsLZcx6UboWc7jQa4M8LbmoGr72z8rM3PD1my7CJhwbfiTDxjhTrQq
 BaYvWNvmjDr9lqwS60ZxBYo4YMPbYArPT9wSCCZfJ4ncEyVVTmt8K0XQY5NSggCdmYxBx2
 xLLJ7RiP3Iy3EdIsUsYyWiNcPhJjwrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652367124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RosZ0bIxWTN8r/s+Oiqc6m/fbmKUsUFW7mTc9XioBy4=;
 b=2GYrNubYihxKjS7BN0pOr6H91QVwfcO0g/BjdHhcNwLdgqmCnRIxt2cW1gL1xPUM6MwpSj
 6dK1cnNJlsuuOzAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34BBF13ABE;
 Thu, 12 May 2022 14:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fmJjDBQffWL2XgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 14:52:04 +0000
Date: Thu, 12 May 2022 16:54:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yn0fmr2wFUcRdi1h@yuki>
References: <20220428144308.32639-1-pvorel@suse.cz> <Yn0bxyweYWKgY8SB@yuki>
 <Yn0d2bVppx36Nwv5@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yn0d2bVppx36Nwv5@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 automated-testing@yoctoproject.org, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, libtirpc-devel@lists.sourceforge.net,
 Trond Myklebust <trondmy@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Looks like rstatd wasn't included in distributions to begin with, so
> > there is no point to keep tests for it.
> 
> > https://bugs.gentoo.org/show_bug.cgi?id=115806
> > https://access.redhat.com/solutions/34127
> > https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10
> 
> Thanks for the links.
> FYI Debian has had it for a long time in rstatd package:
> https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=contents&keywords=rstatd
> https://packages.debian.org/bullseye/rstatd
> https://tracker.debian.org/pkg/rstatd
> 
> but that IMHO no reason to keep these tests.

For debian we have:

https://qa.debian.org/popcon.php?package=rstatd

0.07% of debian installations installed rstatd.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
