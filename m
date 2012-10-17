Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOQas-0005oD-TL
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 10:11:18 +0000
Date: Wed, 17 Oct 2012 12:09:02 +0200
From: chrubis@suse.cz
Message-ID: <20121017100902.GB26815@rei.Home>
References: <502496C6.3090906@cn.fujitsu.com>
	<20121003130640.GD22986@saboteur.suse.cz>
	<5077DDA1.1000206@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5077DDA1.1000206@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4] pthread_cond_brodcast/1-2.c hung when mem left
 is not enough
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > And actually I think that free ram itself is enough to figoure out
> > available memory as the kernel tends to eat as many memory for buffers
> > as available and reclaims it back only when needed.
> > 
> 
> Unfortunately i'v not got other good ideas.
> Do you have any suggestion?

There are several ways how to fix this.

One is to assume usable ram as free + buffers/N where N > 1

Another is to assume usable ram from total amount of RAM as
(total - M)/N where M statically reserved size and N > 1.

The problem is to choose the constats carefully so that we excersize the
system enough but don't overload it.

After you figure out this part, the patch with sysinfo() in header in
include is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
