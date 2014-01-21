Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W5bGf-0007KA-4I
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 13:21:25 +0000
Date: Tue, 21 Jan 2014 14:20:57 +0100
From: chrubis@suse.cz
Message-ID: <20140121132057.GB22655@rei.Home>
References: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1386840115-9703-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140120160927.GA1280@rei.suse.cz> <52DE7063.8070305@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52DE7063.8070305@oracle.com>
Subject: Re: [LTP] [PATCH V3 2/2] setpgid03: use tst_checkpoint interface
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > The timeout should better be handled, if handled at all, in the
> > checkpoint code. I would not care much about this case because when the
> > parent is dead does not talk to the child the test will fail anyway...
> >
> 
> I didn't care about the test failure in such case. I cared about that 
> without alarm() the child will keep running (i.e. blocking on IO) even 
> after the parent is dead.

I've noticed that as well, the child will continue to run and because it
called setsid() the test driver (pan) will not kill it because it left
it's parent process group.

> But I agree that it's not the best place to handle this inside the test 
> case.

I was thinking of adding the alarm() code into the checkpoint child
code. This should fix the problem once for all. But even then this
codepath happens only when something went wrong so this has not big
priority...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
