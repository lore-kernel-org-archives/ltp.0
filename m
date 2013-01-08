Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TsYaK-0003wt-Ba
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 12:47:16 +0000
Date: Tue, 8 Jan 2013 13:47:26 +0100
From: chrubis@suse.cz
Message-ID: <20130108124726.GA19307@rei>
References: <1357616084-1705-1-git-send-email-jshao@redhat.com>
	<20130108054041.GA32247@station.monson>
	<50EBB4A4.8040103@cn.fujitsu.com>
	<20130108062047.GB32247@station.monson>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130108062047.GB32247@station.monson>
Subject: Re: [LTP] [PATCH] containers: delete redundant newline in tst_resm()
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
To: ltp-list@lists.sourceforge.net, gaowanlong@cn.fujitsu.com

Hi!
> Is there any maitainer still taking care of the containers part? Different namespace
> test cases are in different style and the code is messy. I checked the git log and found
> it seems like be abandoned.

Looking at the git log these were developed by IBM and since then we
only made sure they compile. So there is nobody who is pushing the
development of these testcases now. Which is not ideal as this part of
kernel is still under heavy development testcases are most likely not
covering what they should (or even may not work correctly).

As usual patches are welcome.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
