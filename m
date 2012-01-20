Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoFig-0001Ar-1n
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 14:45:34 +0000
Date: Fri, 20 Jan 2012 15:57:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120145745.GB15964@saboteur.suse.cz>
References: <CANoG8sUjtP3bMNjKNvwGO+Pb1GXJ6dYNDsYvjui=fd=fsYcQKw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANoG8sUjtP3bMNjKNvwGO+Pb1GXJ6dYNDsYvjui=fd=fsYcQKw@mail.gmail.com>
Subject: Re: [LTP] mbind01 fails on 2.6.32 i386 kernel
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> mbind01 fails on 2.6.32 i386 kernel, see test log below.  I went
> through http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08843.html
> but couldn't get any clue.  Any idea?
> 
> <<<test_start>>>
> tag=mbind01 stime=1326570882
> cmdline="mbind01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> mbind01     0  TINFO  :  (case00) START
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=-1 errno=38 (Function not implemented)
> mbind01     1  TFAIL  :  (case00) END: errno=???(38): Function not implemented

Hmm, the errno value suggests that the particular kernel doesn't have
such syscall implemented. Perhaps it was disabled in kernel .config.

Anyway the testcase should return TCONF rather than TFAIL in such case.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
