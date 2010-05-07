Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1OAOfa-00018k-1K
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 14:36:50 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OAOfZ-0006QT-4V
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 14:36:49 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o47ENhWx012454
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 10:23:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o47EaYwr1081390
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 10:36:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o47EaXhf031471
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 10:36:33 -0400
Date: Fri, 7 May 2010 09:36:32 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100507143632.GC22099@us.ibm.com>
References: <1273081434-22034-1-git-send-email-danms@us.ibm.com>
	<1273225268.6042.8.camel@subratamodak.linux.ibm.com>
	<877hnfyebf.fsf@caffeine.danplanet.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877hnfyebf.fsf@caffeine.danplanet.com>
Subject: Re: [LTP] [PATCH] NetNS test fixes
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
To: Dan Smith <danms@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Quoting Dan Smith (danms@us.ibm.com):
> SM> Can you please ack this patch.
> 
> Ack the revised one below instead :)
> 
> By the way, these tests appear to start up sshd for no reason other
> than possibly checking that basic sockets work in the netns.  Given
> the frailty and required setup of the "ftp" test, I think it would be
> better to replace it with a test using netcat and then yank the sshd
> bits from the ping tests.

Ack that.

> Dan Smith
> IBM Linux Technology Center
> email: danms@us.ibm.com
> 
> NetNS test fixes (v2)
> 
> This patch fixes a couple of netns test issues that cause invalid failures
> relating to exiting with a status variable that doesn't exist.  It also
> fixes an instance of inverted logic and a failure to exec sshd with the
> full path (as required).
> 
> Additionally, it makes the common child exec function more descriptive of
> what it tried to do and why it failed to ease debugging.
> 
> Changes in v2:
> - Initialize status=0 at the top of child_1.sh to prevent overshadowing
>   a (meaningless) sshd failure
> 
> Signed-off-by: Dan Smith <danms@us.ibm.com>

Acked-by: Serge E. Hallyn <serue@us.ibm.com>

thanks,
-serge

------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
