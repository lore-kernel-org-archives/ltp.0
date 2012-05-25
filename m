Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SXude-0005zL-4X
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 13:33:06 +0000
Date: Fri, 25 May 2012 15:30:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120525133050.GA32516@saboteur.suse.cz>
References: <0cf106de-47ab-4f1a-a92d-c5183ab90af0@zmail17.collab.prod.int.phx2.redhat.com>
	<4FBF5672.5090306@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FBF5672.5090306@redhat.com>
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>>   move_pages_support: use only allowed nodes
> >>>   move_pages: dont use hardcoded node numbers
> >>>
> >>>  .../kernel/syscalls/move_pages/move_pages02.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages03.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages04.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages05.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages06.c      |   10 ++-
> >>>  .../kernel/syscalls/move_pages/move_pages07.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages08.c      |   12 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages09.c      |    8 ++-
> >>>  .../kernel/syscalls/move_pages/move_pages10.c      |   13 +++-
> >>>  .../kernel/syscalls/move_pages/move_pages11.c      |   13 +++-
> >>>  .../syscalls/move_pages/move_pages_support.c       |   74
> >>>  ++++++++++++++++----
> >>>  .../syscalls/move_pages/move_pages_support.h       |    1 +
> >>>  12 files changed, 157 insertions(+), 39 deletions(-)
> >>>
> >>
> >> Looks like many duplications here... wondering if any chance putting
> >> them into a common function or something?
> >>
> > 
> > That is probably good idea, because we may still find new places where can use it.
> > I'm thinking about something like numa_helper.a, which we could link with
> 
> I have no objection doing that.
> 
> Cyril, suggestions?

Yes, that is always a good idea. The easiest thing to do is to create a
common.c file and include it in each of the tests (which I would do if
the amount of shared code is relatively small and is used only by the
tests in current directory). Otherwise you may do the usual library
thing with actual headers and link tests against it...

-- 
Cyril Hrubis
chrubis@suse.cz

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
