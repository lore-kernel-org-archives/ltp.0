Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEHk5-0000p9-Qq
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 11:47:25 +0000
Date: Tue, 27 Aug 2013 13:47:33 +0200
From: chrubis@suse.cz
Message-ID: <20130827114733.GD10995@rei.Home>
References: <2060663a46bc8d66f90a9686c7fe4a83d21e40a4.1377594171.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2060663a46bc8d66f90a9686c7fe4a83d21e40a4.1377594171.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] proc01: add use-gss-proxy to known_issues list
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Following commit implemented non-blocking read for use-gss-proxy:
>   commit b161c144404c18f6a9e20e46b63828ae3c2eb093
>   Author: J. Bruce Fields <bfields@redhat.com>
>     Date:   Fri May 24 09:47:49 2013 -0400
>         svcrpc: implement O_NONBLOCK behavior for use-gss-proxy
> 
> Prior to this commit non-block read hanged, but it happened
> only in -rc kernels, which we can ignore.
> 
> Note, that this proc entry is available only when you load module
> auth_rpcgss.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
