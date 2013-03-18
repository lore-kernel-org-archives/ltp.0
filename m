Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UHZBO-0002M4-7X
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 12:28:54 +0000
Date: Mon, 18 Mar 2013 13:29:38 +0100
From: chrubis@suse.cz
Message-ID: <20130318122937.GB3423@rei>
References: <1363604093-6960-1-git-send-email-markos.chandras@gmail.com>
	<20130318121509.GA3423@rei>
	<CAG2jQ8gAOvbKsoggS3o1a_9zDfVhUU9WUpxgY0g_Mp-ZcCC99w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG2jQ8gAOvbKsoggS3o1a_9zDfVhUU9WUpxgY0g_Mp-ZcCC99w@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] syscalls/getdents: Add parameter to test
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
> >> +     if (longsyscall)
> >> +             free(dirp64);
> >> +     else
> >> +             free(dirp);
> >> +
> >>       cleanup();
> >>
> >>       tst_exit();
> >
> > You don't need to bother to free the buffers when the next thing the
> > test does is exit, the whole heap along with malloc data structures will
> > be freed (unmapped) by the kernel anyway.
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> Hi Cyril,
> 
> I understand. Should I send a new patch or maybe you could fix it
> before committing it?

I will fix that.

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
