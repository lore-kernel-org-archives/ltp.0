Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SoAth-00048p-Ew
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:08:53 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoAtg-0000Fj-7j
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:08:53 +0000
Date: Mon, 09 Jul 2012 06:08:45 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <c16878af-92cd-4354-b3ef-8e442556877a@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] mm/lib: ksm code style fixes.
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Monday, July 9, 2012 5:51:52 PM
> Subject: [PATCH 1/2] mm/lib: ksm code style fixes.
> 
> 
> This patch gives some minor fixes to the following two commits:
> 
> f9ae09a lib/mem.c: using read_file to replace the redundant code
> 60c41a5 lib/mem.c: add _wait_ksmd_done func to wait ksmd finish his
> job
> 
> to make the codes cleaner and easier to understand.

Looks good for me.

Reviewed-by: Zhouping Liu <zliu@redhat.com>


> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/lib/mem.c |   69
>  +++++++++++++++------------------------
>  1 files changed, 27 insertions(+), 42 deletions(-)
> 
> 

-- 
Thanks,
Zhouping

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
