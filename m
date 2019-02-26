From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Feb 2019 01:35:30 +0100
Subject: [LTP] [PATCH] Define __SIGRTMIN and __SIGRTMAX for MUSL
In-Reply-To: <20190221164213.4952-1-daniel.diaz@linaro.org>
References: <20190221164213.4952-1-daniel.diaz@linaro.org>
Message-ID: <20190226003530.GA13898@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Daniel,

> Some libc implementations might differ in the definitions they
> include. Exempli gratia: MUSL does not define __SIGRTMAX nor
> __SIGRTMIN.

> These two tests fail to build because of the missing
> definitions:
>   testcases/kernel/syscalls/ptrace/ptrace05.c
>   testcases/kernel/syscalls/sighold/sighold02.c

> Out of precaution, these two also include this header:
>   lib/tst_sig.c
>   testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c

Thanks, merged!

Kind regards,
Petr
