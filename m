Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WG7ub-0000xd-Jw
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 14:14:09 +0000
Date: Wed, 19 Feb 2014 15:13:57 +0100
From: chrubis@suse.cz
Message-ID: <20140219141356.GB2138@rei>
References: <D29743B70598864B880A3BE89C6E96946FEA75@USCHMBX004.nsn-intra.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D29743B70598864B880A3BE89C6E96946FEA75@USCHMBX004.nsn-intra.net>
Subject: Re: [LTP] Support needed for LINUX POSIX compliance test
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
To: "Bola, Pradeep (EXT-Tata Consultancy Ser - US/Arlington Heights)" <pradeep.bola.ext@nsn.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> We are planning to use LTP for doing POSIX compliance test for one of our project.
> LTP covers most of the LINUX POSIX functions.
> 
> But I am unable to test few of the stdio POSIX functionalities.
> Few of POSIX functions: atoi, atol, calloc, malloc, free, errno, scanf, sprints, system etc .

I've looked around and indeed there are no tests designed specially for
these calls. But quite franky if any of these functions are broken quite
a lot of tests will fail because these functions are used in the tests
and system extensivelly. So from a functional standpoint these are not
that important to test (we don't have 100% coverage and there parts of
the system that are, in my opinion, more important).

> Can you please let me know how to verify these stdio commands using LTP?

If you really need tests designed specially for these functions you can
write them yourself and LTP community will be happy to include them.

Or You can look into tests embedded in glibc, there should be basic
testcases for the stdio streams etc.

> Also need support for testing POSIX compliance for few of the LINUX commands.
> POSIX Linux commands: arp, cd, mv, date, echo, file, gdb, kill etc.

Same here, if you need them you can write them yourself. I can give you
hand in integrating them into LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
