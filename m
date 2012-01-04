Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiT18-00067S-Qx
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 15:44:42 +0000
Date: Wed, 4 Jan 2012 16:55:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104155528.GD17717@saboteur.suse.cz>
References: <4F02E053.3060600@imgtec.com>
	<CAGH67wTn_dDLax16e7aQK9JxPSrm01vFVXn+F4dkOU1cuXHWnQ@mail.gmail.com>
	<20120104143030.GC15845@saboteur.suse.cz>
	<4F046059.9000202@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F046059.9000202@imgtec.com>
Subject: Re: [LTP] [PATCH 07/21] cgroup/getdelays: Squish uninitialized
 variable warning for old GCC compilers
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >If this is only to silence compiler warning I would commit this as it
> >is.
> >
> I studied the code over and over and cmd_type is never used
> uninitialized. So yes, it is just a simple fix to silence old
> compilers.

Seems so to me as well, commited.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
