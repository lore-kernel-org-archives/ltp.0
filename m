Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SXqtl-0004bR-JG
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:33:29 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXqtf-0001mG-Po
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:33:29 +0000
Date: Fri, 25 May 2012 05:33:16 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <0cf106de-47ab-4f1a-a92d-c5183ab90af0@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FBF4DD9.6090803@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 0/2] move_pages: dont use hardcoded node numbers
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



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 25 May, 2012 11:16:09 AM
> Subject: Re: [LTP] [PATCH 0/2] move_pages: dont use hardcoded node numbers
> 
> > Jan Stancek (2):
> >   move_pages_support: use only allowed nodes
> >   move_pages: dont use hardcoded node numbers
> > 
> >  .../kernel/syscalls/move_pages/move_pages02.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages03.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages04.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages05.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages06.c      |   10 ++-
> >  .../kernel/syscalls/move_pages/move_pages07.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages08.c      |   12 +++-
> >  .../kernel/syscalls/move_pages/move_pages09.c      |    8 ++-
> >  .../kernel/syscalls/move_pages/move_pages10.c      |   13 +++-
> >  .../kernel/syscalls/move_pages/move_pages11.c      |   13 +++-
> >  .../syscalls/move_pages/move_pages_support.c       |   74
> >  ++++++++++++++++----
> >  .../syscalls/move_pages/move_pages_support.h       |    1 +
> >  12 files changed, 157 insertions(+), 39 deletions(-)
> > 
> 
> Looks like many duplications here... wondering if any chance putting
> them into a common function or something?
> 

That is probably good idea, because we may still find new places where can use it.
I'm thinking about something like numa_helper.a, which we could link with
mbind01, get_mempolicy01, move_pages, etc.

Or can you think of any better place where to put it?

Regards,
Jan

> Thanks,
> Caspar
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
