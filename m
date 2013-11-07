Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeNET-00027o-2x
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 10:54:37 +0000
Date: Thu, 7 Nov 2013 11:54:12 +0100
From: chrubis@suse.cz
Message-ID: <20131107105412.GB27699@rei>
References: <525F76B7.4050705@oracle.com>
	<1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131021125723.GA2385@rei> <5268FDE5.5010408@oracle.com>
	<20131024121601.GC29706@rei> <52692C2F.3040903@oracle.com>
	<20131024143158.GA11150@rei> <526A2990.2000107@oracle.com>
	<20131031105549.GA2824@rei> <527B58E9.6050705@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527B58E9.6050705@oracle.com>
Subject: Re: [LTP] [PATCH] msgctl{08, 09, 10, 11}: cleanup
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Could you commit the 'infrastructure' patches (lib.mk and etc) to master?
> >> After that I will send the updated patches to msgctl{08, 09, 10, 11}
> >> (with additional cleanup and this new Makefile).
> > Sure, looking at the previous emails and patches there is this change in
> > include/mk/lib.mk that I will commit ASAP, the rest can go with your
> > fixes.
> Hi!
> 
> Maybe finish this?

The change in include/mk/lib.mk is in git since Oct 31 see abaa46 and
I've said that the change in Makefile.inc should go with your patches.

Is there anything that is still missing?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
