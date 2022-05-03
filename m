Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D82C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 21:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA403CA865
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 23:30:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D65773C9425
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:30:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27D9D200055
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:30:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67130210E7;
 Tue,  3 May 2022 21:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651613424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5tI+pXMmzNqNLbmJaclrUu9gLWhMDyON5CXq0AH3Ks=;
 b=VS5vAE0P0wV38lBjCWeZgIkpV3oC7ZSyfNwu3ENLaDWt9LyZVnqdfYPQNEEfLY0Vekwgmg
 GGcJhkkm58vQ/XjO7FkCNEtaIpeeByL5oSUAv9Koc3+yf9xH18NW+1dlz9v8i9Mv6Wj696
 hJPuVWT0PuJ2BuWQFZ2owqflHPjTqQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651613424;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5tI+pXMmzNqNLbmJaclrUu9gLWhMDyON5CXq0AH3Ks=;
 b=O14X5oREFYZT7VDiQ/3bLJG+FiyMcHfjGCPXqtQ0rM4A0IgZBw5uR3+t6GTPAgZ9NDj6ox
 iSr/ypYS9l5myuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3DEF13AA3;
 Tue,  3 May 2022 21:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1eUCLe+ecWKVCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 21:30:23 +0000
Date: Tue, 3 May 2022 23:30:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnGe7Z5mw03+UuLa@pevik>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-24-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220503174718.21205-24-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 23/30] fuzzy_sync: Convert
 to runtime
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> The runtime for fuzzy sync tests are computed as timeout * exec_time_p.
> The default timeout was 300 and the default was 0.5.

> CC: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fuzzy_sync.h                      | 19 ++++---------------
>  testcases/kernel/crypto/af_alg07.c            |  1 +
>  testcases/kernel/mem/thp/thp04.c              |  1 +
>  testcases/kernel/pty/pty03.c                  |  2 +-
>  testcases/kernel/pty/pty05.c                  |  1 +
>  testcases/kernel/pty/pty06.c                  |  1 +
>  testcases/kernel/pty/pty07.c                  |  1 +
>  testcases/kernel/sound/snd_seq01.c            |  2 +-
>  testcases/kernel/sound/snd_timer01.c          |  1 +
>  testcases/kernel/syscalls/bind/bind06.c       |  2 +-
>  testcases/kernel/syscalls/inotify/inotify09.c |  1 +
>  .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
>  testcases/kernel/syscalls/sendmsg/sendmsg03.c |  1 +
>  .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt07.c |  1 +
>  .../syscalls/timerfd/timerfd_settime02.c      |  1 +
>  testcases/kernel/syscalls/writev/writev03.c   |  2 +-
>  17 files changed, 20 insertions(+), 21 deletions(-)

FYI you haven't converted fuzzy sync tests.
I suppose these errors must be fix in first commit.

./tst_fuzzy_sync01
tst_test.c:1522: TINFO: Timeout per run is 0h 00m 30s
tst_test.c:1483: TBROK: Runtime not set!

./tst_fuzzy_sync02
tst_test.c:1522: TINFO: Timeout per run is 0h 00m 30s
tst_test.c:1483: TBROK: Runtime not set!

./tst_fuzzy_sync03
tst_test.c:1522: TINFO: Timeout per run is 0h 00m 30s
tst_test.c:1483: TBROK: Runtime not set!
tst_fuzzy_sync03.c:45: TFAIL: Worker performed wrong number of iterations: 0 != 65535


Only tst_fuzzy_sync03.c is run in CI:
https://github.com/pevik/ltp/runs/6280658557?check_suite_focus=true
/__w/ltp/ltp/lib/tst_test.c:1483: TBROK: Runtime not set!
/__w/ltp/ltp/lib/newlib_tests/tst_fuzzy_sync03.c:45: TFAIL: Worker performed wrong number of iterations: 0 != 65535

maybe after fix the other two might be possible to run in CI as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
