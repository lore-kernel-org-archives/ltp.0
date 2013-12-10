Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VqNeL-00076A-Ch
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 13:46:57 +0000
Date: Tue, 10 Dec 2013 14:46:22 +0100
From: chrubis@suse.cz
Message-ID: <20131210134622.GA25591@rei>
References: <1385443532.14061.0.camel@G08JYZSD130126>
	<20131210131737.GA25334@rei>
	<129748009.2529202.1386682206895.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <129748009.2529202.1386682206895.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] fchownat/fchownat01.c: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > > -uid_t uid;
> > > -gid_t gid;
> > > -
> > > -int myfchownat(int dirfd, const char *filename, uid_t owner, gid_t group,
> > > -	       int flags)
> > > -{
> > > -	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
> > > -}
> > 
> > Hmm, glibc 2.4 (first one with fchownat() support) has been released in
> > 2006. I wonder if seven years is long enough and if we can get rid of
> > the wrapper now... Moreover I'm not sure what is the status of
> > alternative libc implementations.
> > 
> > There still may be enterprise distributions that still have older glibc
> > than that. Anybody out there?
> 
> To my knowledge the oldest RHEL LTP is run against is RHEL5.3,
> which has glibc 2.5.

It seems to be glibc 2.4 for SLES10 SP3, which is just barely enough.

So I would just keep the wrapper for a few more years. Or even better we
should create a configure check for the fchownat() syscall and define
the wrapper only when it's not available.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
