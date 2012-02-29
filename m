Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1S2gZs-0005fi-G6
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 10:16:08 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S2gZm-00084w-Py
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 10:16:08 +0000
Date: Wed, 29 Feb 2012 05:15:55 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <6fa463f5-2ebf-444f-ae9c-c144f76991c4@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4F4DF6DA.1030506@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] fix the -I option and enable a larger numble to I
	option
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
Cc: ltp-list@lists.sourceforge.net

> > wrote:
> >> Hi,Garrett,
> >>
> >> could you please review the patch, and give me your comments.
> >> any suggestions are welcome.
> > 
> >     Wow, someone really lacked foresight when producing this API.
> >     Yes, there's a problem, but I disagree with your solution (in
> > particular because long long isn't necessarily going to remain
> > 64-bit
> > in the future). I think that a fixed size type applied to all of
> > these
> > affect areas would be better (uint64_t -- the POSIX defined
> > unsigned
> > 64-bit integer [1]).
> > Thanks,
> > -Garrett
> 
> /me bringing up with an old topic here...
> 
> This problem comes out again (in cpuset01 test). I think we need
> someone
> to fix it.

let me have a try again, I will make a patch later.

Thanks,
Zhouping

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
