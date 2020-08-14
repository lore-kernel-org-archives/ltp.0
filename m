From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Aug 2020 17:38:03 +0200
Subject: [LTP] [PATCH 2/4] Update tests to new taint check API
In-Reply-To: <20200811130502.12010-2-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <20200811130502.12010-2-mdoucha@suse.cz>
Message-ID: <20200814153803.GB30390@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> These are just trivial changes of tst_taint_init(mask) to .taint_check = mask.
> I intentionally didn't remove any tst_taint_check() calls here.

>  testcases/cve/cve-2017-17053.c                        | 4 +---
>  testcases/kernel/pty/pty05.c                          | 4 +---
>  testcases/kernel/sound/snd_seq01.c                    | 3 +--
>  testcases/kernel/sound/snd_timer01.c                  | 3 +--
>  testcases/kernel/syscalls/connect/connect02.c         | 4 +---
>  testcases/kernel/syscalls/sendmsg/sendmsg03.c         | 3 +--
>  testcases/kernel/syscalls/setsockopt/setsockopt05.c   | 7 +++----
>  testcases/kernel/syscalls/setsockopt/setsockopt06.c   | 4 +---
>  testcases/kernel/syscalls/timerfd/timerfd_settime02.c | 3 +--
>  9 files changed, 11 insertions(+), 24 deletions(-)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Have you tried to use .taint_check also for testcases/kernel/crypto/af_alg07.c
and testcases/kernel/syscalls/bpf/bpf_prog04.c?

Kind regards,
Petr
