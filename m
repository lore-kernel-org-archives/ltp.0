Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOW8n-0006Pe-29
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 16:06:41 +0000
Date: Wed, 17 Oct 2012 18:04:29 +0200
From: chrubis@suse.cz
Message-ID: <20121017160429.GD27890@rei>
References: <507D6C63.5040704@mips.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <507D6C63.5040704@mips.com>
Subject: Re: [LTP] [PATCH] Avoid compiler optimisation of malloc calls
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
To: Chris Dearman <chris@mips.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> clang understands the malloc library call and can optimise calls to
> it. In particular it will avoid calling malloc completely if it
> detects that the result is not used.

Both patches are okay, but seems to be corrupted (git am wasn't able to
understand them).

Could you send these again (possibly with git send-email) or send a pull
request from repo forked on github or anything else that would work?

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
