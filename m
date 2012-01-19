Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rnvvs-0006Ze-Vm
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 17:37:52 +0000
Date: Thu, 19 Jan 2012 18:50:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120119175000.GG10302@saboteur.suse.cz>
References: <1326899076-19591-1-git-send-email-carmelo.amoroso@st.com>
	<20120118162859.GB4024@saboteur.suse.cz> <4F18437F.8060500@st.com>
	<201201191223.23289.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201191223.23289.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] buildsys: use short format for git describe
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > Actually that is intended, as you could exactly determine which code you
> > > are running from the version. Perhaps we could remove the start of the
> > > hash as the date + number of patches determines the version pretty well.
> > > 
> > > Or is there a good reason why to shadow the exact version here?
> > 
> > No, I just thought that we wanted the pure date of LTP in the Version file.
> 
> i think when someone does a release, the new tag will be the closest thing, 
> and so the output will be just the stamp ...
> 
> but i don't make releases, so wtf do i know ;)

This is implemented just now as:

1. look if we are in git repository
2. if so -> use git describe to generate Version file
3. if not fallback to VERSION file
   (which is changed for every release and commit that changes
    this file is tagged with release date)

So if you download tarball from sf.net VERSION is used and you get the
correct version date.

If you checked out the git, you get result from git describe. That if
your HEAD points to the commit tagged with the Version is only the
version date, othervise it's closest tag + number of commits + start of
the git hash.

Hope this makes sense.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
