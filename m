Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O7Unm-00080r-1b
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 14:33:18 +0000
Date: Thu, 29 Apr 2010 16:41:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100429144103.GB31732@saboteur.suse.cz>
References: <20100426184810.GB14970@saboteur.suse.cz>
	<i2m364299f41004261921o95a78215y24530ea8aaed1d2d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <i2m364299f41004261921o95a78215y24530ea8aaed1d2d@mail.gmail.com>
Subject: Re: [LTP] [PATCH] add missing include into rpc1.c
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
> > Following patch adds missing include unistd.h needed for gethostbyname() and
> > getpid() into rpc1.c.
> >
> > Signed-off-by: Cyril Hrubis chrubis@suse.cz
> 
> I agree with getpid needing unistd.h, but not gethostbyname(3):
> 
> http://linux.die.net/man/3/gethostbyname

You are right, the function I wanted to point out is gethostname(2) and typed
gethostbyname() accidentally.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
