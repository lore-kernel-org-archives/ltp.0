Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4XUQ-0007vO-3I
	for ltp-list@lists.sourceforge.net; Wed, 31 Jul 2013 14:34:58 +0000
Date: Wed, 31 Jul 2013 16:34:49 +0200
From: chrubis@suse.cz
Message-ID: <20130731143448.GB2698@rei.scz.novell.com>
References: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] testcases/network/sctp: update sctp test to
 upstream version 1.0.15
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, Daniel Borkmann <dborkman@redhat.com>, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

Hi!
> SCTP test in ltp is based on lksctp. But the last patch for sctp in ltp is
> 2006. It has changed a lot and fixed many bugs. Update sctp test to upstream
> version 1.0.15 now.

I'm a bit confused here. Is the SCTP testsuite developed elsewhere? In
that case it probably shouldn't be part of the LTP repo, perhaps a git
submodule as mce-test is.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
