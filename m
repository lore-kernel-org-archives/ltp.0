From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 13 Oct 2017 14:57:19 +0200
Subject: [LTP] [PATCH 1/2] POSIX: Allow pthread_barrier_destroy() to
	block
In-Reply-To: <20171013093741.GB32278@rei>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-2-rpalethorpe@suse.com> <20171012133442.GB21253@rei>
 <87infj77ao.fsf@our.domain.is.not.set> <20171013093741.GB32278@rei>
Message-ID: <87fuan6w9c.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> >> -	/* Cleanup (cancel thread in case it is still blocking */
>> >> +	printf("Test PASSED\n");
>> >
>> > What about we fail the test in a case that we do not get either of
>> > success or EBUSY? I doubt that there is any harm in making this kind of
>> > check here with the watchdog thread in place.
>> >
>> 
>> I suppose it would be misleading if it returned EINVAL, but it would
>> only be an error if it returned EINTR because that is specifically
>> prohibited by the spec.
>> 
>> Thinking about it, it is all undefined behaviour, but the test is to see
>> if it complies with the recommended behviour. So maybe we should fail
>> the test if it does not return EBUSY. If someone doesn't agree with the
>> recommended behaviour they can ignore the test.
>
> The open posix testsuite has PTS_UNSUPPORTED status that is used when
> optional part of the POSIX standard is not implemented, that makes much
> more sense than fail in this case.
>
>> I don't have a strong opinion on whether the test should pass or
>> fail. However I would like to have some clear rules to follow for the
>> POSIX tests. Like "If it is undefined behaviour then anything except a
>> null pointer derefernce or buffer overflow is acceptable". So basically
>> any behaviour that isn't obviously a security/integrity concern is OK. Or
>> something like "If it is undefined behaviour then we check if it follows
>> the recommended behaviour", and make it clear in the test description
>> that this test may fail on a compliant implementation.
>
> My intent with these testcases was always to make them first class
> citizen on Linux but at the same time keep them working on any other
> Unix. The fact that Linux does not implement most of the optional
> features makes it a bit more complicated though.
>
> So in this case I would go for passing the test only if the optional
> EBUSY error is implemented and return UNSUPPORTED otherwise. I would
> still keep the code with watchdog there so that the case that the call
> blocks until the barrier is in use blocks is handled gracefully though.
>
> Does that sound reasonable?
>
> And yes I think that keeping the test just to see if we cannot get
> SegFault or something in this case is valuable even though POSIX
> technically allows such behavior.

Yes, this makes perfect sense!

-- 
Thank you,
Richard.
