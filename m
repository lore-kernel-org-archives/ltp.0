From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 08 Jan 2019 13:48:59 +0100
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent
	hit accidental break
In-Reply-To: <CAEemH2dQ5HCm74JdW4LWFSUH9ngk1-KbCKrpC2D-m+kAH03oTw@mail.gmail.com>
References: <20190104095256.12266-1-liwang@redhat.com>
 <878t00mpnl.fsf@rpws.prws.suse.cz>
 <CAEemH2eq49h48bxe17i3c_GWrbhTAHQMHr0t1_rwEdZvccJ-mg@mail.gmail.com>
 <877efgn599.fsf@rpws.prws.suse.cz>
 <CAEemH2dQ5HCm74JdW4LWFSUH9ngk1-KbCKrpC2D-m+kAH03oTw@mail.gmail.com>
Message-ID: <875zuzmi10.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>> > Well we can have a try, seems the only disadvantage of this method is
>> > thread_B sets signal handler at each loop start in tst_fzsync_run_b
>> > repeatedly.
>>
>> We could wrap thread B's main function 'run_b', which is passed to
>> tst_fzsync_pair_reset, in another function which sets the singal handler
>> at the start of the thread.
>
> Good suggestion! This make sense to me.
>
>> > -       /** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
>> > -       int exit;
>>
>> I was thinking of keeping the exit variable and using the kill signal as
>> a backup. The reason being it should allow thread B to exit gracefully
>> in most scenarious. In theory this should not matter because the test
>> writer should not do any setup in thread B, but it might result in some
>> wierd error/warning messages being printed for some tests.
>
> Yes, that's not a bad solution, but I was a little worried before is
> that would make things a bit mixed for the thread exiting. However, if
> we use pair->exit only for normal exiting and signal for unexpected
> abort, that's also accessible I guess.
>
>>
>> Unfortunately pthread_join has no timeout and pthread_timedjoin_np is
>> non-standard.
>
> or maybe we could achieve a LTP private pthread_timedjoin_np version? I haven't
> look into more about that so have no idea for the detail/complexity.
>
>>
>> Another option might be to spin-wait for 'exit' to be incremented to 2
>> by thread B and send the signal after some arbitrarily large number of
>> spins. What do you think?
>
> Hmm, what's the best value for arbitrarily large number? it seems hard
> to decide.
>
> Comparing the above approaches, currently it's hard to say which one
> is better. If I have to make a choice, I'd like to try the first
> method: pair->exit (for normal exiting) + signal(for unexpected
> abort).

Yes, this is better than adding another arbitrary constant IMO.

--
Thank you,
Richard.
