Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4UFW-0003Ei-Ir
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 11:07:22 +0000
Date: Wed, 31 Jul 2013 13:07:14 +0200
From: chrubis@suse.cz
Message-ID: <20130731110714.GA1047@rei.scz.novell.com>
References: <0575932595c58348fef5664c180a73b59b2515f4.1374647501.git.jstancek@redhat.com>
	<99e7b2c3f61ddc7e6e89d28a0b15bc001e372b76.1374647501.git.jstancek@redhat.com>
	<20130730173517.GC1999@rei.scz.novell.com>
	<111760967.10033378.1375213746603.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <111760967.10033378.1375213746603.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] open_posix_testsuite/../mq_timedsend/12-1:
 fix race
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > -#define INTHREAD 0
> > > -#define INMAIN 1
> > > +#define SAFE(op) \
> > > +	do {\
> > > +		if ((op) == -1) {\
> > > +			perror("unexpected failure"); \
> > > +			exit(PTS_UNRESOLVED); \
> > > +		} \
> > > +	} while (0)
> > 
> > I do not like this approach, this does not tell what call has failed. It
> > would be really hard to figure out what exact line of code has failed
> > from the test error messages.
> 
> True, I'll remove that. I took if from other testcase, so we may
> want to fix that one too (some day).

Agreed.

> > > -/* manual semaphore */
> > > -int sem;
> > > +/* variable to indicate how many times signal handler was called */
> > > +static volatile sig_atomic_t in_handler;
> > >  
> > > -/* flag to indicate signal handler was called */
> > > -int in_handler;
> > > +/* errno returned by mq_timedsend() */
> > > +static volatile int mq_timedsend_errno = -1;
> > >  
> > > -/* flag to indicate that errno was set to eintr when mq_timedsend()
> > > - * was interruped. */
> > > -int errno_eintr;
> > > +/* pipes to synchronize thread calling mq_timedsend */
> > > +static int pipefd_start[2];
> > > +static int pipefd_exit[2];
> > 
> > What about using mutexes? (it's multithread application anyway).
> 
> Pipes seemed like less typing, but I can change that.

It just looks strange to synchronize multithread application with pipes,
not that it's wrong...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
