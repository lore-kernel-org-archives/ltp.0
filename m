Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VDxaQ-0006hS-W5
	for ltp-list@lists.sourceforge.net; Mon, 26 Aug 2013 14:16:07 +0000
Date: Mon, 26 Aug 2013 16:16:12 +0200
From: chrubis@suse.cz
Message-ID: <20130826141612.GB3344@rei>
References: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130822131321.GA11897@rei.ASUS> <52174875.9030606@oracle.com>
	<20130823113927.GA24285@rei> <521B331D.7050902@oracle.com>
	<20130826113021.GA3344@rei> <521B4D82.2060007@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521B4D82.2060007@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/setgroups: fix implicit SETGROUPS
 parameter casting
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
> But we can't rely on the fact that group ids of a user invoking the 
> testcases are fit into __old_gid_t.
> 
> And the purpose of current GETGROUPS definition is to handle such cases.
> 
> A situation may happen where root user is a member of a group with a 
> _big_ group id.
> 
> So I'm not 100% sure about fixing getgroups part of the same header.
> 
> Or did I miss something?

What I mean is that we should check if the compatibility getgroups
syscall exists and if not abort the test (as the setgroups will do).
Because the 32 bit getgroups syscall is tested with the tests without
the TST_USE_COMPAT16_SYSCALL.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
