From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 16 Aug 2018 13:40:24 +0200
Subject: [LTP] [PATCH v2 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <CAEemH2f_Wg+MgdNoqXPotmq4gJaBZOJKX_kMtY=0ubZ6LkT5vg@mail.gmail.com>
References: <20180813135908.30752-1-rpalethorpe@suse.com>
 <20180813135908.30752-4-rpalethorpe@suse.com>
 <87in4c3spd.fsf@rpws.prws.suse.cz>
 <CAEemH2f_Wg+MgdNoqXPotmq4gJaBZOJKX_kMtY=0ubZ6LkT5vg@mail.gmail.com>
Message-ID: <87d0ui4k0n.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>>
>> Richard Palethorpe <rpalethorpe@suse.com> writes:
>>
>> >  /**
>> >   * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
>> >   *
>> > @@ -301,10 +311,26 @@ static inline int tst_fzsync_wait_b(struct
>> tst_fzsync_pair *pair)
>> >  static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair
>> *pair)
>> >  {
>> >       static int loop_index;
>> > +     int timer_state = tst_timer_state_ms(60000);
>> > +     int exit = 0;
>> > +
>> > +     if (!(timer_state & TST_TIMER_STARTED)) {
>> > +             tst_timer_start(CLOCK_MONOTONIC_RAW);
>> > +     } else if (timer_state & TST_TIMER_EXPIRED) {
>> > +             tst_res(TINFO,
>> > +                     "Exceeded fuzzy sync time limit, requesting exit");
>> > +             exit = 1;
>>
>> This is not going to work with the -i argument or if the test author
>> also wants to use tst_timer. I'm going to have to do something
>> different.
>
>
> Yes, good catch. I didn't realized that when reviewing the patch.
>
> Maybe we can try to leave the expired time judgement in fzync library and
> without using any LTP timer API. But for the -i parameter, it seems hard to
> set pair->exit to 0 at a proper time :(.

I have another patch set which allows multiple timers to be used with
tst_timer which I will post soon.

>
> Now I'm thinking that why not to redesign/improve the fzync first and then
> solve the timeout issue. It will be easier than current situation I guess.

Redesigning fzsync is much more difficult in my opinion. At least
cve-2016-7117[1] relies on the delay feature so I can't simply remove it
like I previously said.

The race condition happens on the exit from the recvmmesg and close
syscalls. Close takes a fraction of the time recvmmesg does to execute
so synchronising the two threads before making these syscalls does not
work. They need to be synchronised just as the syscalls are both
exiting. Which requires the close call to be delayed.

We currently do this by taking time stamps at the exit of each
systemcall and using the delay function to try and synchronise these two
points. So that we end up with a time line which looks like the
following (assuming everything worked perfectly):

wait_update        time_stamp
   ^                       ^
   | +--------+ +-------+  |
---|-|  delay |-| close |--|-- - -
   | +--------+ +-------+  |
   | +------------------+  |
---|-|     recvmmesg    |--|-- - -
   | +------------------+  |

With the updated API which I proposed we would get something like the
diagram below where the start of close and recvmmesg are synced. Because
recvmmesg takes so much longer to reach its exit code than close, the
race has an extremely low probability of happening.

start_race     end_race
   ^            ^
   | +-------+  |-------+ |
---|-| close |--| wait  |-|-- - -
   | +-------+  +-------+ |
   | +------------------+ |
---|-|     recvmmesg    |-|-- - -
   | +------------------+ |
                          ^
                         end_race

However this doesn't mean the new API is bad, it just means that it has
to detect that close happens much quicker than recvmmesg and introduce
some random delay before the close. This is non-trivial because we have
to calculate the delay (in spin cycles) from timestamps (in nanoseconds)
taken during start_race and end_race, plus the spin cycles spent waiting
in end_race. On some CPUs the clock's resolution may not be good enough
to get an accurate delta between any of the timestamps, so we will just
have the number cycles spent during wait to work with.

[1] This test is currently quite unreliable, but it at least works
sometimes.

--
Thank you,
Richard.
