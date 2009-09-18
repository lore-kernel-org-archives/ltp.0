Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MoiEG-0006cK-M2
	for ltp-list@lists.sourceforge.net; Fri, 18 Sep 2009 18:30:44 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MoiEC-0007lP-Og
	for ltp-list@lists.sourceforge.net; Fri, 18 Sep 2009 18:30:44 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8IIQa5c009644
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Sep 2009 12:26:36 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8IIUJDC140686
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Sep 2009 12:30:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8IIUARO029141
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Sep 2009 12:30:11 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909161747.31638.Renaud.Lottiaux@kerlabs.com>
References: <200909161747.31638.Renaud.Lottiaux@kerlabs.com>
Date: Fri, 18 Sep 2009 23:59:42 +0530
Message-Id: <1253298583.15071.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] [CONCURRENCY] Fix kill07
Reply-To: subrata@linux.vnet.ibm.com
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
To: Renaud Lottiaux <Renaud.Lottiaux@kerlabs.com>, Matthieu Fertr <Matthieu.Fertre@kerlabs.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, 2009-09-16 at 17:47 +0200, Renaud Lottiaux wrote:
> The following patch avoids that all kill07 test instances running
> concurrently work with the same SHM object.
> 
> Signed-off-by: Matthieu Fertr <Matthieu.Fertre@kerlabs.com>

Thanks. Long time no CONCURRENCY Fixes :-)

Regards--
Subrata

> 
> --- a/testcases/kernel/syscalls/kill/kill07.c
> +++ b/testcases/kernel/syscalls/kill/kill07.c
> @@ -219,6 +219,13 @@ void setup(void)
>         /* Pause if that option was specified */
>         TEST_PAUSE;
>  
> +       /*
> +        * Create a temporary directory and cd into it.
> +        * This helps to ensure that a unique msgkey is created.
> +        * See ../lib/libipc.c for more information.
> +        */
> +       tst_tmpdir();
> +
>         /* get an IPC resource key */
>         semkey = getipckey();
>  
> @@ -241,6 +248,9 @@ void cleanup(void)
>          */
>         rm_shm(shmid1);
>  
> +       /* Remove the temporary directory */
> +       tst_rmdir();
> +
>         /* exit with return code appropriate for results */
>         tst_exit();
>  }


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
