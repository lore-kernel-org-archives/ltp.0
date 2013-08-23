Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VCpiA-00045a-FJ
	for ltp-list@lists.sourceforge.net; Fri, 23 Aug 2013 11:39:26 +0000
Date: Fri, 23 Aug 2013 13:39:27 +0200
From: chrubis@suse.cz
Message-ID: <20130823113927.GA24285@rei>
References: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130822131321.GA11897@rei.ASUS> <52174875.9030606@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52174875.9030606@oracle.com>
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
> Thank you for this point.
> 
> At first sight it seems that this testcase is very specific for i386 
> (maybe for other architectures also).
> 
> In i386 I found two variants of setgroups syscall (from 
> arch/x86/syscalls/syscall_32.tbl):
>      81      i386    setgroups               sys_setgroups16
>      206     i386    setgroups32             sys_setgroups
> 
> I guess in i386 glibc handler for setgroups() internally uses 
> _setgroups32_ syscall.
> 
> In x86_64 there is only one variant (from arch/x86/syscalls/syscall_64.tbl):
>      116     common  setgroups               sys_setgroups
> 
> which points to 32-bit version.
> 
> But It's just an assumption and I'll verify this.

The 16 variant is backward compatibility for old programs using this
binari ABI so it makes sense that it does not exist on architectures
that Linux were ported to after the 32 bit syscall was created.

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
