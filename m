From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 13:45:36 +0200
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
In-Reply-To: <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
 <20200911095314.GA9505@dell5510>
 <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
Message-ID: <20200911114536.GA14099@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> On 11-09-20, 11:53, Petr Vorel wrote:
> > Hi Viresh,
> > One of the commits fails on various tests [1].

> > Some failures (I haven't checked all):

> > * missing nfds_t (<poll.h> is probably from old commits) [2]:

> > CC testcases/kernel/syscalls/mq_open/mq_open01
> > In file included from ../../../../include/time64_variants.h:13,
> >                  from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
> >                  from mq_timedreceive01.c:17:
> > /usr/include/sys/poll.h:1:2: warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]
> >     1 | #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
> >       |  ^~~~~~~
> > In file included from /usr/src/ltp/testcases/kernel/syscalls/mq_timedreceive/../utils/mq_timed.h:10,
> >                  from mq_timedreceive01.c:17:
> > ../../../../include/time64_variants.h:41:35: error: unknown type name 'nfds_t'
> > 41 |  int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,

> > * <libaio.h> not found [3]:
> > BUILD libltpnewipc.a
> > make[6]: Nothing to be done for 'all'.
> > In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop02.c:29:
> > In file included from In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop01.c:15:
> > In file included from /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h:7:
> > /usr/src/ltp/include/time64_variants.h:10:10: fatal error: /usr/src/ltp/testcases/kernel/syscalls/ipc/semop/semop.h'libaio.h' file not
> >       found
> > :7:
> > /usr/src/ltp/include/time64_variants.h:10:10: fatal error: 'libaio.h' file#include <libaio.h>
> >          ^~~~~~~~~~
> >  not
> >       found
> > #include <libaio.h>

> I didn't get any of these on my x86 box :(

This is also confusing for me.

Maybe enable travis CI builds for your ltp fork?
You contribute a lot, catching bugs early would be great.

Kind regards,
Petr
