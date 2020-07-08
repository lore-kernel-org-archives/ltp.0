From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 8 Jul 2020 08:04:23 +0530
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200707114952.GD3512@yuki.lan>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
 <20200703125927.GA11556@yuki.lan>
 <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
 <20200707090301.GA3512@yuki.lan>
 <20200707091803.p7ptgfxa5nsleh5b@vireshk-i7>
 <20200707114952.GD3512@yuki.lan>
Message-ID: <20200708023423.usul7nc27b6vlkrv@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07-07-20, 13:49, Cyril Hrubis wrote:
> Hi!
> > > Huh, how come the syscall is called clock_getres_time64 while the rest
> > > has only 64 appended such as clock_gettime64 and clock_settime64?
> > > 
> > > That's really strange...
> > 
> > That also made me wonder on how should I be naming routines.
> > Apparently they wanted to have "time64" in the name, if the syscall
> > already has "time" in it they just appended 64, else added "_time64".
> 
> If that is the case in upstream we should follow that convence for the
> functions as well...

That's what I tried to do in my patches normally.

-- 
viresh
