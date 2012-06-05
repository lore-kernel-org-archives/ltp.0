Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SbtTv-0007JG-RA
	for ltp-list@lists.sourceforge.net; Tue, 05 Jun 2012 13:07:31 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SbtTp-00031i-PJ
	for ltp-list@lists.sourceforge.net; Tue, 05 Jun 2012 13:07:31 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q55D7Jg0024111
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jun 2012 09:07:19 -0400
Date: Tue, 05 Jun 2012 09:07:19 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <f9d3d9fa-c3af-4ad5-a6a2-d56d949fcdfe@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FCDEDA1.8090709@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] dio_sparse: prevent race between kill and signal
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
To: ltp-list@lists.sourceforge.net

I just came across this commit:

commit d8f1292181b486b2073cc6fe1ec226f5cedea342
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Fri Mar 2 13:37:47 2012 +0100

    ltp-aiodio: aiodio_sparse fix race condition

which is patch for same situation but in 'aiodio_sparse.c' file.
So, it makes sense to fix both in same style.

Regards,
Jan

----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 5 June, 2012 1:29:37 PM
> Subject: [LTP] [PATCH] dio_sparse: prevent race between kill and signal
> 
> 
> If child gets killed before it completes signal(SIGTERM, SIG_DFL),
> then kill(childpid, SIGTERM) causes testcase to fail, because
> it is caught by LTP def_handler.
> 
> For example:
> dio_sparse    0  TINFO  :  Dirtying free blocks
> dio_sparse    0  TINFO  :  Starting I/O tests
> dio_sparse    1  TBROK  :  unexpected signal 15 received (pid =
> 10319).
> dio_sparse    2  TBROK  :  Remaining cases broken
> ...
> 
> Fix this by adding semaphore to wait until all children complete
> signal() before killing them.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c |   43
>  +++++++++++++++++++++++++-
>  1 files changed, 41 insertions(+), 2 deletions(-)
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
