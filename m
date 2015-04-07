Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YfVPP-0006VA-8X
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 15:27:23 +0000
Date: Tue, 7 Apr 2015 17:27:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150407152706.GA12115@rei>
References: <20150323094302.GA6349@rei> <20150402100925.GB28953@rei>
	<5523ED09.4050509@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5523ED09.4050509@oracle.com>
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
> >> It's about the time we start to prepare for next release. I will
> >> (hopefully) start runing latest git code and look for unexpected
> >> failures during this week. Everybody please try to run the latest
> >> git code and report any problems.
> >
> > I've seen email from Jan that the release is green from his side.
> > (haven't got it because we had an email outgate in the SUSE and it seems
> > some emails were lost :(, if you get errors for my suse email account do
> > not hestitate to resend).
> >
> > What is the status from the rest of you?
> >
> 
> We have several issues in our sparc64 environment. Need a day or two to 
> figure out whether they are test case issues or problems with our 
> environment.

Ok.

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
