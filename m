From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 15 Jul 2020 08:06:42 +0530
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <20200714142843.GA14905@yuki.lan>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
Message-ID: <20200715023642.jlldqjr7phru7ojj@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14-07-20, 16:28, Cyril Hrubis wrote:
> Hi!
> Pushed with minor changes, thanks.
> 
> Among other fixes I've moved the signal check from the signal handler to
> the clear_signal() function, since the tst_res() function is not
> signal-async-safe...

What does that mean ? I remember that I added it there in
clear_signal() first, but then I tried to print the stuff (forcefully)
from sighandler() and it worked without any issues and so I did that.

-- 
viresh
