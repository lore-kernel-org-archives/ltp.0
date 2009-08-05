Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MYWU3-0002MD-Np
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 02:44:07 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYWTz-0003u3-C2
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 02:44:07 +0000
Message-Id: <5D25ED72-13B4-4ED7-959C-4974F4DF2FCA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Tue, 4 Aug 2009 21:43:51 -0500
Subject: [LTP] building LTP on fedora 10 or 11
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
To: LTP <ltp-list@lists.sourceforge.net>

Has anyone been able to build LTP on fedora 10 or 11.

When I try on a x86_64 fedora 10 box:

[galak@komodo ltp]$ make autotools
aclocal -I m4
autoconf
configure.ac:9: error: possibly undefined macro: AC_PROG_AR
       If this token and others are legitimate, please use  
m4_pattern_allow.
       See the Autoconf documentation.
make: *** [configure] Error 1

than if I run it again I get:

[galak@komodo ltp]$ make autotools
make: *** No rule to make target `m4/Makefile.am', needed by `m4/ 
Makefile.in'.  Stop.

I pretty much see the same behavior on fedora 11.  Tried both x86_64  
and PPC.

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
