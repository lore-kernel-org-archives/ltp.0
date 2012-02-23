Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0aja-0004j7-Tg
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 15:37:30 +0000
Date: Thu, 23 Feb 2012 16:38:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223153803.GC20855@saboteur.suse.cz>
References: <1329991018-26230-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1329991018-26230-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH] creat07: Drop basename() function call from
 read-only variable
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> test_app is a read-only variable because it is defined as a preprocessor macro.
> Using basename() on this variable, it will most certainly lead to a segmentation
> fault in uClibc code. Moreover, there is no need to use basename() at all since
> the test_app variable is a single string and it does not contain any leading
> paths.
> 
> Quote from uClibc's include/libgen.h header:
> 
> "Return final component of PATH.
> 	This is the weird XPG version of this function.  It sometimes will
> 	modify its argument.  Therefore we normally use the GNU version (in
> 	<string.h>) and only if this header is included make the XPG
> 	version available under the real name.
> 
> 	extern char *__xpg_basename (char *__path) __THROW;
> 	#define basename        __xpg_basename"

Well in glibc you get version that is not reentrant but doesn't modify
the source string when _GNU_SOURCE is defined (which is defined in
creat07.c), so this may be bug in uClibc compatibility.

And I think that there is no reason to segfault when the argument
doesn't need to be modified, which should be the case here. Or did the
segfault occured in your enviroment?

However commit this as the call is useless here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
