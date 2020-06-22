From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 22 Jun 2020 10:41:35 +0530
Subject: [LTP] [PATCH] clock_gettime03: Fix issues with negative offset
In-Reply-To: <20200618134205.GB19072@dell5510>
References: <8b9a7e8ea27894090f1e31e178d7328f118163d0.1591270889.git.viresh.kumar@linaro.org>
 <CA+G9fYuHsezzit3pzHiz-6ad4AfbgRsdbuqfUKvLif7_Jk5WkA@mail.gmail.com>
 <20200618134205.GB19072@dell5510>
Message-ID: <20200622051135.dzitlt3tpyftfvqc@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18-06-20, 15:42, Petr Vorel wrote:
> > Test ran for 100 iterations on x86 device and confirmed test getting pass.
> FYI with very high number of the tests it still can fail, but it's
> much less likely:
> 
> ./clock_gettime03 -i 100000
> Summary:
> passed   3599972
> failed   28
> skipped  0
> warnings 0

I am not able to hit it on my x86 box, even after suppressing all the print
messages (in order to get rid of any delays). Looks like a hardware/platform bug
to me. I tried a loop of 100,00,000 as well :)

-- 
viresh
