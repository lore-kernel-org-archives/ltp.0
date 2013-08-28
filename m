Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEcSo-00062R-Dn
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 09:54:58 +0000
Date: Wed, 28 Aug 2013 11:55:05 +0200
From: chrubis@suse.cz
Message-ID: <20130828095459.GB22849@rei.Home>
References: <521B6875.8010202@oracle.com>
	<1377596129-32367-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130827121625.GH10995@rei.Home> <521D9C44.8090607@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521D9C44.8090607@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] syscalls/getgroups: added checks for
 16-bit getgroups() syscall
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
> Ok. I'm managing this (compat_16.h from several testcases, compat_uid.h, 
> compat_gid.h).
> 
> But I need one more clarification.
> 
> Look at LTP/testcases/kernel/include. There are linux_syscalls_numbers.h 
> and numa_helper.h
> 
> Maybe move all these compat headers not into LTP/include/sys, but into 
> LTP/testcases/kernel/include?
> 
> I think It's a more appropriate directory.
> 
> How do you think?

I'm fine with testcases/kernel/include as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
