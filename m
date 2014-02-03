Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WAKk1-0005Df-2z
	for ltp-list@lists.sourceforge.net; Mon, 03 Feb 2014 14:43:17 +0000
Date: Mon, 3 Feb 2014 15:42:44 +0100
From: chrubis@suse.cz
Message-ID: <20140203144244.GC3996@rei>
References: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1390298574-2966-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140203143643.GB3996@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140203143643.GB3996@rei>
Subject: Re: [LTP] [PATCH v2 2/3] fcntl/fcntl30.c: add F_SETPIPE_SZ,
 F_GETPIPE_SZ test for fcntl(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > +		/* restore the original pipe size*/
> > +		TEST(fcntl(test_fd, F_SETPIPE_SZ, orig_pipe_size));
> > +		if (TEST_RETURN < 0) {
> > +			tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
> > +				 "restore orignal pipe size failed");
> 
>                 There is a small logic error here. You say that the test
> 		has exactly one testcase but if we get here the test
> 		will print passed then failed which would indicate that
> 		there are two testcases.
> 
> 		What I would do instead is to set the size to new pipe
> 		size on even iteration s and original pipe size on odd
> 		iterations.
> 

But then we would have to abort on first failure, because in case the
fcntl() failed to change the size but exited with succes the output from
the test would be failed, passed, failed, passed...

Other options are changing the tst_brkm to TBROK in this case, or
opening new pipe for each iteration.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
