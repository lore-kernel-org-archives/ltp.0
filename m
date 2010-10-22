Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1P9GtL-000315-2A
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 12:38:39 +0000
Date: Fri, 22 Oct 2010 14:47:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101022124750.GB19229@saboteur.suse.cz>
References: <4CBBAD30.6070403@windriver.com>
	<AANLkTi=aC63h6rTNsqJ5tJ22FOuAR9+SLyp-vTW9KYDK@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=aC63h6rTNsqJ5tJ22FOuAR9+SLyp-vTW9KYDK@mail.gmail.com>
Subject: Re: [LTP] [patch] sync_file_range01 change for arm
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
> > arm use __NR_sync_file_range2 not __NR_sync_file_range for system call.
> > the test casecheck __NR_sync_file_range for arm,
> > So test react "System doesn't support" for arm.
> > but actually arm use __NR_sync_file_range2 to support the system call.
> >
> > powerpc is big endian, arm is small endian, so the parameter dealing is
> > different.
> 
>     Not true. ARM can be biendian, just like MIPS...
>     A better test needs to be derived for endianness than this.

Actually there seems to be some little endian PPC machines out there,
see: http://lwn.net/Articles/408340/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
