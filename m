Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yhx0S-0000R2-9l
	for ltp-list@lists.sourceforge.net; Tue, 14 Apr 2015 09:19:44 +0000
Date: Tue, 14 Apr 2015 11:19:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150414091924.GA5816@rei>
References: <20150323094302.GA6349@rei> <20150402100925.GB28953@rei>
	<5523ED09.4050509@oracle.com> <20150407152706.GA12115@rei>
	<552B91F1.3050901@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <552B91F1.3050901@oracle.com>
Subject: Re: [LTP] LTP release
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> >> We have several issues in our sparc64 environment. Need a day or two to
> >> figure out whether they are test case issues or problems with our
> >> environment.
> >
> > Ok.
> >
> 
> Finally, there are only two test case issues:
>   * cpuhotplug04 fails if there is no 'online' file in 
> /sys/devices/system/cpu/cpuXX/
>   * sem_comm fails because it doesn't use 'union semun' with semctl()
> 
> Patches to the problems were sent.
> 
> I suppose that cpuhotplug* fixes may be postponed for a later time, but 
> it would be good to have the sem_comm fixes in this release.

The 'union semun' patches looks good, acked. Please push these.

And that should be, hopefully, last patches going into the release.

I will do a full testrun once these paches are pushed and if everything
works fine I will tag the release. Does everybody agree?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
