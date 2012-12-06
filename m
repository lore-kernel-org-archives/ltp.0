Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgXzX-0007HB-Gb
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 09:43:39 +0000
Date: Thu, 6 Dec 2012 10:43:28 +0100
From: chrubis@suse.cz
Message-ID: <20121206094327.GB2340@rei.nue.novell.com>
References: <1835266843.9449106.1354527440428.JavaMail.root@redhat.com>
	<50BCA312.7070508@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50BCA312.7070508@st.com>
Subject: Re: [LTP] clone03/06 randomly crashing
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > It appears to be ltp-pan, which sees the child as orphan.
> > When I added "-d 511", I've got some additional output:
> > 
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=0 corefile=no
> > cutime=0 cstime=0
> > <<<test_end>>>
> > pids still running: 
> > orphans still running: -26125 
> > clone03     1  TBROK  :  unexpected signal 15 received (pid = 26126).
> > clone03     2  TBROK  :  Remaining cases broken
> > 
> > pan was signaled with sig 2...
> >   propagating sig 2 to orphaned pgrp -26125
> > orphans still running: 
> > 
> > I'll send a patch, that adds wait() to parent.
> >
> > Regards,
> > Jan
> 
> Hi Jan,
> I think you're right. We have hit similar problems with setrlimit01, and
> few other tests.
> 
> Unfortunately we did not upstream these patches as we are still working
> with an older LTP.

Is there any reason for that? I try not to break anything and stay as
backward compatible as possible. I know that for maintenance people
usually use the version that was used for release testing and stick to
this through the product life cycle.

Anyway if there are some changes or bugs that prevents you from using up
to date LTP please let us know.

> I'll try to rebase it and share some other pending patches we are using
> in our project.

I'm looking forward to see the patches.

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
