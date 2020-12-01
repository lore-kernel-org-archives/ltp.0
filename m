From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Dec 2020 18:46:23 +0100
Subject: [LTP] [PATCH v5 00/10] Introduce SAFE_FANOTIFY_MARK() macro +
 cleanup
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <X8aBb86Z2+SYp0sr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Changes v4->v5:
...
> Petr Vorel (10):
>   fanotify12: Drop incorrect hint
>   fanotify: Add helper for access permission check
>   fanotify: Add helper for event support check
>   fanotify: Add helper for FAN_REPORT_FID support on fs
>   fanotify16: Test also on FUSE
>   fanotify: Add helper for mark support check
>   fanotify: Introduce SAFE_FANOTIFY_MARK() macro
>   fanotify: Use tst_brk_ in safe_fanotify_init()
>   fanotify: Add a pedantic check for return value

>   fanotify: Cleanup <sys/fanotify.h> use
I omit v5 from this patchset [1], it should have been part of v5.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20201201174214.24625-11-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=217855&state=*
