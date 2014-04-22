Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcXCm-0000rt-2X
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 09:41:32 +0000
Date: Tue, 22 Apr 2014 11:40:38 +0200
From: chrubis@suse.cz
Message-ID: <20140422094037.GC2269@rei>
References: <53552199.6040004@oracle.com> <20140422091639.GA2269@rei>
	<53563605.9060200@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53563605.9060200@oracle.com>
Subject: Re: [LTP] OpenPosix mmap_11-4 fails
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
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> >> I took your test program from the man thread and executed it on KVM and
> >> on an Sun Ultra 45.
> >>
> >> Here are the results:
> >>
> >> 1. Debian 7 + KVM + 3.2.0-4-amd64
> >>    * without msync() it fails
> >>    * with msync() it fails
> >>
> >> 2. Debian 7 + Ultra + 3.2.0-4-sparc64-smp
> >>    * without msync() it fails
> >>    * with msync() it passes (!!!)
> >>
> >> So it looks like msync() on x86 doesn't help us. The question here if
> >> it's a linux+x86 bug or not...
> >
> > Is the /tmp/ filesystem the same?
> 
> yes, ext4 in both cases.

That may be the a clue, the failures I've seen were on ext4 as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
