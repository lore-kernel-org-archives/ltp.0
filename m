Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C1C05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 10:36:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EDFC3CBF68
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 11:36:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412C63C9C7B
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 11:36:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49428600800
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 11:36:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0AA6D1F8B6;
 Tue, 14 Feb 2023 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676370992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G77DMNFvGEK70MovKGgj0tH/GIhD1iJDbk/7RrMk9Co=;
 b=Hqr77kHQ4wnGZUDX7YcQiLgxlPOpIBuCbqx3ExcRrNQeRBaZx02jIXTrCcke48FiiBo94W
 FSlioctNXvv7C2N+uXcFGqi3cXyl48k99pM2XcncpZrnEPankhbWchsejzI2LtPYQPBO7e
 KT7tI4J1Q3adwS3OhOEBWvercxuNjgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676370992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G77DMNFvGEK70MovKGgj0tH/GIhD1iJDbk/7RrMk9Co=;
 b=yp0I7UQpAXKzmgHY6tTqsN3M7wBTI5f+rbLHHLAah35+Aq1Ih4oIoqdI0WxjkkP6YSq0Cz
 s/0QjF44SRDfBnDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CD2782C141;
 Tue, 14 Feb 2023 10:36:31 +0000 (UTC)
References: <20230210171601.19047-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 14 Feb 2023 10:36:18 +0000
Organization: Linux Private Site
In-reply-to: <20230210171601.19047-1-andrea.cervesato@suse.com>
Message-ID: <87edqso7o0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/2] Rewrite utstest suite
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Added new tests and removed utstest which looked broken.
>
> Andrea Cervesato (2):
>   Add SAFE_SETHOSTNAME macro
>   Rewrite utsname testing suite
>
>  include/safe_net_fn.h                         |   3 +
>  include/tst_safe_net.h                        |   3 +
>  lib/safe_net.c                                |  17 +
>  runtest/containers                            |  16 +-
>  .../kernel/containers/utsname/.gitignore      |   5 +-
>  testcases/kernel/containers/utsname/Makefile  |  23 +-
>  .../containers/utsname/runutstests_noltp.sh   |  41 --
>  .../kernel/containers/utsname/utsname01.c     |  56 +++
>  .../kernel/containers/utsname/utsname02.c     |  81 ++++
>  .../kernel/containers/utsname/utsname03.c     | 118 ++++++
>  .../kernel/containers/utsname/utsname04.c     |  52 +++
>  testcases/kernel/containers/utsname/utstest.c | 353 ------------------
>  12 files changed, 343 insertions(+), 425 deletions(-)
>  delete mode 100755 testcases/kernel/containers/utsname/runutstests_noltp.sh
>  create mode 100644 testcases/kernel/containers/utsname/utsname01.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname02.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname03.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname04.c
>  delete mode 100644 testcases/kernel/containers/utsname/utstest.c
>
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
