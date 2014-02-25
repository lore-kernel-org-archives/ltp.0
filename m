Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIH58-0007Cl-Cp
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 12:25:54 +0000
Date: Tue, 25 Feb 2014 13:25:39 +0100
From: chrubis@suse.cz
Message-ID: <20140225122538.GA12159@rei.Home>
References: <20140211142336.GA14876@rei.Home>
	<1392131944-27263-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1392131944-27263-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140221181117.GA15723@rei> <530C5E99.6050809@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530C5E99.6050809@oracle.com>
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
> >> -	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
> >> -		maxnkids = ((free_pids / 4) / MSGMNI);
> >> -		if (!maxnkids)
> >> -			tst_brkm(TBROK, cleanup, "Not enough free pids");
> >> -	}
> >
> > Removing this part of the code makes the test run more than ten times
> > longer because now the maximal number of reader/writer pairs is set to
> > default value (10) and not to 1 which is what the code did previously. I
> > guess that this was intentional but it took me some time to figure that
> > out.
> 
> Hmmm. Could you elaborate on that? About '1' value.
> 
> For example, given that:
>   free_pids = 32333
>   MSGMNI = 4000
>   MAXNKIDS = 10
> maxnkids will evaluate to 2. But if MSGMNI is 9000, the initial version 
> of msgctl11 will fail with "Not enough free pids".
> 
> In some situations this expression:
>    (MSGMNI * MAXNKIDS * 2) > (free_pids / 2)
> may evaluate to false, and maxnkids will be MAXNKIDS (10).
> 
> So the original version may execute faster under __some__ circumstances 
> where the maxnkids value is evaluated to be < 10.

On my systems /proc/sys/kernel/pid_max is set to 32768 and MSGMNI is
from 2000 to 7000 on most of the machines I've seen. So the value of
maxnkids was between 1 and 4 previously but it defaults to 10 after this
patch which increases the test runtime by minute or two.

Thinking of this again the most behavior preserving change would be:

	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2))
	        maxnkids = MAX(1, ((free_pids / 4) / MSGMNI));

Which would scale the number of kids to the free pids but will not abort
the test if there is not enough free pids. The drawback is that the code
is complicated enough even without this change...

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
