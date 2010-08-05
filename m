Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Oh0D5-0003na-VS
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 13:10:11 +0000
Date: Thu, 5 Aug 2010 15:26:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100805132641.GA18296@saboteur.suse.cz>
References: <20100805100954.GB11402@saboteur.suse.cz>
	<CCCBABDC-C276-4064-982D-179B86A30991@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CCCBABDC-C276-4064-982D-179B86A30991@gmail.com>
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
To: Garrett Cooper <yaneurabeya@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > When trying to build ltp from tarball (ltp-full-20100630.bz2) using
> > make-3.80 for some reason automake rules kicks in so you need either
> > comment out some rules from include/mk/automake.mk or compile autotools
> > by hand (there is no recent automake on system with make-3.80).
> > 
> > # cat /etc/SuSE-release 
> > SUSE Linux Enterprise Server 10 (x86_64)
> > VERSION = 10
> > PATCHLEVEL = 2
> > 
> > # make -v
> > GNU Make 3.80
> > Copyright (C) 2002  Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.
> > There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> > PARTICULAR PURPOSE.
> > 
> > # tar xjf ltp-full-20100630.bz2 
> > # cd ltp-full-20100630/
> > # ./configure
> > ...
> > 
> > # make
> > make -C testcases/realtime autotools
> > make[1]: Entering directory `/root/ltp-full-20100630/testcases/realtime'
> > autoheader
> > make[1]: autoheader: Command not found
> > make[1]: *** [autoheader] Error 127
> > make[1]: Leaving directory `/root/ltp-full-20100630/testcases/realtime'
> > make: *** [testcases/realtime/configure] Error 2
> 
> 	You're missing some autotools commands on the box (in this case autoheader). Make sure that autoconf is installed and/or all of the directions were followed as per INSTALL.

That's not the problem, see the second mail in this thread, make-3.80
seems to be picking wrong default target (even when autotools are
installed running 'make' just remakes autools related stuff.)

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
