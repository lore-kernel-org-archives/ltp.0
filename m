Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C14EE7C4D0
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 15:21:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1D33CDB25
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 17:21:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 143A73CB970
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 17:21:06 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 400591A00CB2
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 17:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eaj1nbQztuhuKccelZ+BQOCrDtJWkbonrfoX2OcHEf8=; b=NPild/7HWayzPN9o6aB/lvZgqR
 3AAetf6Vlv18epSXaRzQgzifZMAtKNAaZnYUScKzwLkyyLYJcG5FpDUkD5Yg3kknu6K9XFJvI1Lr9
 BBmMksvCuA8jkKKlj2JcJq8LSCP+GjzT/otm1FanxBEnZ64BWzXWl9dCUKTwvmlvx3UTl3K9RyDne
 jt9MrFZkmDukHkwTRhtjPldmkAaVQkyNLHrZuapW1rl79aMSR6aKFjrqVmaxJE9sUeKhTBh2YITAL
 arG8e6R+7RKW5BU56LQqHTev+9EnRdXmjr82NtnYGr3Lvtz2q/nYXckT4Ft4QFPeFb9v89WV5BUPh
 bCxzc2hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1qo3gN-0045Fx-66; Wed, 04 Oct 2023 15:21:03 +0000
Date: Wed, 4 Oct 2023 16:21:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZR2C38vzil+dy6ZO@casper.infradead.org>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231004124712.3833-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Add tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 04, 2023 at 02:47:10PM +0200, Cyril Hrubis wrote:
> +enum tst_fd_type {
> +	TST_FD_FILE,
> +	TST_FD_DIR,
> +	TST_FD_DEV_ZERO,
> +	TST_FD_PROC_MAPS,
> +	TST_FD_PIPE_IN,
> +	TST_FD_PIPE_OUT,
> +	TST_FD_UNIX_SOCK,
> +	TST_FD_INET_SOCK,
> +	TST_FD_IO_URING,
> +	TST_FD_BPF_MAP,
> +	TST_FD_MAX,
> +};

This looks great!  Thanks for turning my musing into concrete code.
Some other file descriptor types that might be interesting ...

O_PATH (see openat(2); some variants on this like opening a symlink with
O_NOFOLLOW)

epoll
eventfd
signalfd
timerfd_create
pidfd_open
fanotify_init
inotify
userfaultfd
perf_event_open
fsopen
fspick
fsmount
open_tree
secretmem
memfd

(i used a variety of techniques for thinking of these, including
grepping for CLOEXEC and fd_install)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
