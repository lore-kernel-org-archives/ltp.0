Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XUxQN-0000o7-J2
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 12:36:31 +0000
Date: Fri, 19 Sep 2014 14:35:59 +0200
From: chrubis@suse.cz
Message-ID: <20140919123559.GA29490@rei>
References: <1410244166-5559-1-git-send-email-shuang.qiu@oracle.com>
	<541BE418.6020501@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <541BE418.6020501@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pan/ltp-pan.c: TCONF testcases should not be
 written to failcmdfile
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
>     I introduced this patch '6f6878f4e1406d79cae53564777c5e1245d2a124', sorry. I
> agree with you, patch looks good to me, thanks! Or we can also create a file to
> record test cases that return TCONF.

That sounds like a good idea to me and it shouldn't be hard to get it
implemented.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
