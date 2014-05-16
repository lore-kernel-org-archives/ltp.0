Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WlBt0-0001WM-OQ
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 06:44:54 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WlBsz-0003Rf-F9
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 06:44:54 +0000
Date: Fri, 16 May 2014 02:44:42 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <46592848.6574553.1400222682233.JavaMail.zimbra@redhat.com>
In-Reply-To: <53757A75.7000101@cn.fujitsu.com>
References: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<27774731.5088145.1400061957755.JavaMail.zimbra@redhat.com>
	<53757A75.7000101@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 16 May, 2014 4:39:49 AM
> Subject: Re: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
> 

> >>  
> > Hi,
> >
> >> +	/*
> >> +	 * Make sure current process is NOT a session or pgrp leader
> >> +	 */
> >>  	if (pgid == pid) {
> > What if we dropped the condition above and always make a child?
> > If we do that, then setpgid_test1() and setpgid_test2() are almost the
> > same,
> > with the difference of arguments you pass to setpgid(), so there's a chance
> > to re-use some code.
> >
> > Thinking about it a bit more, is there any reason we need a child process?
> 
> For pid = 0 & pgid = 0 test, I think we should have tests in child process,
> because in this case, according to setpgid()'s manpge, this will set
> child process's PGID to its PID, we should verify this.

"If pgid is zero, then the PGID of the process specified by pid is made the
same as its process ID."

I see. So, for "setpgid(0, 0);" it makes a difference and it
actually changes PGID to a different value. I'll have a look at v2
later today.

Regards,
Jan

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
