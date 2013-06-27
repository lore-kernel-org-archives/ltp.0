Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsD9q-0002CY-WF
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 14:26:47 +0000
Date: Thu, 27 Jun 2013 16:28:18 +0200
From: chrubis@suse.cz
Message-ID: <20130627142818.GC21873@rei.suse.cz>
References: <1372259224-27804-1-git-send-email-alexey.kodanev@oracle.com>
	<20130627135544.GA21873@rei.suse.cz> <51CC49AE.9070601@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CC49AE.9070601@oracle.com>
Subject: Re: [LTP] [PATCH v2] lib: tst_run_cmd: add tst_run_cmd() to exec
 specified program
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > This version looks nearly fine. I would check the return value from
> > waitpid() too, just for the sake of completness.
> >
> So, something like this is ok:
> if (waitpid(pid, &ret, 0) != pid)
>      tst_brkm(..."waitpid failed at ...")

Yes.

> > And looking at the waitpid() documentation it states that it uses only
> > two bytes from ret (in reality it's cleared to zero but that is not
> > promised in specification).
> >
> > I would change the last condition to:
> >
> > if (!WIFEXITED(ret) || WEXITSTATUS(ret) != 0) {
> >
> > }
> But the waitpid() manual says that WEXITSTATUS should only be employed 
> if WIFEXITED returned true, so may be change it to:
> if (!WIFEXITED(ret) || (WIFEXITED(ret) && WEXITSTATUS(ret) != 0)) {
> ...
> }

The short circuit evaluation will take care of that.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
