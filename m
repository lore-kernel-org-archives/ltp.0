Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJQdo-0006nd-KY
	for ltp-list@lists.sourceforge.net; Fri, 19 Nov 2010 13:04:36 +0000
Date: Fri, 19 Nov 2010 14:16:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101119131630.GC19564@saboteur.suse.cz>
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
	<AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
	<4CCE73A6.9020901@cn.fujitsu.com>
	<AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
	<4CE4AD0D.1050501@cn.fujitsu.com>
	<AANLkTim5JubFxad76akVJ7YOVs1V84gY=2TUVQ1KMkJz@mail.gmail.com>
	<4CE4B2B6.4030408@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CE4B2B6.4030408@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ?c?? ???s <toza@ryobi.co.jp>, ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Hi!
> >>>> ...
> >>>>>>  int main()
> >>>>>>  {
> >>>>>> @@ -133,6 +152,12 @@
> >>>>>>
> >>>>>>        struct sigaction sa;
> >>>>>>
> >>>>>> +       /* Checking for Kernel Version */
> >>>>>> +       if ( kernel_ver_cmp(2, 6, 21) != 0 )
> >>>>>> +       {
> >>>>>> +               UNTESTED( "sem_wait() returned EINTR on kernel versions
> >>>>>> lower than 2.6.22" );
> >>>>>> +       }
> >>>>>> +
> >>>>>>        /* Initialize output */
> >>>>>>        output_init();
> >>>>>>
> >>>>>> ============
> >>>>>>
> >>>>>> Above patch is revision only for templates.
> >>>>>> The following procedure is necessary after applying patch:
> >>>>>> ------------
> >>>>>> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> >>>>>> #./gentests.pl
> >>>>>> ------------
> >>>>>>
> >>>>>> Similar revisions are necessary for other 25 "sigaction" tests.
> >>>>>     Sorry, but Linux-isms can't leak into the open_posix_testsuite.
> >>>>> Same with BSDisms (at least they shouldn't... if they do, then slap me
> >>>>> or whoever did the commit).
> >>>> Do you mean the culprit is Linux-isms?
> >>> Mitani-san is proposing that I `fix' the testcases to work on RHEL
> >>> 4.8. These testcases should function with minimal change for all
> >>> versions of Unix.
> >>>
> >>  This open_posix_suite is the part of LTP(linux test project), must we
> >> make sure it can work at all versions of unix?
> > 
> > I use it in FreeBSD and others have used it in other versions of Unix
> > (in the past), based on the README. There's no reason why we need to
> > maintain something that philosophically diverges from the upstream
> > project's goal because it will make merging more painful and
> > unnecessary.
> > 
> 
>   OK, i get it. Thanks. ^_^
> 
>   Then, whether should we remove the following case, because it invokes
>   the uname that it's not exsit at 4.3 BSD.
>   conformance/interfaces/pthread_mutex_init/speculative/5-2.c
> 

The uname() is part of the POSIX, for sure it's available on BSD.

Thinking of it, the patch that checks for kernel version only when
sysname == Linux should compile and work. But the question here is if we
want to bloat the tests with workarounds for broken systems. I would
rather see this covered by a database of known issues, so you can easily
copare results and read why your system is broken.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
