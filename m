Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SzkM9-0005UM-0H
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:14:05 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzkM6-0002ky-Il
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:14:04 +0000
Date: Fri, 10 Aug 2012 04:13:51 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <2069635652.36480140.1344586431604.JavaMail.root@redhat.com>
In-Reply-To: <5024BE51.6040202@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall
 availability
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "Caspar Zhang" <caspar@casparzhang.com>, "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Friday, August 10, 2012 3:54:57 PM
> Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall availability
> 
> On 08/10/2012 03:46 PM, Zhouping Liu wrote:
> > On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> >> some NUMA related syscalls: mbind, get_mempolicy are not supported
> >> on
> >> some arches (e.g. i386), this patch checks the syscalls'
> >> availability in
> >> setup() function, if the syscall is not implemented on the system,
> >> a
> >> TCONF message will be given like this:
> >>
> >> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not
> >> supported on your arch
> >>
> >> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> > 
> > Reviewed-by: Zhouping Liu <zliu@redhat.com>
> 
> Zhouping, 3/6 already has a V2 version.

yeah, sorry, I replied on a bad place. :(
thanks for your reminder :)

Thanks,
Zhouping

> 
> Thanks,
> Wanlong Gao
> 
> > 
> > Thanks,
> > Zhouping
> > 
> >> ---
> >>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   10
> >>  ++++++++++
> >>  testcases/kernel/syscalls/mbind/mbind01.c          |    9
> >>  +++++++++
> >>  2 files changed, 19 insertions(+), 0 deletions(-)
> >>
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Live Security Virtual Conference
> >> Exclusive live event will cover all the ways today's security and
> >> threat landscape has changed and how IT managers can respond.
> >> Discussions
> >> will include endpoint security, mobile security and the latest in
> >> malware
> >> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> >>
> >>
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > Live Security Virtual Conference
> > Exclusive live event will cover all the ways today's security and
> > threat landscape has changed and how IT managers can respond.
> > Discussions
> > will include endpoint security, mobile security and the latest in
> > malware
> > threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> > 
> > 
> > 
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
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
