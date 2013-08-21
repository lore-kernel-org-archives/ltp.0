Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VC5La-0006hZ-D4
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 10:09:02 +0000
Date: Wed, 21 Aug 2013 12:09:01 +0200
From: chrubis@suse.cz
Message-ID: <20130821100901.GA3795@rei>
References: <1376908164-10045-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130821091712.GA3558@rei> <52148D58.9060509@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52148D58.9060509@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/migrate_pages: fix nodemask memory
 allocation
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
> > Also I would create a macro to do that NODEMASK_SIZE() and put it into
> > migrate_pages_common.h header.
> >
> I like the variant of a ALIGN general  macro addition (for example, in 
> test.h) because it may be useful in further testcases.

Ah, I've missed that Jan replied to the patch before. The align macro
sounds good.

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
