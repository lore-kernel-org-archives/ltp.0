Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C13DC433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 07:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27BA23CA767
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 09:48:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 347CB3CA710
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 09:48:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B9071400DA0
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 09:48:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC3741F37F;
 Fri, 29 Apr 2022 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651218520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmzcTIOXw3cIEMjBNZWqp9NjL+G0URw+pZ1cHZCGDIs=;
 b=CCtb921Bw0lqUu2QLM0pHl6SPVaofOB7WeMWqd52Ocy/TnEYvEgYmwNMOrwzdwVrsMnd57
 8gHN2Z/EhC+o+57u0Bx5/KKusj+YqRMt2B3npqCK+6u2qw7bBRBXZQaSQ4iBowwhueeg9w
 WU6zISGPr8d6SiISeL+ycb8fQMNC+r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651218520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmzcTIOXw3cIEMjBNZWqp9NjL+G0URw+pZ1cHZCGDIs=;
 b=ZnVxemIoSLBKdTRoYOUGgrFkB8jDWfklibp2/KgM9sP+7stNIWJ9F3HW5Lh80OgnexLE13
 BCWLVTQxsUB/U7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 693F213AE0;
 Fri, 29 Apr 2022 07:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0r/nF1iYa2JdUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Apr 2022 07:48:40 +0000
Date: Fri, 29 Apr 2022 09:48:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YmuYVtvPWxYarLEF@pevik>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: linux-nfs@vger.kernel.org, libtirpc-devel@lists.sourceforge.net,
 Steve Dickson <steved@redhat.com>, "J . Bruce Fields" <bfields@fieldses.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@hammerspace.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I'm sorry, I again used the old mail address of automated-testing ML.
Please have look at this patchset:

https://lore.kernel.org/ltp/20220428144308.32639-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=297407&state=*

Kind regards,
Petr

> Hi all,

> IMHO safe to remove these two tests, but sending to broad audience in
> case anybody really want to have these 2 kept (they'd be rewritten to
> new LTP shell API).

> BTW in long term I'd prefer to remove all RPC tests
> (testcases/network/rpc/ directory). IMHO they should be part of libtirpc
> (which has no tests), but these tests are old, messy and I'm not sure
> how relevant they are nowadays.

> Kind regards,
> Petr

> Petr Vorel (3):
>   rpc: Remove rup01.sh test
>   rpc: Remove rusers01.sh test
>   rpc: Move rest of RPC tests to runtest/net.rpc_tests

>  runtest/net.rpc                               |  8 ---
>  runtest/net.rpc_tests                         |  3 ++
>  scenario_groups/network                       |  1 -
>  .../network/rpc/basic_tests/rup/Makefile      | 29 -----------
>  .../network/rpc/basic_tests/rup/rup01.sh      | 50 -------------------
>  .../network/rpc/basic_tests/rusers/Makefile   | 29 -----------
>  .../rpc/basic_tests/rusers/rusers01.sh        | 50 -------------------
>  testscripts/network.sh                        |  4 +-
>  8 files changed, 4 insertions(+), 170 deletions(-)
>  delete mode 100644 runtest/net.rpc
>  delete mode 100644 testcases/network/rpc/basic_tests/rup/Makefile
>  delete mode 100755 testcases/network/rpc/basic_tests/rup/rup01.sh
>  delete mode 100644 testcases/network/rpc/basic_tests/rusers/Makefile
>  delete mode 100755 testcases/network/rpc/basic_tests/rusers/rusers01.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
