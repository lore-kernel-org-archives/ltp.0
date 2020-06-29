From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Jun 2020 14:05:13 +0200
Subject: [LTP] [PATCH 2/2] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <7d8f71c73ac4518375b81651f82ef040c02082a1.1593430825.git.viresh.kumar@linaro.org>
References: <7c68854a1b6ef828ed8dd83cb611bd5b5d53c2f8.1593430825.git.viresh.kumar@linaro.org>
 <7d8f71c73ac4518375b81651f82ef040c02082a1.1593430825.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a0ZAjUnybGVD4Kh5t5PZth3wgt672SwNf9iVPmqBUg4LQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 29, 2020 at 1:43 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch improves the testcase by doing multiple things:
>
> - Make sure the timer fires and catch the signals.
>
> - Verify the values set to the itimerspec by reading them again using
>   timer_gettime() syscalls.
>
> - Reduce the timer interval, 5 seconds was way too much.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Cyril/Arnd,
>
> This works well for all clocks except CLOCK_PROCESS_CPUTIME_ID and
> CLOCK_THREAD_CPUTIME_ID for some reason. I tried to read the values for
> those clocks by sleeping for 1 second and then reading values using
> timer_gettime() in a loop, and the value incremented every 15-16 seconds
> by a value of 1 (which was in ms if I am not wrong).
>
> No idea what the hell is going on here and so need experts advice :)

The problem is that these clocks only tick while the process is running. Instead
of sleeping for one second, you need to be in a busy-loop to ensure they
actually advance.

        Arnd
