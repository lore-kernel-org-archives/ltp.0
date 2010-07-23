Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OcDjd-0002qO-8C
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 08:36:01 +0000
Date: Fri, 23 Jul 2010 10:51:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100723085121.GA15257@saboteur.suse.cz>
References: <20100722142216.GA3593@saboteur.suse.cz>
	<AANLkTikxgQkrxYRKgNe_CPrU9-pFKslpstzqMxDMN3pm@mail.gmail.com>
	<20100722183850.GA18490@saboteur.suse.cz>
	<AANLkTikuRkjhGOi_Azyb9Ij18ZNCuZhj65hP_fFj5goO@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikuRkjhGOi_Azyb9Ij18ZNCuZhj65hP_fFj5goO@mail.gmail.com>
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
> >> > When doing 'make install' in ltp/testcases/realtime/ the process stops
> >> > because the dummy makefile generated from empty Makefile.am is not
> >> > correct makefile (has unmakeable targets). This could be easily fixed by
> >> > adding m4 to FILTER_OUT_DIRS.
> >> >
> >> > Patch attached.
> >>
> >> I understand the issue that you're trying to address, but have you
> >> tried to do make distclean from the top and then rerun the build? Does
> >> it work?
> >
> > No, it broke even more, now 'make' doesn't work too. Anyway is there a
> > point for running Makefile generated from empty Makefile.am?
> 
>     The process is:
> 
> make distclean
> make autotools
> ./configure {blah}
> 

git clone ltp-next
make distclean
make autotools
./configure
cd testcases/realtime/
make
DESTDIR=/tmp/ make install

---- snip ----
make[2]: Entering directory
`/home/metan/Work/git/ltp-next-local/testcases/realtime/m4'
make[2]: *** No rule to make target `install-exec-am'.  Stop.
make[2]: Leaving directory
`/home/metan/Work/git/ltp-next-local/testcases/realtime/m4'
make[1]: *** [install-am] Error 2
make[1]: Leaving directory
`/home/metan/Work/git/ltp-next-local/testcases/realtime/m4'
make: *** [install] Error 2


automake (GNU automake) 1.11.1
autoconf (GNU Autoconf) 2.65
make GNU Make 3.81

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
