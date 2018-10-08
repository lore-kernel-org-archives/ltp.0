From: Eric W. Biederman <ebiederm@xmission.com>
Date: Mon, 08 Oct 2018 17:52:57 +0200
Subject: [LTP] rt_sigqueueinfo: Invalid argument
In-Reply-To: <CA+G9fYvK4CBeAzcvzh1w5bcq9tgpFpum5yTjrnCxYQHmfzJ4_A@mail.gmail.com>
 (Naresh Kamboju's message of "Mon, 8 Oct 2018 20:22:00 +0530")
References: <CA+G9fYtxvj0j6BVVZ_YoBkZn6m6ZpEMmDjBjwqY7uvpgMbNQbQ@mail.gmail.com>
 <20181008124541.GB13162@rei.lan>
 <695083613.56872050.1539003986782.JavaMail.zimbra@redhat.com>
 <CA+G9fYvK4CBeAzcvzh1w5bcq9tgpFpum5yTjrnCxYQHmfzJ4_A@mail.gmail.com>
Message-ID: <87va6cwi3q.fsf@xmission.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> + Eric
>
> Eric,
> If you have any comments.
> Good note is that, you broke the test and we need to fix it for better
> test coverage :-)


Ok.  So I have tracked down the test and I think I see what is going on.
I believe this is the source code to your failing test:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c

There are two cases I have changed that might possibly break something.
One was verifying that si_signo matched sig.  This is my second report
and it feels credible that that change was a regression in userspace and
I have fixed that in my development branch and that should be showing
up in linux-next in a day or so.

The other change is verifying that the tail end of siginfo_t is 0 if
we don't recognize the si_code.  In this case SI_QUEUE is hard coded
so that check should not be coming into play.

Thank you for letting me know this broke an ltp test.

I was hoping that no one would care but it is clear now that people
really do ignore si_signo in favor of the signal parameter of the system
call.  So not fixing this would be introducing regressions in
applications.

Eric

> Thank you.
>
> On Mon, 8 Oct 2018 at 18:36, Jan Stancek <jstancek@redhat.com> wrote:
>>
>>
>>
>> ----- Original Message -----
>> > Hi!
>> > > rt_sigqueueinfo01 failed on all device (x86_64, i386, arm / arm64)
>> > > started failing from Linux version 4.19.0-rc6-next-20181004.
>> > > Do you see this failure at your end?
>> > >
>> > > rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
>> > > rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
>> > > rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
>> > > rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
>> > > rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
>> > > rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
>> > > rt_sigqueueinfo01    2  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
>> > >
>> > > Full log  details.
>> > > https://lkft.validation.linaro.org/scheduler/job/451548#L10339
>> >
>> > I do not recall seeing this test to fail.
>> >
>> > However the test is old messy code, one thing that I guess may happen is
>> > that there is random garbage in the siginfo_t structure we pass to the
>> > syscall and in you case you were unlucky enough so that kernel rejects
>> > the value, but that is just wild guess.
>>
>
> Jan,
>
>> Mainline doesn't seem to mind if we pass garbage atm. (4.19-rc7)
>> but we should initialize entire struct anyway.
>>
>> In -next there is:
>>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/signal.c?id=e75dc036c445b91b8b2ad4e6c9b05f04b6be6d3f
>> and test doesn't set si_signo.
>
> Thanks for the quick reply.
> This help me a lot.
>
>>
>> Regards,
>> Jan
>>
>> >
>
> Cyril,
>
>> > Btw, I've opened an issue to clean up the test in:
>> >
>> > https://github.com/linux-test-project/ltp/issues/404
>
> Thanks for creating an issue. I have subscribed to this one.
>
> - Naresh
>
>> >
>> > --
>> > Cyril Hrubis
>> > chrubis@suse.cz
>> >
