Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgdAy-00058w-A6
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 15:15:48 +0000
Date: Thu, 6 Dec 2012 16:15:36 +0100
From: chrubis@suse.cz
Message-ID: <20121206151536.GD29885@rei.nue.novell.com>
References: <8fbb13b857a614a0daf5dffdfb385871fce2e990.1354708056.git.jstancek@redhat.com>
	<20121206093057.GA2340@rei.nue.novell.com>
	<50C06733.2000903@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C06733.2000903@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite/.../aio_red/7-1.c: fix race
 at exit
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> +	while (aio_error(&aiocb) == EINPROGRESS)
> >> +		;
> >> +
> > 
> > That creates unnecessary bussy-loop here, I usually add reasonally small
> > usleep to such loop to avoid that. Something like usleep(10000) would
> > do.
> 
> Yeah, that's reasonable, so we have the same problem in almost all of the cases
> under aio_read/ and aio_*/

As usuall, do you care to send a patch or should I look into this issue?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
