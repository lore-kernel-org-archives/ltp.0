Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WapdM-0004L9-CH
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 16:57:56 +0000
Date: Thu, 17 Apr 2014 18:57:06 +0200
From: chrubis@suse.cz
Message-ID: <20140417165706.GA2833@rei>
References: <20140416190028.GA2093@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140416190028.GA2093@ls3530.fritz.box>
Subject: Re: [LTP] [PATCH] fix fanotify syscall check on compat kernel
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The fanotify[0-5] testcases use the myfanotify_mark() wrapper for the
> fanotify_mark() syscall. But the #define does not take into account, that
> the mask field is actually of type _u64 where we need to split the hi
> and low word in the syscall on a 32bit arch.
> 
> The attached patch converts the #define to a inline function where
> the compiler will help to convert the given values to the correct types
> (e.g. unsigned long).
> 
> Bug found and tested on the parisc/hppa (32bit userspace with 64bit
> kernel) arch.

I've pushed slightly modified version of this patch. Please check that
it works fine for you.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
