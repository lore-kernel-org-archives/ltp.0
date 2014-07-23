Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1X9xtA-0005Oj-4E
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 14:51:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X9xt8-0004Cq-HX
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 14:51:28 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6NEpCaU010038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Jul 2014 10:51:19 -0400
Received: from tarantula.localdomain (vpn-238-213.phx2.redhat.com
	[10.3.238.213])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s6NEBK9m019071
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 23 Jul 2014 10:11:22 -0400
Date: Wed, 23 Jul 2014 09:11:20 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20140723141120.GK26140@tarantula.localdomain>
References: <20140703163617.GB5081@tarantula.localdomain>
	<20140703172829.GA12545@rei.scz.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140703172829.GA12545@rei.scz.novell.com>
Subject: Re: [LTP] sched_setparam{02,03} failures on 3.14 and newer kernels
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

On Thu, Jul 03, 2014 at 07:28:29PM +0200, chrubis@suse.cz wrote:
> The man 7 sched suggests that SCHED_FIFO and SCHED_RR priority must be >
> 0 at all times. So I guess that this is a bug and we need to find the
> patch that changed the kernel behavior.


A patch was posted yesterday to fix this bug in the kernel.

  http://marc.info/?l=linux-kernel&m=140608259706721&w=2

Jeff

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
