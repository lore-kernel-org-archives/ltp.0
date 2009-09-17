Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MoFhn-0001II-R1
	for ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 12:03:19 +0000
Date: Thu, 17 Sep 2009 14:03:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090917120306.GB26142@schrodinger.suse.cz>
References: <20090831174107.GB30788@schrodinger.suse.cz>
	<1252323725.4922.33.camel@subratamodak.linux.ibm.com>
	<20090907114715.GA10983@schrodinger.suse.cz>
	<1252324203.4922.37.camel@subratamodak.linux.ibm.com>
	<20090907160222.GA29017@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090907160222.GA29017@schrodinger.suse.cz>
Subject: Re: [LTP] [PATCH] broken epoll Makefile
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Also there are several directories that doesn't contain Makefile (or any files)
> so the are not used or not compiled anyway. IMHO they should be removed. For
> example in CVS tree:
> 
> in testcases/kernel/syscals/
> 
> epoll2
> epoll_create2
> create_module
> destroy_module
> getcontext01 
> ...
> 
> Empty directories are not exported to releases. At least it seems so, but still
> there are directories containing useless data, for example epoll2.
>

This part of was forgotten but it still makes work with cvs tree harder. Any
opinions?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
