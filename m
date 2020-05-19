From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 14:47:49 +0200
Subject: [LTP] [PATCH 2/5] syscalls: settimeofday: Use gettimeofday()
In-Reply-To: <20200519121617.GA16008@yuki.lan>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <931bddab3d92f73f07f32dd7e1770078fdc07e0e.1589877853.git.viresh.kumar@linaro.org>
 <20200519121617.GA16008@yuki.lan>
Message-ID: <CAK8P3a2WQ+pU2ao1ERM8f9Vy3_6ASc3ijBDSD6id2aZoio+o5w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 19, 2020 at 2:15 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> You can set the .restore_wallclock flag in the tst_test structure for
> these two tests and remove the setup() and cleanup() as well.
>
> Also in the settimeofday02 I would be inclined to just remove the clock
> restoration code, since there is no way the tim will be changed unless
> the kernel is buggy.

Ah, I did not realize that LTP actually does try to set the clock and then
set it back. If it does that, it may be very interesting to test the behavior
across the y2038 overflow, e.g. set the time ot just after the 2038-01-19
expiration and ensure the kernel still behaves as expected, or set the
timer to just before the overflow and set a timer just after, and see that
the timer triggers.

      Arnd
