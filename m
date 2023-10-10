Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB44CD691F
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 10:16:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4F7A3CD722
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 12:16:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABB683C894B
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 12:15:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E41A5600728
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 12:15:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 15CD91F45E;
 Tue, 10 Oct 2023 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696932957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQtlowriA+YahhOUT6zQdsZAtOZFgXeWZ5jWHYtFuhE=;
 b=H/KumeFhsdD7hIZ8Doqb3rPnwutGTmy6sYi1/UJqICfC4+qrLU9eFhqoZhbiNB5x7zimYE
 RP7nZxJfc721nbUOjgDSMAfwEQE5BVgwLcAKpb2NO1KSG3Nu44uvQjCPeZR4c8/EKZxwMx
 9MYNq03fLmUpRYE1HBDy/kgaIPKeLYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696932957;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQtlowriA+YahhOUT6zQdsZAtOZFgXeWZ5jWHYtFuhE=;
 b=XJGY1hlLr89DS8IcwCxSq8aB3kjqI9XPbV9NwUQ3FPIs+HE326TucDNu6QAnjR9wK7SUUa
 anawRj7DpHhKWkDg==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 851BB2C3F7;
 Tue, 10 Oct 2023 10:15:56 +0000 (UTC)
References: <20231004124712.3833-1-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2023 11:13:59 +0100
Organization: Linux Private Site
In-reply-to: <20231004124712.3833-1-chrubis@suse.cz>
Message-ID: <87o7h6zsth.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

>  - adds tst_iterate_fd() functionality
>  - make use of tst_iterate_fd() in readahead01
>  - add accept03 test which uses tst_iterate_fd()
>
> This is a prototype for how the functionality to iterate over different
> file descriptors should look like it converts one tests and adds
> another. There is plenty of other syscalls that can use this kind of
> testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
> plan is to add these if/once we agree on the API.

I imagine the results of using this with splice could be very interesting.

>
> Cyril Hrubis (3):
>   lib: Add tst_fd_iterate()
>   syscalls/readahead01: Make use of tst_fd_iterate()
>   syscalls: accept: Add tst_fd_iterate() test
>
>  include/tst_fd.h                              |  39 ++++++
>  include/tst_test.h                            |   1 +
>  lib/tst_fd.c                                  | 116 ++++++++++++++++++
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/accept/.gitignore   |   1 +
>  testcases/kernel/syscalls/accept/accept01.c   |   8 --
>  testcases/kernel/syscalls/accept/accept03.c   |  46 +++++++
>  .../kernel/syscalls/readahead/readahead01.c   |  46 +++----
>  8 files changed, 224 insertions(+), 34 deletions(-)
>  create mode 100644 include/tst_fd.h
>  create mode 100644 lib/tst_fd.c
>  create mode 100644 testcases/kernel/syscalls/accept/accept03.c
>
> -- 
> 2.41.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
