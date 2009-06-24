Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MJSTo-0005Zg-Ru
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 13:25:36 +0000
Date: Wed, 24 Jun 2009 15:24:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090624132433.GB28452@schrodinger.suse.cz>
References: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
Subject: Re: [LTP] Goals and milestones
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi,
> 1. Ltp crosscompile makefile push completion - need this to resolve  
> several issues with the current hacked make system and expedite  
> upgrades on our end. Hard goal: before July snapshot is released  
> (several items are dependent on a functioning upgrade). I will commit  
> in small, discrete patches to get the work done quicker, but I'll need  
> a makefile reviewer.

I'm currently working on cleaning ltp build system and quite big part of the
ltp in my tree is fixed. I'll send patch with preview here soon.

Basically it implements Makefile.include where all definitions are in one place
and removes all hacks in Makefiles as well as speeds up building.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
