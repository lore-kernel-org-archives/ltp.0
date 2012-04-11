Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SHnga-0008RC-At
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 02:53:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SHngY-00023a-LF
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 02:53:32 +0000
Message-ID: <4F84F1E1.7000602@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 10:52:17 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
	<201204042152.56885.vapier@gentoo.org>
In-Reply-To: <201204042152.56885.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 04/05/2012 09:52 AM, Mike Frysinger wrote:

> On Wednesday 04 April 2012 20:38:31 Garrett Cooper wrote:
>> +/*
>> + * ``junk`` is needed to make the macro function like a void argument
>> + * function.
>> + */
>> +#define	myinotify_init(junk)	syscall(__NR_inotify_init)
> 
> you lost me.  how does this make it work like a (void) func ?  i think this 
> should drop the "junk" and just do:
> 	#define myinotify_init() ...


Cooper,

Any update on what Mike said?

Thanks,
Wanlong Gao

> -mike
> 
> 
> 
> ------------------------------------------------------------------------------
> Better than sec? Nothing is better than sec when it comes to
> monitoring Big Data applications. Try Boundary one-second 
> resolution app monitoring today. Free.
> http://p.sf.net/sfu/Boundary-dev2dev
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
