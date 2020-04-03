From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Apr 2020 12:42:23 +0530
Subject: [LTP] Query: Supporting time64 syscalls
In-Reply-To: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
References: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
Message-ID: <20200403071223.4d2vcfwiuxnuxij6@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23-03-20, 14:42, Viresh Kumar wrote:
> Hi guys,
> 
> I was looking to start working on the time64 syscalls
> (like clock_gettime64, timerfd_settime64, etc) and
> was looking for your suggestions on how to proceed on
> the same.
> 
> AFAIU, the only difference is that the argument is 64 bit now
> instead of 32 bit and so I don't think I should be adding new
> tests but reusing the existing ones for both 32 bit and 64 bit
> variants.

@Cyril/Petr,

Any suggestions on how should I go about these tests ?

-- 
viresh
