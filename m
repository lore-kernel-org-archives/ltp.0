Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSQhT-0001dc-8n
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 13:47:59 +0000
Date: Mon, 2 Mar 2015 14:47:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302134716.GA11619@rei>
References: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
	<20150302130439.GA16543@rei>
	<1750098575.20916844.1425303360282.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1750098575.20916844.1425303360282.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] sched_setparam/9-1: fix hang on -rt kernel
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
To: Jan Stancek <jstancek@redhat.com>
Cc: jkastner@redhat.com, ltp-list@lists.sourceforge.net

Hi!
> > >  static void test_process(void)
> > >  {
> > > -	/* to avoid blocking */
> > > -	alarm(2);
> > > -
> > > -	while (1) {
> > > -		(*shmptr)++;
> > > +	struct sched_param param;
> > > +	time_t t1, t2;
> > > +
> > > +	t1 = time(NULL);
> > > +	do {
> > > +		sched_getparam(getpid(), &param);
> > > +		(*shmptr) = param.sched_priority;
> > > +		/* if we can see that our priority has changed
> > > +		 * that means we preempted parent, so we are done */
> > > +		if ((*shmptr) == mean_prio)
> > > +			break;
> > > +
> > > +		t2 = time(NULL);
> > > +		/* immediately after parent forks us, we has same
> > > +		 * priority and compete with parent for same CPU,
> > > +		 * give parent chance to run and boost our priority */
> > >  		sched_yield();
> > 
> > Hmm, is this the case? Because the main thread should continue to run
> > until blocked and without the sleep(1) in the main() there is nothing
> > that could block the parent process between the fork and the priority
> > boost. Or am I mistaken?
> 
> I think you're right in scenario with single CPU.
> In theory, is it possible that set_affinity() would be dummy, and one of
> ncpu-1 children running with max FIFO priority would preempt parent
> allowing test_process() to run before its priority is changed?

Aren't the child proceesses forked with the same priority as the parent?
In this case they shouldn't get executed for the same reason unless they
are migrated other CPUs. But yes then it's a kind of unpredictable which
is the reason we have the affinity call there.

> I'd prefer to keep sched_yield() in test_process() as it poses
> no harm even in case parent can't be blocked/preempted.

Ok.

> > Shouldn't we rather initialize the shmptr to some known value (!=
> > mean_prio) now?
> 
> It's initialized to 0, after call to shmat.

Missed that, you are right.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
