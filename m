Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ve65k-0007Oa-1k
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 16:36:28 +0000
Date: Wed, 6 Nov 2013 13:53:17 +0100
From: chrubis@suse.cz
Message-ID: <20131106124955.GC28897@rei>
References: <1383710112.1600.3.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383710112.1600.3.camel@localhost>
Subject: Re: [LTP] [PATCH] clock_getres/clock_getres01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Fix the messy testcase of clock_getres01.c
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

That's better that the previous state but there are still some things to
fix:

1. The options are unused (opt_debug is only set and never used)
   we can strip all the custom option parsing and remove the usage()
   function and add LTP standard:

        char *msg;

        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
                tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);


2. Does the test really need to create temporary directory?
   It does not seem to create any files, so we can remove the
   tst_tmpdir() and tst_rmdir() in cleanup() and setup().

Also I would sanitize the comments in test header so that the ending */ does
not overflow 80 chars and end up on the same column. (May need to move the word Foundation to the previous line)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
