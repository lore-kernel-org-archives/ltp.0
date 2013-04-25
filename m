Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UVNEW-0000mJ-EK
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 14:33:12 +0000
Date: Thu, 25 Apr 2013 16:34:07 +0200
From: chrubis@suse.cz
Message-ID: <20130425143406.GA3084@rei.suse.cz>
References: <8a051675195eceda293d88d157163083d7886570.1366724682.git.jstancek@redhat.com>
	<201304231211.28293.vapier@gentoo.org> <20130423164641.GI28044@rei>
	<201304231342.02090.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201304231342.02090.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] remove linux_syscall_numbers.h from tree
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
> > > is keeping it in the tree a big deal ?  i think it's pretty common for
> > > people to go into specific subdirs and run `make` and today, our
> > > subdirs don't declare a dependency on this file so it'll get
> > > automatically regenerated (nor do i think they should even bother).
> > 
> > You need to regenerate the file after each change to the *.in files,
> > and that means that people will forget from time to time.
> 
> so people aren't testing their commits ;)

Aparently they don't, I've reruned the script and the result is that git
diff shows 6125 lines of changes. And the last time the *.in files were
changed was 2010...

Which is another reason why we need proper solution.


What about we:

 1) Commit the up to date linux_syscall_numbers.h

 2) Add linux_syscall_numbers.h dependency on *.in
    
    - that would regenerate the file on change, but only
      from the top make and will catch the change
      most of the time

Which would IMHO be good short term fix and figure out something better
later.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
