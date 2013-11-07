Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeNnY-0006Zi-0O
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 11:30:52 +0000
Date: Thu, 7 Nov 2013 12:30:29 +0100
From: chrubis@suse.cz
Message-ID: <20131107113029.GB28246@rei>
References: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
	<1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1608129004.16193796.1383140734531.JavaMail.root@redhat.com>
	<52720CC8.7070000@oracle.com> <20131031150632.GB20620@rei.Home>
	<52727305.5070806@oracle.com> <20131031162944.GE20620@rei.Home>
	<527B7485.2030809@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527B7485.2030809@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] setpgid03: use SIGUSR1 instead of sleep
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> > I've overlooked the second case, however checkpoint works for this one
> > as well. You need to build a helper binary setpgid03_child.c that would
> > call the signal function and then do the wait.
> >
> > The checkpoint interface is build on the top of unix sockets so it does
> > not matter whether the process was forked, execed or started from
> > termial. All that is needed is correct CWD (which is inherited both on
> > fork and exec) so that the socked special file is found.
> >
> There is one issue.
> 
> Look at lib/tests/tst_checkpoint_parent.c.
> 
> If the child exits before calling TST_CHECKPOINT_CHILD_WAIT(&checkpoint) 
> (for example, if it gets a signal), the parent
> will wait at TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint) (blocking at 
> open(O_WRONLY)) until we kill it manually.

Yes, it will hang. Feel free to send a patch with a timeout.

> I don't think that such situation can occur in this particular test case 
> but if we had more activity (like function calls and some logic) before
> execution of TST_CHECKPOINT_CHILD_WAIT in the child, we would have troubles.

It's unlikely situation but it may happen. Generally any of the tests
may hang (due to bug in libc or kernel for example) and ideally the test
driver (ltp-pan currently) should watch for timeouts and kill such
tests, which is not implemented currently.

I'm working on replacement testdriver when my time allows, I have most
of the major parts working and hope to have working prototype soon
(hopefully till the end of the year).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
