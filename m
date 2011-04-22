Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QD71K-0001jA-Pd
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 03:27:02 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QD71K-0004vn-31
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 03:27:02 +0000
Received: by pxi15 with SMTP id 15so221938pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Apr 2011 20:26:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1303369996-4812-1-git-send-email-czhang@redhat.com>
References: <czhang@redhat.com>
	<1303369996-4812-1-git-send-email-czhang@redhat.com>
Date: Thu, 21 Apr 2011 20:26:55 -0700
Message-ID: <BANLkTiki_ft4JF=p4tUW5jmioHg-Txf8Yg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 0/2] use system_specific_hugepages_info.h/.c
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Thu, Apr 21, 2011 at 12:13 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> I found some tests in hugemmap uses
> $(topdir)/include/system_specific_hugepages_info.h while some others not.
> I also find some function overlaps in hugemmap tests, like getting
> hugepagesize or getting free hugepages, I believe we could move all these
> funtions to system_specific_hugepages_info.c and make the code simpler and
> cleaner.

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
