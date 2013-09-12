Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VK3Uf-0000t0-Gx
	for ltp-list@lists.sourceforge.net; Thu, 12 Sep 2013 09:47:21 +0000
Date: Thu, 12 Sep 2013 11:47:35 +0200
From: chrubis@suse.cz
Message-ID: <20130912094735.GA6824@rei.suse.cz>
References: <52315B4D.1020902@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52315B4D.1020902@oracle.com>
Subject: Re: [LTP] FORK_OR_VFORK
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> LTP employs FORK_OR_VFORK macro which is defined as:
> 
> #ifdef UCLINUX
> #define FORK_OR_VFORK                   vfork
> #define MAP_PRIVATE_EXCEPT_UCLINUX      0
> #else
> #define FORK_OR_VFORK                   fork
> #define MAP_PRIVATE_EXCEPT_UCLINUX      MAP_PRIVATE
> #endif
> 
> So, on UCLINUX it is a vfork call.
> 
> But many testcases use this macro and try to use functions other than 
> exec() and _exit() inside a child.
> Example - syscalls/setfsuid/setfsuid04.c.
> And I suppose that because of that fact these testcases may fail on 
> UCLINUX (or behave unexpectedly).
> 
> Is this situation left intentionally? Does somebody care about this 
> issue? Or we simply ignore it.
> 
> I'm just curious. :)

Most of the testcases does vfork() then exec itself with some parameter
in argv[] to create the child, which is correct and as close to fork()
as uClinux can get. See self_exec() in lib/self_exec.c.

There seems to be a few testcases that does just call FORK_OR_VFORK and
use it in a way that violates the specs, these may work or may not, that
depends on actual implementation of vfork in uClinux.

I'm trying not to break any of uClinux code in LTP but as I have no
uClinux hardware nor much interest in fixing it I'm not trying to fix it
actively.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
