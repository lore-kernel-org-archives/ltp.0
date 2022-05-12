Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC70C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D7A53CA9C9
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:47:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 619513CA897
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:46:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B17606011B4
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:46:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDC7521B78;
 Thu, 12 May 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652366812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/ljP6CGooMeCqYwmHQLxJxLLKHZ4lezYNMzCYo+tZ8=;
 b=IZ0xzEZXwDjfd6dXhRw7yaic5FsrdosFhMvo7sagFYw4PT6Q0JxZh43uikVm+qJZZ0m5nv
 bPwWNmqiF2j7RalZrCia/2klstRynnZZAoPnoPHxsx5BpuQzQuzAs/NHCVIYfal4LGEMJF
 TcW5isJx+6iEqTCAFvfu2Q93i0G9qEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652366812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/ljP6CGooMeCqYwmHQLxJxLLKHZ4lezYNMzCYo+tZ8=;
 b=V09bQHp9KE0w8KHUf2o2ftE3LWM8MZktn4url8j/AVzLcNI7s7v62OgoTWuJ3fu7c4figJ
 ZC0IRWLAnFoq61DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C515713ABE;
 Thu, 12 May 2022 14:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6uCNLtsdfWKmXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 14:46:51 +0000
Date: Thu, 12 May 2022 16:46:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yn0d2bVppx36Nwv5@pevik>
References: <20220428144308.32639-1-pvorel@suse.cz>
 <Yn0bxyweYWKgY8SB@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yn0bxyweYWKgY8SB@yuki>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 automated-testing@yoctoproject.org, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, libtirpc-devel@lists.sourceforge.net,
 Trond Myklebust <trondmy@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> Looks like rstatd wasn't included in distributions to begin with, so
> there is no point to keep tests for it.

> https://bugs.gentoo.org/show_bug.cgi?id=115806
> https://access.redhat.com/solutions/34127
> https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10

Thanks for the links.
FYI Debian has had it for a long time in rstatd package:
https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=contents&keywords=rstatd
https://packages.debian.org/bullseye/rstatd
https://tracker.debian.org/pkg/rstatd

but that IMHO no reason to keep these tests.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
