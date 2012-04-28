Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SO3b8-0007Ua-I5
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 09:05:46 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO3b7-00081s-LK
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 09:05:46 +0000
Date: Sat, 28 Apr 2012 05:05:38 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <e673722d-9ed0-4943-b6bf-5ebda472b7bd@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <5f459a2d-8dca-42ca-bff1-bd96d9e019a4@zmail13.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] m4/ltp-numa.m4: fixed numa config
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
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "Garrett Cooper" <yanegomi@gmail.com>
> Sent: Saturday, April 28, 2012 4:58:52 PM
> Subject: Re: [LTP]  [PATCH 1/3] m4/ltp-numa.m4: fixed numa config
> 
> 
> 
> > On Apr 28, 2012, at 12:48 AM, Zhouping Liu wrote:
> > 
> > > numa_alloc_onnode() and numa_move_pages() all need numa lib
> > > '-lnuma',
> > > but in ltp-numa.m4, we just checked the two functions using
> > > AC_CHECK_FUNCS, without the patch, it always report such error
> > > log in numa system: "undefined reference to `numa_alloc_onnode`",
> > > which blocked syscalls/move_pages/* cases, the patch fixed it.
> > > 
> > > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > 
> > I believe the real bug was that AC_CHECK_FUNCS accepts a list like:
> 
> I don't think so.
> 
> as AC_CHECK_FUNCS checks for the existence of functions in the C
> standard library,
> but numa_alloc_onnode and numa_move_pages are not in C standard
> library, they
> need '-lnuma', so AC_CHECK_FUNCS can't detect the two functions even
> though they
> are available.
> 
> I'm not practised to m4, please correct me if I'm wrong :(
> 
> > 
> > AC_CHECK_FUNCS([printf scanf])
> > 
> > The other format implemented in the code was for:
> > 
> > funcs,if-found,if-not-found
> > 
> > Thanks!
> > -Garrett
> > 

Forgot to CC ltp-list :(

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
