Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PPg9N-0007IE-Ps
	for ltp-list@lists.sourceforge.net; Mon, 06 Dec 2010 18:51:01 +0000
Date: Mon, 6 Dec 2010 20:04:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101206190423.GA10791@saboteur.suse.cz>
References: <20101203190723.GA2420@saboteur.suse.cz>
	<AANLkTikaYgYVWCz=wLrp028WRB2Yj=BLHAEA0td9Sk80@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikaYgYVWCz=wLrp028WRB2Yj=BLHAEA0td9Sk80@mail.gmail.com>
Subject: Re: [LTP] [PATCH] cleanup ar0 testcase
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The ar0 testcase, as the matter of a fact, doesn't need any of the object
> > files that are compiled from the file*.c. Attached patch removes them.
> >
> > Signed-off-by: Cyril Hrubis chrubis@suse.cz
> 

Looks like something gone wrong, the files are still there but empty and
effectively breaking the build.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
