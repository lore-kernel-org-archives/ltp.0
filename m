From: Qais Yousef <qais.yousef@arm.com>
Date: Thu, 16 Jul 2020 14:49:39 +0100
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
In-Reply-To: <20200716120852.GA22657@dell5510>
References: <20200714152510.13470-1-qais.yousef@arm.com>
 <20200716060710.GA3812@dell5510>
 <20200716093316.re67arcm3tbxtwas@e107158-lin.cambridge.arm.com>
 <20200716095738.GA9395@dell5510>
 <20200716101250.vd7nan2u2nydzbnf@e107158-lin.cambridge.arm.com>
 <20200716120852.GA22657@dell5510>
Message-ID: <20200716134939.tqxswbdd2lcpcwp3@e107158-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

On 07/16/20 14:08, Petr Vorel wrote:
> Hi Qais,
> 
> > > > > BTW this has already been reviewed and tested by Huacai Chen [1].
> > > > > LGTM, although I'd prefer to detect with with polling, isn't it possible? [1].
> 
> > > > FWIW I did try to avoid the sleep [1].
> > > Yes, I know, but that was in kernel code (great you tried to fix the problem in
> > > the kernel). Here I mean avoid blind sleep in the test. Reporting problem and
> > > taking "sleep 1" fix would be most probably just enough. Below are suggestions to
> > > consider before taking your posted fix as is.
> 
> > We're probably talking about the same thing. But to clarify further, my
> > original fix in kernel had no sleep and would force a wait by flushing the
> > workqueue when the userspace does the read
> 
> > https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
> 
> > But the maintainer was suggesting to do the sleep in the test instead. Which I
> > didn't like and I didn't understand why my fix isn't good.
> Maybe ask to reconsider your patch again? But cpuset_wait_for_hotplug() might be
> needed on more places, what a shame that turning code into synchronous didn't
> work :(.

Yeah it was a shame. The locking depdency seemed a tricky one too.

> 
> > Anyways. Looking forward.. :)
> 
> 
> > > > Were you thinking of something like that (pseudo code)?
> 
> > > > 	for i in $(seq 3)
> > > > 	do
> > > > 		sleep 1
> > > > 		verify()
> > > > 		if [ sucess ]; then
> > > > 			break;
> > > > 		fi
> > > > 	done
> 
> > > > Or you had something more sophisticated in mind?
> > > No, certainly not more sophisticated :). You can also use TST_RETRY_FUNC helper
> > > instead of creating loop manually. It sleeps in 1 sec.
> 
> > > NOTE: TST_RETRY_FUNC is a wrapper for TST_RETRY_FN_EXP_BACKOFF, using it you can
> > > define sleep time. Unfortunately current code does not allow to loop over less
> > > than 1s, maybe it'd be worth for some cases, where the event is really fast.
> 
> > > @Metan, @Li: would it be worth to change TST_RETRY_FUNC (in both C and shell) to
> > > use ms instead of s?
> 
> > > Also, we have tst_sleep helper, which supports also ms and us (but using
> > > TST_RETRY_FUNC is IMHO better).
> 
> > > I'd have to look more deeply into the test to figure out the verifier.
> 
> > I'd be happy to consider this as long as it won't steal my day. I'm just
> > a by-passer developer and my knowledge about the code base is minimal :)
> Understand. I'm not myself familiar with LTP cpuset tests, nor with the kernel code.
> 
> > Let me know what would be the preferred approach.
> Just please try to send a patch using TST_RETRY_FUNC (thus you need to figure
> out the verifier), or let us know and we either figure that or just simply use
> your original patch.

So I have cooked something quick but I either get

	/root/arm64-ltp/testcases/bin/cpuset_hotplug_test.sh: line 159: TST_RETRY_FUNC: command not found

or

	cpuset_hotplug_test 1 TBROK: Test /root/arm64-ltp/testcases/bin/cpuset_hotplug_test.sh must call tst_run!

Depending whether I impost test.sh or tst_test.sh.

It seems there's a dependency on the overall test construction depending on
what file is imported. And one can import one or the other. It seems
tst_test.sh is the legacy approach?

My WIP patch is attached in case there's somethign obvious to be done here that
I missed.

It looks like the current patch is the simplest thing to do otherwise? :-/

Thanks

--
Qais Yousef
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fixup.patch
Type: text/x-diff
Size: 6204 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200716/ab280809/attachment.patch>
