Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Oc0Qe-0007sE-R3
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 18:23:32 +0000
Date: Thu, 22 Jul 2010 20:38:50 +0200
From: chrubis@suse.cz
Message-ID: <20100722183850.GA18490@saboteur.suse.cz>
References: <20100722142216.GA3593@saboteur.suse.cz>
	<AANLkTikxgQkrxYRKgNe_CPrU9-pFKslpstzqMxDMN3pm@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikxgQkrxYRKgNe_CPrU9-pFKslpstzqMxDMN3pm@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix make install in ltp/testcacses/realtime/
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
> > When doing 'make install' in ltp/testcases/realtime/ the process stops
> > because the dummy makefile generated from empty Makefile.am is not
> > correct makefile (has unmakeable targets). This could be easily fixed by
> > adding m4 to FILTER_OUT_DIRS.
> >
> > Patch attached.
> 
> I understand the issue that you're trying to address, but have you
> tried to do make distclean from the top and then rerun the build? Does
> it work?

No, it broke even more, now 'make' doesn't work too. Anyway is there a
point for running Makefile generated from empty Makefile.am?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
