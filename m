Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OgDWF-00012g-NI
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 09:10:43 +0000
Date: Tue, 3 Aug 2010 11:27:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100803092704.GA29069@saboteur.suse.cz>
References: <20100802155347.GA1878@saboteur.suse.cz>
	<AANLkTi=x46Wh1U_byaw-9mBkkYoMZvTeFnOWsAVEQni0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=x46Wh1U_byaw-9mBkkYoMZvTeFnOWsAVEQni0@mail.gmail.com>
Subject: Re: [LTP] ltp buildsystem bugreport
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
> "Don't expect a project that uses Makefiles to function properly with
> paths that have colons, spaces, etc to function properly". Keep things
> as simple as possible and you won't have issues with building LTP :).

Okay, at least add this into the INSTALL file so that other people
doesn't get confused as I did.

And now I need to figure out workaround for our friendly buildservice
that creates paths with colons by default...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
