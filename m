Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGDjC-0004uc-PB
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 19:22:14 +0000
Date: Thu, 14 Mar 2013 20:22:54 +0100
From: chrubis@suse.cz
Message-ID: <20130314192253.GA10636@rei.suse.cz>
References: <1363279568-9965-1-git-send-email-markos.chandras@gmail.com>
	<20130314172217.GE8894@rei.suse.cz>
	<CAG2jQ8ib0+MSxmYqZsj0jaJB5kJhJv9N4OMu_wfQpc9EY6_QkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG2jQ8ib0+MSxmYqZsj0jaJB5kJhJv9N4OMu_wfQpc9EY6_QkA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] syscalls/getdents: Add parameter to test
 getdents64 syscall
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > What exactly is this needed for? The getent64 function and
> > linux_dirent64 are both declared in the getdents.h.
> 
> It's needed for getting the struct dirent64 definition. See
> /usr/include/bits/dirent.h
> 

Ah right, so we have dirent dirent64 linux_dirent and linux_dirent64 two
for the userspace and two for the syscalls.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
