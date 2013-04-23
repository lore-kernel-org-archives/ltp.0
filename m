Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUhd7-0002j4-KB
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 18:07:49 +0000
Date: Tue, 23 Apr 2013 20:08:43 +0200
From: chrubis@suse.cz
Message-ID: <20130423180843.GA330@rei.Home>
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

Well, I do not like to increase number of things to check for a commit.
Fixing the testcases is complicated enough...

> > It would be better to add another rule to testcases.mk similiar to the
> > one for LIBLTP.
> 
> those rules only generate libltp.a if the file doesn't already exist.  so 
> tweaking that would be like the status quo, but worse in that `git pull` is 
> now guaranteed to not update the file :).

Hmm, I would expect that the library will be rebuild after some of it's
sources has changed. And we aren't doing that, I would call such
behavior a bug.

But thinking of consequencies, changing it carelessly would most likely
break parallel make.

> i don't want to add things like `make -C testcases/kernel/include/` as then 
> you'll have multiple subdirs processing the same thing.  maybe if we had a .mk 
> file in testcases/kernel/include/ that testcases.mk could include, and if the 
> top level testcases/kernel/ make sure we process that first before any subdirs.

I see.

Or we get this behavior if we set a flag in toplevel Makefile and the
header would be regenerated (in the leaf Makefile) only if the toplevel
flag is not set. And we could do the same for the library as well.

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
