Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UO2cv-00065u-3E
	for ltp-list@lists.sourceforge.net; Fri, 05 Apr 2013 09:08:05 +0000
Date: Fri, 5 Apr 2013 11:08:52 +0200
From: chrubis@suse.cz
Message-ID: <20130405090851.GC18134@rei.Home>
References: <1365125797-31405-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<201304050053.46087.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201304050053.46087.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] getdents01: don't compare first entry to "."
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
> >  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -		const char *d_name;
> > -
> >  		tst_count = 0;
> > 
> >  		if ((fd = open(".", O_RDONLY)) == -1)
> > @@ -102,15 +100,7 @@ int main(int ac, char **av)
> >  			continue;
> >  		}
> > 
> > -		if (longsyscall)
> > -			d_name = dirp64->d_name;
> > -		else
> > -			d_name = dirp->d_name;
> > -
> > -		if (strcmp(d_name, "."))
> > -			tst_resm(TFAIL, "First entry is not '.'");
> > -		else
> > -			tst_resm(TPASS, "call succeeded");
> > +		tst_resm(TPASS, "call succeeded");
> > 
> >  		if (close(fd) == -1)
> >  			tst_brkm(TBROK, cleanup, "file close failed");
> 
> this test isn't really useful after your change.  you've basically validated 
> that the a valid fd and a large enough buffer was passed to the kernel and 
> that's it.
> 
> you should have it walk the results to try and find an "." and ".." entry.

Yes, that would be even better. Or we can get even more creative and
create a file or two in the setup and expect them to be in the listing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
