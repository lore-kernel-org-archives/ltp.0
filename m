Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcvSx-0005pJ-FV
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 11:35:51 +0000
Date: Wed, 23 Apr 2014 13:34:59 +0200
From: chrubis@suse.cz
Message-ID: <20140423113459.GC23958@rei>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
	<1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<1397663294-60210-2-git-send-email-mats.liljegren@enea.com>
	<20140422154711.GG3951@rei> <20140423124410.29874232@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140423124410.29874232@mats-desktop>
Subject: Re: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> As for -Werror, I can remove it, but not without shedding some tears...
> This was my way of assuring that no one who contributed to my code will
> be able to slip in warnings unnoticed. To turn things around: The
> -Werror is a way of saying "Now this code has once compiled without
> warnings, and from now on it is not ok to introduce new warnings".
> 
> You might think that it is never ok to introduce warnings, but when I
> compile I get some warnings. I didn't want this to happen to my code as
> well.

The real problem with -Werror is that the code usually fails to compile
with older/newer compiler because false possitive warnings were removed
or new warnings were added. It's good to use -Werror for development but
it's not a good idea to use it for production.

> > No useless comments like this please (see paragraph 1.4 in Test
> > Writing Guidelines).
> 
> Hmm, must have been some copy and paste. I'm usually bad at producing
> comments... ;-)

We have quite a lot of legacy code that is messed up. :(

So copy pasting random test and starting from there is usually not a
good idea.

> > > +/*
> > > + * Call a command using shell.
> > > + * Command line expressed similar to printf().
> > > + * Expects that the command outputs a value as the first line of
> > > output
> > > + * from stdout.
> > > + * Asserts that the command returned success (0).
> > > + */
> > > +static unsigned long shell_int(int base, const char *cmd, ...)
> > > +{
> > > +	va_list va;
> > > +	unsigned long val;
> > > +	char val_str[64];
> > > +	char *cmd_buf;
> > > +
> > > +	va_start(va, cmd);
> > > +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> > > +		err("%s: Not valid printf format, or out of
> > > memory", cmd);
> > > +	va_end(va);
> > > +	val = str_to_ulong(
> > > +		shell_str(val_str, sizeof (val_str), "%s", cmd),
> > > cmd, base); +
> > > +	return val;
> > > +}
> > 
> > The cmd_buf is not used nor freed, the additional parameters are
> > ignored etc.
> > 
> > If you are going to write shell_int() by using shell_str you must
> > create vashell_str() first and build both shell_str and shell_int on
> > the top of it. But given that this function is used only once I would
> > strongy sugest to use shell_str() and SAFE_STRTOUL() in the caller.
> 
> I agree. That would simplify things. Sometimes my ambition to make
> things general get a bit out of hand...

I have similar problems as well :)

> > > +{
> > > +	char *stack = SAFE_MALLOC(cleanup, STACK_SZ);
> > > +	int tid;
> > > +	struct child_params child_params = {
> > > +		func, cpu_partition, cpu, 0
> > > +	};
> > > +
> > > +	tid = ltp_clone(CLONE_VM, child_entry, &child_params,
> > > STACK_SZ, stack);
> > 
> > Is there any reason to use clone instead of fork() of
> > pthread_create()?
> 
> Yep, fork() will produce a process, but I want a thread. But I also
> wanted the child PID, which is why I didn't use pthread_create().

Ok.

> > > +	if (tid == -1)
> > > +		err ("clone(): %s", strerror(errno));
> >                    ^
> > 		   no spaces between function names and brackets
> > 
> > Have you used checkpatch.pl as suggested in the Test Writing
> > Guidelines?
> 
> No, but that was my intention before sending the "real" patch. This
> current round was RFC since I wanted to know if this is something that
> could be upstreamed before I do the final polishing on it.

Ok.

> > > +	info("tid %d: Starting %s load on cpu %d", tid,
> > > cpu_partition, cpu);
> > > +	while (!child_params.started)
> > > +		sched_yield();
> > 
> > I do not like the bussy loop here much (We have a pipe base child
> > parent synchronization code in the LTP library, see paragraph 2.2.7
> > in the Test Writing Guidelines) but given that all the childs do is
> > bussy loop...
> 
> I'm not sure why this is a problem. Using shared memory seems like a
> simpler design that using FIFO dependent on sharing the same current
> working directory. I also wonder whether tst_checkpoint.h is dependent
> on having different processes rather than different threads to
> synchronize.

The problem is that this spins in place, which is bussy waiting and this
may lead to unexpected results when you fork several childrens that hogs
cpu and then wait in bussy loop until they run.

There were several testcases that did something similar and modified
realtime priorities at the same time which, under some circumstances,
hanged system (because there were no CPU time left for kernel threads).

If you use FIFO the waiting process waits in kernel queue and does not
consume CPU resources.

The checkpoint implementation in LTP needs only a common directory so
that the processes/threads/whatever agrees on the file to use.
(I should add more documentation into Test Writing Guidelines about
this)

> The whole point with this is to make sure the children are up and
> running (i.e. no shell commands left to be done at startup). And this
> was the simplest design I could think of to ensure this.

It's simplest but not best.

> > > +			info("Cleanup: %s: Has terminated
> > > successfully", cmd);
> > > +		}
> > > +	} while (pid != -1);
> > > +
> > > +	if (errno != ECHILD)
> > > +		err("Cleanup: wait() failed: %s", strerror(errno));
> > > +
> > > +	info("Cleanup: Done");
> > > +}
> > > +
> > > +static unsigned long determine_nohz_mask(void)
> > > +{
> > > +	const char *nohz_cpus_filename =
> > > "/sys/fs/cgroup/cpuset/rt/cpuset.cpus";
> > > +	int file = open(nohz_cpus_filename, O_RDONLY);
> > 
> >         this is not file but fd (file descriptor)
> 
> Where the fd represents a file... Whatever. I can change the name.

Not that it's wrong, but this is the first time I've seen variable named
file that is not FILE*. I think that this would be more clear otherwise.
But that is very minor.

> > > +/*
> > > + * Test main function.
> > > + * Perform tick measurement for the given number of seconds.
> > > + */
> > > +static void test(time_t duration)
> > > +{
> > > +	uint64_t nr_ticks;
> > > +	time_t time_finished;
> > > +	/* If sched_tick_max_deferment patch has been applied,
> > > expect that the
> > > +	 * partitioning has disabled ticks completely. Otherwise,
> > > expect
> > > +	 * 1Hz ticks */
> > > +	const int expect_0hz =
> > > +
> > > access("/sys/kernel/debug/sched_tick_max_deferment", F_OK) == 0;
> > 
> > This is a bit hacky, I would just use if (...) instead.
> 
> I like const declaration, they make things less error prone. So
> personally I prefer small amount of hackiness to buy me less error
> prone code... But this is a matter of taste.

Ok. Leave this one as it is if you want, but at least define the long
path to some shorter name at the test start, something as:

#define SCHED_TICK_MAX_FILE "/sys/kernel/debug/sched_tick_max_deferment"

> > > +	const time_t current_time = time(NULL);
> > > +
> > > +	const unsigned int nr_children = setup();
> > 
> > Returning number of children from setup is a bit confusing. Maybe it
> > would be better to make nr_children global variable or rename the
> > function.
> 
> The name "setup" doesn't really give any hints on what is returned,
> only what is being done. I'm not confused by it, but I guess I'm
> biased...
> 
> Would you prefer that "setup" is renamed to "setup_return_nr_children"?

It's a bit confusing in terms of LTP because there are thousand
testcases where setup() is void and does not return anything.

There is, on the other hand, custom of setting up global variables in
the test setup().

So either use global variable or rename it to setup_children() or
similar which would hint that it's different.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
