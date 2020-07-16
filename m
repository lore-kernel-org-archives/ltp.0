From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Jul 2020 11:57:38 +0200
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
In-Reply-To: <20200716093316.re67arcm3tbxtwas@e107158-lin.cambridge.arm.com>
References: <20200714152510.13470-1-qais.yousef@arm.com>
 <20200716060710.GA3812@dell5510>
 <20200716093316.re67arcm3tbxtwas@e107158-lin.cambridge.arm.com>
Message-ID: <20200716095738.GA9395@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qais,

> > BTW this has already been reviewed and tested by Huacai Chen [1].
> > LGTM, although I'd prefer to detect with with polling, isn't it possible? [1].

> FWIW I did try to avoid the sleep [1].
Yes, I know, but that was in kernel code (great you tried to fix the problem in
the kernel). Here I mean avoid blind sleep in the test. Reporting problem and
taking "sleep 1" fix would be most probably just enough. Below are suggestions to
consider before taking your posted fix as is.

> Were you thinking of something like that (pseudo code)?

> 	for i in $(seq 3)
> 	do
> 		sleep 1
> 		verify()
> 		if [ sucess ]; then
> 			break;
> 		fi
> 	done

> Or you had something more sophisticated in mind?
No, certainly not more sophisticated :). You can also use TST_RETRY_FUNC helper
instead of creating loop manually. It sleeps in 1 sec.

NOTE: TST_RETRY_FUNC is a wrapper for TST_RETRY_FN_EXP_BACKOFF, using it you can
define sleep time. Unfortunately current code does not allow to loop over less
than 1s, maybe it'd be worth for some cases, where the event is really fast.

@Metan, @Li: would it be worth to change TST_RETRY_FUNC (in both C and shell) to
use ms instead of s?

Also, we have tst_sleep helper, which supports also ms and us (but using
TST_RETRY_FUNC is IMHO better).

I'd have to look more deeply into the test to figure out the verifier.

Kind regards,
Petr
