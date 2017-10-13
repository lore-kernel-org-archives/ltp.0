From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 13 Oct 2017 10:58:55 +0200
Subject: [LTP] [PATCH 1/2] POSIX: Allow pthread_barrier_destroy() to
	block
In-Reply-To: <20171012133442.GB21253@rei>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-2-rpalethorpe@suse.com> <20171012133442.GB21253@rei>
Message-ID: <87infj77ao.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

>> -	/* Cleanup (cancel thread in case it is still blocking */
>> +	printf("Test PASSED\n");
>
> What about we fail the test in a case that we do not get either of
> success or EBUSY? I doubt that there is any harm in making this kind of
> check here with the watchdog thread in place.
>

I suppose it would be misleading if it returned EINVAL, but it would
only be an error if it returned EINTR because that is specifically
prohibited by the spec.

Thinking about it, it is all undefined behaviour, but the test is to see
if it complies with the recommended behviour. So maybe we should fail
the test if it does not return EBUSY. If someone doesn't agree with the
recommended behaviour they can ignore the test.

I don't have a strong opinion on whether the test should pass or
fail. However I would like to have some clear rules to follow for the
POSIX tests. Like "If it is undefined behaviour then anything except a
null pointer derefernce or buffer overflow is acceptable". So basically
any behaviour that isn't obviously a security/integrity concern is OK. Or
something like "If it is undefined behaviour then we check if it follows
the recommended behaviour", and make it clear in the test description
that this test may fail on a compliant implementation.

-- 
Thank you,
Richard.
