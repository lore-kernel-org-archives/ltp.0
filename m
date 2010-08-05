Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ogyk6-0002j3-No
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 11:36:10 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3075690975
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Aug 2010 13:36:03 +0200 (CEST)
Date: Thu, 5 Aug 2010 13:52:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100805115237.GA14063@saboteur.suse.cz>
References: <20100805100954.GB11402@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100805100954.GB11402@saboteur.suse.cz>
Subject: Re: [LTP] just another make-3.80 bug
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

> When trying to build ltp from tarball (ltp-full-20100630.bz2) using
> make-3.80 for some reason automake rules kicks in so you need either
> comment out some rules from include/mk/automake.mk or compile autotools
> by hand (there is no recent automake on system with make-3.80).
> 
> # cat /etc/SuSE-release 
> SUSE Linux Enterprise Server 10 (x86_64)
> VERSION = 10
> PATCHLEVEL = 2
> 
> # make -v
> GNU Make 3.80
> Copyright (C) 2002  Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.
> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> 
> # tar xjf ltp-full-20100630.bz2 
> # cd ltp-full-20100630/
> # ./configure
> ...

Hmm, "make all" seems to work here, so it looks like make-3.80 is
picking up wrong default target here. And the same stands for
testcases/realtime/Makefile.

> # make
> make -C testcases/realtime autotools
> make[1]: Entering directory `/root/ltp-full-20100630/testcases/realtime'
> autoheader
> make[1]: autoheader: Command not found
> make[1]: *** [autoheader] Error 127
> make[1]: Leaving directory `/root/ltp-full-20100630/testcases/realtime'
> make: *** [testcases/realtime/configure] Error 2

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
