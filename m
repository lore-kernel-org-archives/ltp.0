From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 16 Aug 2018 15:06:28 +0200
Subject: [LTP] [PATCH v3 3/4] tst_timer: Create interface for using
	multiple timers
In-Reply-To: <20180816122728.GE6547@rei>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-3-rpalethorpe@suse.com> <20180816122247.GD6547@rei>
 <20180816122728.GE6547@rei>
Message-ID: <87a7pm4g17.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > +/**
>> > + * Encapsulates a stopwatch timer.
>> > + *
>> > + * Useful when you need to use multiple timers in a single test.
>> > + */
>> > +struct tst_timer {
>> > +	/** The POSIX clock type  */
>> > +	clockid_t clock_id;
>> > +	/** How much time can pass before tst_timer_expired_st() returns true */
>> > +	struct timespec limit;
>> > +	/** Where to start measuring time from */
>> > +	struct timespec start_time;
>> > +};
>
> On a related note, do you really think that we will need nsec resoltion
> for the timeout timers? I would say that keeping the limit as unsigned
> integer holding number of seconds would be more than enough.

I agree that seconds are appropriate for test timeouts, but it is
practically 'free' to use the struct here because of the existing API to
compare timespec structs. Also I might use this interface to time
syscalls and maybe remove some code duplication.

--
Thank you,
Richard.
