Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VbwNZ-00020I-SQ
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 17:49:57 +0000
Date: Thu, 31 Oct 2013 18:49:37 +0100
From: chrubis@suse.cz
Message-ID: <20131031174936.GF20620@rei.Home>
References: <52723AC1.6090807@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52723AC1.6090807@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] realtime: add realtime tests to the default
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
> 
> modify run.sh to check whether the kernel support RT PREEMPT
> 
> modify configure.ac to make the realtime tests default

I do not like the realtime runtest file. The reason is that all the
tests are executed by a single script, which makes it hard (if not
impossible) to figure out what exactly has failed. We are working hard
on getting rid of such runtest files. The runtest file should have only
one entry per test.

Also adding it into the default scenario is IMHO not good choice, most
of the systems out there are not RT systems.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
