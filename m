Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pp3rl-0003pV-9Z
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 19:13:45 +0000
Date: Mon, 14 Feb 2011 20:33:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110214193306.GA8468@saboteur.suse.cz>
References: <4D595337.5070801@nokia.com>
	<20110214154030.GC426@saboteur.suse.cz>
	<20110214165816.GA3734@saboteur.suse.cz>
	<AANLkTik5XNeSO8zjYXvsXDLt0VUVyr1FOUEiSC8agfhM@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTik5XNeSO8zjYXvsXDLt0VUVyr1FOUEiSC8agfhM@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix the file permissions and other issues in
 "fs_perms" tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> > In this case, I partially agree with you. It is true in the case of binary files. However, We need 'read' and 'exec'
> >> > for script files and these testcases deals with script files too.
> >> >
> >>
> >> Hmm I see the problem now. However as a root, I could read and run files
> >> with just an exec flag, at least here. I suppose the test works here by
> >> some saved-id magick. I'll look deeper into this.
> >>
> >
> > I think I've found the cause. The wait() funcion returns -1 if exec*
> > hasn't succeded to run the file (and sets the status to 0). I'm not sure
> > if this is POSIX compilant behaviour, I'll check on that later.
> 
>     Check errno and see what it says.

That seems to be feature, when running under strace (to avoid users
gaining root rights).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
