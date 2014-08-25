Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XLs86-0001Kh-FC
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 11:08:06 +0000
Date: Mon, 25 Aug 2014 13:07:02 +0200
From: chrubis@suse.cz
Message-ID: <20140825110702.GA9330@rei.suse.cz>
References: <77268e159df98c56fa62012617a7c3f3b918f6b7.1408689882.git.jstancek@redhat.com>
	<53F6F9BC.3040504@cn.fujitsu.com> <53F7473C.5010306@oracle.com>
	<CAE1O6mgqn51jh-ib5vXUL8P2kBuJMbG1Wg6WPFp8y2p6Vp74kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1O6mgqn51jh-ib5vXUL8P2kBuJMbG1Wg6WPFp8y2p6Vp74kQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] mmap15: don't fail if mmap returns EINVAL
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
To: Li Wang <wangli.ahau@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
If I remember right it's POSIX requirement to return ENOMEM in this case
and EINVAL sometimes slips in into kernel arch specific memory
management code.

Citing POSIX:

[ENOMEM]
	MAP_FIXED was specified, and the range [addr,addr+len) exceeds that
	allowed for the address space of a process;

So if the testcase fails, it's a bug albeit a minor one.

What we should do depends on how strict we are. I would personaly change
the testcase to have specific failure message for EINVAL, ideally
pointing to this discussion on mailing list archive. But if all the rest
of you consider this minor enough to be ignored we can proceed with the
original patch as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
