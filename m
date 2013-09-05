Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VHXPG-0000eM-2R
	for ltp-list@lists.sourceforge.net; Thu, 05 Sep 2013 11:07:22 +0000
Date: Thu, 5 Sep 2013 13:07:32 +0200
From: chrubis@suse.cz
Message-ID: <20130905110732.GC2770@rei>
References: <20130904133732.GB12344@rei>
	<1378364509-20971-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378364509-20971-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V4] 16-bit syscalls fixes
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
> Changes since V3:
> 
> [PATCH 1/3]: no changes
> 
> [PATCH 2/3]:
> * Added Oracle copyright string to syscalls/utils/compat_16.h
> * Fixed comment next to LTP_CREATE_SYSCALL
> * Used alternative variant: passing cleanup callback parameter to all
>   caps functions. I think It looks more compact.
> 
> [PATCH 3/3]: Modified invocation of SETGROUPS/GETGROUPS because of changes in [PATCH 2/3]

This version looks good to me.

(Let's wait a day or two so that other have chance to look at the code,
 then, if nobody objects, I will merge it.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
