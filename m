Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TQzQI-0006CG-J9
	for ltp-list@lists.sourceforge.net; Wed, 24 Oct 2012 11:46:58 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TQzQH-00068g-Ht
	for ltp-list@lists.sourceforge.net; Wed, 24 Oct 2012 11:46:58 +0000
Date: Wed, 24 Oct 2012 07:46:51 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <5788158.5571166.1351079211379.JavaMail.root@redhat.com>
In-Reply-To: <5083B7A5.5080000@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3 v2] new syscall test: migrate_pages02
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Sunday, 21 October, 2012 10:51:49 AM
> Subject: Re: [LTP] [PATCH 3/3 v2] new syscall test: migrate_pages02
> 
> 
> the rest look good for me, so
> 
> Reviewed-by: Zhouping Liu <zliu@redhat.com>
> 
> Thanks,
> Zhouping
> 

Thanks, I'll send v3 with your suggestions. I came across one
scenario where migrate_pages() reports success, but pages
are not moved. I'm trying to figure out whether this is real bug
or something wrong with testcase.

Regards,
Jan

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
