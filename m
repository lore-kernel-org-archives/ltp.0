From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 09 Apr 2018 12:55:18 +0200
Subject: [LTP] [RFC PATCH] read_all: give more time to wait children
	finish read action
In-Reply-To: <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
References: <1523092180-5365-1-git-send-email-liwang@redhat.com>
 <87r2nox1s9.fsf@rpws.prws.suse.cz>
 <CAEemH2cSXtQfiM4snXAL-Eof7Xe3aY50z8ce=K4yo6=yBqtEbA@mail.gmail.com>
Message-ID: <87po38wsx5.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


Li Wang writes:

> Hi Richard,
>
>
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>>
>> Li Wang writes:
>>
>> > 1. Some children are still working on the read I/O but parent trys to
>> > stopping them after visit_dir() immediately. Although the stop_attemps
>> > is 65535, it still sometimes fails, so we get the following worker
>> > stalled messges in test.
>> >
>> >  # uname -rm
>> >    4.16.0-rc7 ppc64
>> >  # ./read_all -d /sys -q -r 10
>> >    tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
>> >    read_all.c:280: BROK: Worker 26075 is stalled
>> >    read_all.c:280: WARN: Worker 26075 is stalled
>> >    read_all.c:280: WARN: Worker 26079 is stalled
>> >    read_all.c:280: WARN: Worker 26087 is stalled
>>
>> wow, three workers have there queues perfectly filled... I guess I
>> accidentally created a brute force box packing algorithm.
>>
>> >
>> > 2. The sched_work() push action in a infinite loop, here I propose to let
>> > it in limited times.
>>
>> I think this is moving the problem instead of solving it. Increasing the
>> number of stop_attempts should have the same effect unless the workers
>> are permanently blocked on I/O. However this might be better because it
>> removes the sleep.
>>
>
> ​Hmm, not sure if you're fully get my point, maybe I(apologize!) shouldn't
> fix two
> problems in one patch.
>
> For the block I/O issue, I just adding 'usleep(100)​' in stop_workers()
> function.
> You suggest increasing stop_attempts is also accessible, but without sleep
> it still very fast to finish the loop and probably we need a very large
> number
> for stop_attempt to waste time.
>
> For the second change in sched_work() is just to guarantee we can exist the
> infinite loop if something wrong with queue_push action.

An infinite loop is not a big problem because the test library will
timeout, but not knowing what caused the timeout is a problem.

When writing the test I was not sure if timeouts would be a problem, but
from your testing it appears that it is.

>
>
>
>>
>> Possibly we should actually try to determine if a worker is blocked
>> reading a file and print the file name.
>>
>
> You are right, I'm now still looking for a better way to avoid this block
> I/O issue.

Maybe you could add a field to the worker struct containing the current
file being read and a timestamp of when it started reading that
file. Then we can use that information later to find out if a particular
file is taking a long time to read.

>
>
>>
>> >
>> > Signed-off-by: Li Wang <liwang@redhat.com>
>> > ---
>> >  testcases/kernel/fs/read_all/read_all.c | 10 +++++++---
>> >  1 file changed, 7 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/testcases/kernel/fs/read_all/read_all.c
>> b/testcases/kernel/fs/read_all/read_all.c
>> > index b7ed540..ab206e7 100644
>> > --- a/testcases/kernel/fs/read_all/read_all.c
>> > +++ b/testcases/kernel/fs/read_all/read_all.c
>> > @@ -280,6 +280,7 @@ static void stop_workers(void)
>> >                                               workers[i].pid);
>> >                                       break;
>> >                               }
>> > +                             usleep(100);
>>
>>
>> >                       }
>> >               }
>> >       }
>> > @@ -306,9 +307,12 @@ static void sched_work(const char *path)
>> >               if (pushed)
>> >                       break;
>> >
>> > -             if (++push_attempts > worker_count) {
>> > -                     usleep(100);
>> > -                     push_attempts = 0;
>> > +             usleep(100);
>> > +             if (++push_attempts > 0xffff) {
>>
>> Maybe add another f to this.
>>
>
> ​No need too much attempt, my test says this push action can get pass less
> than try 20 times.

OK, I think this change is good except that using a constant time for
the usleep is probably bad. Instead we could use an exponential
function; so we can start with a sleep of 1 then double it up to a
maximum of 20 times (approximately a second for the final wait).

>
>
>
>>
>> > +                     tst_brk(TBROK,
>> > +                             "Attempts %d times but still failed to
>> push %s",
>> > +                             push_attempts, path);
>> > +                     break;
>> >               }
>> >       }
>> >  }
>>
>>
>> --
>> Thank you,
>> Richard.
>>


--
Thank you,
Richard.
