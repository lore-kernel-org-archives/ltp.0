Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhGny-0004BU-W3
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 11:11:31 +0000
Date: Mon, 5 May 2014 13:10:32 +0200
From: chrubis@suse.cz
Message-ID: <20140505111032.GB1544@rei>
References: <1398419188-17193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<53676144.20306@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53676144.20306@oracle.com>
Subject: Re: [LTP] [PATCH] sigaction 9-1, 10-1,
 11-1: use SIGKILL instead of SIGHUP
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > There are test environments, where the SIGHUP signal may be either
> > added to the signal mask or ignored. One example of such environments
> > is Autotest, which sets the SIGHUP signal to SIG_IGN for its jobs.
> >
> > Therefore the above test cases hang in that environment because their
> > parent processes send SIGHUP to terminate the child (and the child ignores it).
> >
> > I think it will not be a problem to use SIGKILL here instead of SIGHUP, because
> > SIGKILL can not be caught, blocked, or ignored.
> > And it does the job - stopping the child - very well :)
> >
> > Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> 
> Could anybody look at this patch, please?

Looks OK to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
