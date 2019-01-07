From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 07 Jan 2019 11:14:58 +0100
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent
	hit accidental break
In-Reply-To: <CAEemH2eq49h48bxe17i3c_GWrbhTAHQMHr0t1_rwEdZvccJ-mg@mail.gmail.com>
References: <20190104095256.12266-1-liwang@redhat.com>
 <878t00mpnl.fsf@rpws.prws.suse.cz>
 <CAEemH2eq49h48bxe17i3c_GWrbhTAHQMHr0t1_rwEdZvccJ-mg@mail.gmail.com>
Message-ID: <877efgn599.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>
>> This is how it worked before, so it is fairly safe. However I don't like
>> atomically checking for the exit value on every spin of the delay
>> loop. Also because setting exit just causes it to drop through there is
>> still the (theoretical) risk of it getting stuck on another operation
>> before breaking out of thread B's main loop.
>
> Yes, and I noticed you removed the exit checking in last update, but I
> didn't realize that thread B will fall into infinite loop when parent
> is break abnormally.

Me too :-)

>
>>
>> Also removing the exit variable makes formal verification a bit easier.
>
> Good point.
>
>>
>> Another option might be to use pthread_kill with a realtime signal and
>> a signal handler which immediately exits the current thread. I am not
>> sure how much complexity that will introduce though?
>
> Well we can have a try, seems the only disadvantage of this method is
> thread_B sets signal handler at each loop start in tst_fzsync_run_b
> repeatedly.

We could wrap thread B's main function 'run_b', which is passed to
tst_fzsync_pair_reset, in another function which sets the singal handler
at the start of the thread.

>
> Not sure if I understand correctly, what drafted in my mind is:
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index de0402c9b..6ef6bee01 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -63,6 +63,8 @@
>  #include <time.h>
>  #include <math.h>
>  #include <stdlib.h>
> +#include <pthread.h>
> +#include <errno.h>
>  #include "tst_atomic.h"
>  #include "tst_timer.h"
>  #include "tst_safe_pthread.h"
> @@ -156,8 +158,6 @@ struct tst_fzsync_pair {
>         int a_cntr;
>         /** Internal; Atomic counter used by fzsync_pair_wait() */
>         int b_cntr;
> -       /** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
> -       int exit;

I was thinking of keeping the exit variable and using the kill signal as
a backup. The reason being it should allow thread B to exit gracefully
in most scenarious. In theory this should not matter because the test
writer should not do any setup in thread B, but it might result in some
wierd error/warning messages being printed for some tests.

Unfortunately pthread_join has no timeout and pthread_timedjoin_np is
non-standard.

Another option might be to spin-wait for 'exit' to be incremented to 2
by thread B and send the signal after some arbitrarily large number of
spins. What do you think?

--
Thank you,
Richard.
