Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SO3a1-0007Si-4g
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 09:04:37 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO3a0-00066S-8b
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 09:04:37 +0000
Date: Sat, 28 Apr 2012 05:04:28 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <f6483acf-f911-471e-877c-74bd68237520@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2F2D931F-792A-425D-9BFE-D97AD02CDEF7@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] syscalls/move_pages: removed tst_exit in
	check_config()
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
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Garrett Cooper" <yanegomi@gmail.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Sent: Saturday, April 28, 2012 3:53:54 PM
> Subject: Re: [LTP] [PATCH 3/3] syscalls/move_pages: removed tst_exit in check_config()
> 
> On Apr 28, 2012, at 12:48 AM, Zhouping Liu wrote:
> 
> > removed tst_exit in check_config(), as it's always involked
> > at any time, instead, using tst_brkm to displace tst_resm,
> > since TCONF should be called by tst_brkm.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> 
> Reviewed-by: Garrett Cooper <yanegomi@gmail.com
> 

Hi, Garrett,
you missed to CC ltp-list.

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
