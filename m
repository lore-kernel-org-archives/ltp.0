Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiVDZ-0004pB-UC
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 18:05:41 +0000
Date: Wed, 4 Jan 2012 19:16:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104181632.GA22278@saboteur.suse.cz>
References: <611ED426031E9E48A80D02BED70BC810570E4F83@ALA-MBA.corp.ad.wrs.com>
	<201201012038.24370.vapier@gentoo.org>
	<20120104151306.GA17717@saboteur.suse.cz>
	<201201041259.45075.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201041259.45075.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)
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
Cc: ltp-list@lists.sourceforge.net, "Shang,  YanFeng" <YanFeng.Shang@windriver.com>

Hi!
> > > > Well, the open posix testsuite project seems to be dead for some time
> > > > (at least four years) so having fork is only natural. Do you know some
> > > > of the original authors? Maybe we can just ask them to update the
> > > > sf.net pages to redirect people to LTP.
> > > 
> > > if the maintainers opened up access, i think it'd make more sense to
> > > divest LTP of the testsuite and merge all our local changes back.
> > 
> > I would disagree here. This would possibly add burden of maitaing the
> > code in two places, simple redirect to forked project is better solution
> > here.
> 
> no it wouldn't.  the implication would be that LTP would no longer duplicate 
> the code base in the LTP tree.  it makes no sense.
> 
> if people want it as part of the LTP release, well that still is trivial to 
> do: have the open posix testsuite be a git submodule in the LTP git repo.

Ah, sorry for my misunderstanding, moving it there makes more sense than
having it in both places. But still then people would send patches
against it to the LTP mailing list (which is not problem as far as there
are some people who are maitaining both projects).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
