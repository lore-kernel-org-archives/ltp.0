From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 13:17:18 +0530
Subject: [LTP] [PATCH] common_timers: staticize all definitions
In-Reply-To: <20200428072516.GA8764@dell5510>
References: <20200427145212.GA5678@dell5510>
 <90ea553dfdea21683c517a7f47b2a5d3c2dba77f.1588050000.git.viresh.kumar@linaro.org>
 <20200428061424.fj4mq676aoosoqyw@vireshk-i7>
 <CAK8P3a0On9euT2mzx+LsXVe21cqwNMR4Hzj3eVDhbCS_KeGb4w@mail.gmail.com>
 <20200428072516.GA8764@dell5510>
Message-ID: <20200428074718.4ne7jnsflfbhjns7@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28-04-20, 09:25, Petr Vorel wrote:
> > There is usually no warning about variables in header files
> > that are marked 'static const' rather than just 'static', as that
> > is a common way to do things in C++.
> Correct, static const clock_t clock_list[] would work.
> I'd be for this solution.

static const it is then :)

-- 
viresh
