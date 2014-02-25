Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIIYi-0007Pk-Ek
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 14:00:32 +0000
Date: Tue, 25 Feb 2014 15:00:17 +0100
From: chrubis@suse.cz
Message-ID: <20140225140017.GC14376@rei>
References: <20140211142336.GA14876@rei.Home>
	<1392131944-27263-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1392131944-27263-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140221181117.GA15723@rei> <530C5E99.6050809@oracle.com>
	<20140225122538.GA12159@rei.Home> <530CA0A3.403@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530CA0A3.403@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] msgctl11: process message queues by
	portions
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
> > On my systems /proc/sys/kernel/pid_max is set to 32768 and MSGMNI is
> > from 2000 to 7000 on most of the machines I've seen. So the value of
> > maxnkids was between 1 and 4 previously but it defaults to 10 after this
> > patch which increases the test runtime by minute or two.
> >
> > Thinking of this again the most behavior preserving change would be:
> >
> > 	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2))
> > 	        maxnkids = MAX(1, ((free_pids / 4) / MSGMNI));
> >
> > Which would scale the number of kids to the free pids but will not abort
> > the test if there is not enough free pids. The drawback is that the code
> > is complicated enough even without this change...
> >
> 
> According to the definition of recompute_msgmni() function (ipc/msg.c) 
> the limit by which the kernel may increase msgmni automatically is 
> IPCMNI. And IPCMNI is defined to be 32768 (include/linux/ipc.h).
> 
> So yes, the above approach (using MAX) should work on most systems 
> (maybe even all. I'm not sure about embedded stuff) where neither 
> pid_max nor msgmni values were modified manually. Manually changing 
> pid_max and/or msgmni values we can break the test.
> 
> Actually, I don't like the MAX-variant, because of the drawback you 
> mentioned. But the MAX-variant is sufficient for my needs.
> 
> So which patch set to prepare? :)

I would be inclined to set the default maxnkids value to something more
reasonable than 10, perhaps 2 or 3 would be a good compromise between
the test runtime and the amount of system stress the test does.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
