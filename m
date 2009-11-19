Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NB4cR-0004gZ-FD
	for ltp-list@lists.sourceforge.net; Thu, 19 Nov 2009 10:52:07 +0000
Date: Thu, 19 Nov 2009 11:51:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091119105150.GB14472@schrodinger.suse.cz>
References: <20091105192746.GA30521@schrodinger.suse.cz>
	<8368651DACC1964480F951191B94A078016A1F41@svexch01.mvista.com>
	<20091116162303.GC16811@schrodinger.suse.cz>
	<8368651DACC1964480F951191B94A078017CB7CB@svexch01.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8368651DACC1964480F951191B94A078017CB7CB@svexch01.mvista.com>
Subject: Re: [LTP] rt_sigqueueinfo
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I checked the value of (1024 / (8 * sizeof (unsigned long int))) and it is 32
> on both our mips, mips64, and x86 targets. Calling ppoll fails with invalid
> argument error in all of these cases. I don't see a
> user/include/sigset/bits.h header in our userland, but _SIGSET_NWORDS macro
> also returns 32 when printed out.

My mistake, the last size argument is sizeof(sigset_t) but not the userspace
one but the kernel sigset_t (that is defined as bitfield big enough for all
signals). Glibc pases _NSIG/8 here which seems to be correct (as _NSIG is
defined as 128 on mips).

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
