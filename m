From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 10 Jun 2020 11:47:36 +0530
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <CAK8P3a2BaLtcyyfNQUJq-gvO6C_53hvLaNhajcpREwqHCEBYqg@mail.gmail.com>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
 <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
 <CAK8P3a0PqtFWTZr9hvSy5Y0ZZOSNgfzw0x1DTTyuzfsfROpAvw@mail.gmail.com>
 <20200609070535.iym6m5n2v5urykbc@vireshk-i7>
 <CAK8P3a0giS2A=4Hc4SO7cVn_nOU4rz-KzbSkQJcddM2Hc=KRxg@mail.gmail.com>
 <20200609083219.5473zf2tq4tmjxac@vireshk-i7>
 <CAK8P3a2BaLtcyyfNQUJq-gvO6C_53hvLaNhajcpREwqHCEBYqg@mail.gmail.com>
Message-ID: <20200610061736.pozfqs4fh4wakdep@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-06-20, 10:51, Arnd Bergmann wrote:
> Yours only needs it when the nanoseconds are actually lower, which
> is only the case if no the actual time has not crossed into the next
> microsecond.

That is a very small percentage of cases I believe, and so I won't
count my version to be really better here :)

> If the gettimeofday() call itself takes over a microsecond
> to complete, then it usually will have wrapped, but this is highly
> hardware specific as the amount of time it takes to read the current
> clock registers can be anywhere from 'almost free' to 'several
> microseconds'.
> 
> Doing a division would be the same as the modulo operator.

Sure.

> Using a 32-bit modulo or division on the tv_nsec portion instead
> of doing it on the 64-bit nanoseconds is much faster but also
> a little more complex.

Yeah, keeping separate values is a mess. Another thing I was thinking
about, does the time it takes to do a division operation has the
tendency to affect the output of the program? i.e. not catching bugs
sometimes ? Otherwise who cares about the time spent doing division
during testing of the kernel :)

> Another option would be to allow up to 999 nanoseconds of
> time going backwards before printing an error for the case
> of gettimeofday() after clock_gettime(), like
> 
> if ((tv->gettime == my_gettimeofday)
>     slack = 999;
> else
>     slack = 0;
> 
> if (start + slack < end)
>       failure();

I like it, but I think you did it a bit incorrectly according to the
current code:

if (end + slack < start)
      failure();

> This is much faster as it avoids the division but does not catch
> the corner case of gettimeofday() returning a value that is
> slightly before the previous clock_gettime() but that is actually
> in the previous microsecond interval.

Hmm, I am not sure I understand it. The only bug that can happen with
gettimeofday() is when it returns a value with a different microsecond
value than clock_gettime(), as we can't capture values lower than 1
us.

So, clock_gettime() returns 4001 ns and gettimeofday() returns 3000
(or 2000 or 1000) ns. This is the only bug possible here. And adding
999 to gettimeofday() output will never make it cross the microsecond
boundary (as it has 000 at the end) and so we should always catch the
bug.

Where am I wrong here now ? Of course I am :)

-- 
viresh
