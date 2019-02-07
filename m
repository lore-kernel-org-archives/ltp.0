From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 7 Feb 2019 10:36:17 -0200
Subject: [LTP] [PATCH 1/2] syscalls/clock_gettime: create syscall
 clock_gettime tests
In-Reply-To: <20190207123137.GA9277@rei>
References: <20190206171703.5761-1-rafael.tinoco@linaro.org>
 <20190207123137.GA9277@rei>
Message-ID: <85F9DAC4-4CE2-4F83-A2EC-6576C87541F6@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hey o/

> On 7 Feb 2019, at 10:31, Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> Hi!
>> +struct test_case {
>> +	clockid_t clocktype;
>> +	int exp_ret;
>> +	int exp_err;
>> +	int unsupported;
>> +};
>> +
>> +struct test_case tc[] = {
>> +	{
>> +	 .clocktype = CLOCK_REALTIME,
>> +	 },
>> +	{
>> +	 .clocktype = CLOCK_REALTIME_COARSE,
>> +#ifndef CLOCK_REALTIME_COARSE
>> +	 .exp_ret = -1,
>> +	 .exp_err = EINVAL,
>> +#endif
> 
> Depending on the constant beind defined is completely wrong here. The
> only way how to figure out if the clock is being supported or not is to
> call the clock_gettime() with correct paramters and check for EINVAL.
> 

Yes I had doubts about compilation vs runtime also for the #ifndefs. 

> So I guess that in this test we should call clock_gettime() for
> paticular clock and:
> 
> * For certain clocks that are implemented for long enough, we expect
>  success, I would say that at least CLOCK_REALTIME, CLOCK_MONOTONIC and
>  CLOCK_*_CPUTIME_ID should be implemented for long enough to be
>  supported everywhere

Alright.

> 
> * The rest of the clocks should be allowed either to pass or return EINVAL
> 

Makes sense.

> * In case that the call passed we should check that the timespec has
>  been changed (we should zero it before the call)

Ok.

> * Also many architectures have vDSO for clock_gettime() we should also
>  check that the syscall and vDSO are consistent in this case


Alright, will force the syscall and later use regular libc call to wrap into vDSO is available. 

Thanks for the feedback!

Rafael
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190207/88b0bdb1/attachment-0001.html>
