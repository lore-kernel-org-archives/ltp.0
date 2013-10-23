Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYzXM-0002iZ-FS
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 14:35:52 +0000
Date: Wed, 23 Oct 2013 16:35:36 +0200
From: chrubis@suse.cz
Message-ID: <20131023143536.GA25390@rei.Home>
References: <52662BFB.9050105@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52662BFB.9050105@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] access(2): add ELOOP, ENOTDIR,
 EROFS error number test
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
To: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> access/access05.c: add ELOOP, ENOTDIR error number test
> 
> new access/access06.c: add EROFS error number test

Sorry for not being clear enough the first time. When I said adding the
testcases to access05 I meant all of them including the EROFS (contrary
to my first thoughts). (I can fix this myself if you want). Otherwise
the code is fine.

Also looking at increased demand for EROFS tests, I'm trying to figure
out more general LTP lib API for creating and mounting the readonly
image, so that the code pattern is not repeated all over. But for now
let's go with the manual approach and I will convert all usages once the
new API is in place.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
