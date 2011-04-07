Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q7uiJ-0007pc-HP
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 19:17:55 +0000
Date: Thu, 7 Apr 2011 21:41:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110407194144.GB24025@saboteur.suse.cz>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
	<20110307072901.GB2877@hpt.nay.redhat.com>
	<20110406191955.GA19123@saboteur.suse.cz>
	<BANLkTik=ZwxHTEgF_E9UeC1Tutx-MRnMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTik=ZwxHTEgF_E9UeC1Tutx-MRnMkw@mail.gmail.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
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
> >> > Not all systems have /bin/true. It would be better to do:
> >> >
> >> > /bin/sh -c ':'
> >> >
> >> > etc, as we have code that depends on this type of shell-required POSIX behavior.
> >> >
> >> I'm sorry for I cannot figure out how to do this way. I tried, but
> >> cannot crash unpatched kernel anymore. So I think the simple workaround
> >> is checking if /bin/true installed in the program:
> >
> > It should as simple as execve("/bin/sh -c ':'", c, c), or that didn't work?
> 
> execve doesn't work that way. It should be:
> 
> execve("/bin/sh", "sh", "-c", ":");

Ahh, right, so it's difficuilt in this case as it seems that trigger is
particulary big argv and envp (at least it seems so from the source,
some better description wouldn't harm too).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
