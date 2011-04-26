Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QEnyO-0002j3-O5
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 19:31:00 +0000
Date: Tue, 26 Apr 2011 21:56:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110426195628.GA3852@saboteur.suse.cz>
References: <1624817233.26998.1303211901975.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20110426155618.GA28253@saboteur.suse.cz>
	<8DF67429-2B6C-4FF4-B95F-71D78645D239@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8DF67429-2B6C-4FF4-B95F-71D78645D239@gmail.com>
Subject: Re: [LTP] [PATCH v3] kill05: fix sporadic failures
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > I see, that was caused by replacing the my_getpwnam() by
> > SAFE_GETPWNAM().
> > 
> > Anyway my_getpwnam() is wrong hackend interface, we should get rid of
> > it. For next time Garrett note that getpwnam() is one of these
> > non-reentrant interfaces and do it correctly ;).
> 
> Is reentrancy the problem, or the fact that it uses a global variable
> for the struct passwd array in the backend?
> 

The problem here is that my_getpwnam() allocates the structure and copy
data returned getpwnam(). That way uid and gid is preserved (the other
structure members are pointers (strings) and these are statically
allocated too so these gets rewritten anyway).

See lib/libtestsuite.c

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
