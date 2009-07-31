Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MWtDP-00034Q-JZ
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 14:36:11 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWtDL-0007tQ-BU
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 14:36:11 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6VEWWNH002804
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:32:32 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6VEZiBa226378
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:35:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6VEZi0i019611
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:35:44 -0600
Date: Fri, 31 Jul 2009 09:35:44 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090731143544.GA9440@us.ibm.com>
References: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
Subject: Re: [LTP] Fix digsig so it passes -Wshadow
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> clone(2) is externally defined in sched.h, and as such
> testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
> compile with -Wall due to a shadowed declaration.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> 
> Index: writeexec/libwritetest.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/libwritetest.c,v
> retrieving revision 1.1
> diff -u -r1.1 libwritetest.c
> --- writeexec/libwritetest.c	1 Nov 2005 16:09:43 -0000	1.1
> +++ writeexec/libwritetest.c	31 Jul 2009 06:30:49 -0000
> @@ -9,8 +9,6 @@
>  #include <dlfcn.h>
>  #include <wait.h>
> 
> -int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
> -
>  int writer(void *data)
>  {
>  	int fd;

Sure, as long as that's now the case on all distros.  Historically it
hasn't been.  But if it's not we'll presumably hear about it.

-serge

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
