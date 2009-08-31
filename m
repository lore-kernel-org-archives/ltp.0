Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mi60G-0004K7-ML
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 12:28:56 +0000
Date: Mon, 31 Aug 2009 14:17:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090831121735.GA12136@schrodinger.suse.cz>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
	<20090518191145.9777.22704.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090518191145.9777.22704.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH 16/21] Add sigreturn01 test for sigreturn syscall
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
To: Manas Kumar Nayak <maknayak@in.ibm.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Deepakraj B Himavantharaj <deepakraj@in.ibm.com>, pasky@suse.cz

Hi!
This test doesn't compile cleanly because on all linuxes I've try to do so
sigreturn() is not defined as manual says.

Instead of:

sigreturn(unsigned long __unused);

It's defined as:

extern int sigreturn (struct sigcontext *__scp) __THROW;

And it also seems to be unimplemented on linux.

Anyway after looking into the source and manual, the test seems to be testing
return value of call that does some magic on the stack of the process in order
to return from signal handler. And the "never return" in manual means IMHO that
execution path of the program is changed in a way the return value of sigreturn
can't be checked at all. To me it looks like some old and unused internal
kernel/glibc api that is not worth testing. So I vote for removing this one
from ltp.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
