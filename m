From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2020 10:53:14 +0200
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <20200715023642.jlldqjr7phru7ojj@vireshk-i7>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
 <20200715023642.jlldqjr7phru7ojj@vireshk-i7>
Message-ID: <20200715085314.GA7741@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Pushed with minor changes, thanks.
> > 
> > Among other fixes I've moved the signal check from the signal handler to
> > the clear_signal() function, since the tst_res() function is not
> > signal-async-safe...
> 
> What does that mean ? I remember that I added it there in
> clear_signal() first, but then I tried to print the stuff (forcefully)
> from sighandler() and it worked without any issues and so I did that.

Calling printf() from signal handler is not safe, which tst_res() does.

It will work fine 99% of the cases and this is the reason most people do
it anyways. One of the failure modes is the malloc arena lock. Printf
may allocate temporary buffer so if the signal comes when the process is
in the malloc code the process will hang forewer because it will try to
acquire a lock that has been locked before we jumped into the signal
handler, but there is probably more. It usually gets triggered on
stranger architectures, x86 is quite forgiving in this regard.

Signal handlers are generally tricky and there is a list of functions
that carefuly avoid messing with any global state and can be safely used
from withing a signal handler (man 7 signal-safety) anything else is,
unlikely to fail, but still potential hazard.

Generally the safest approach to signal handlers is to set a variable
and exit, which is what I usually do in tests...

-- 
Cyril Hrubis
chrubis@suse.cz
