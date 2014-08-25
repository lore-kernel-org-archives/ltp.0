Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XLt2K-0003By-Nd
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 12:06:12 +0000
Date: Mon, 25 Aug 2014 14:05:09 +0200
From: chrubis@suse.cz
Message-ID: <20140825120509.GB9330@rei.suse.cz>
References: <77268e159df98c56fa62012617a7c3f3b918f6b7.1408689882.git.jstancek@redhat.com>
	<53F6F9BC.3040504@cn.fujitsu.com> <53F7473C.5010306@oracle.com>
	<CAE1O6mgqn51jh-ib5vXUL8P2kBuJMbG1Wg6WPFp8y2p6Vp74kQ@mail.gmail.com>
	<20140825110702.GA9330@rei.suse.cz>
	<1721706552.12305163.1408967269010.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1721706552.12305163.1408967269010.JavaMail.zimbra@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Li Wang <wangli.ahau@gmail.com>

Hi!
> > If I remember right it's POSIX requirement to return ENOMEM in this case
> > and EINVAL sometimes slips in into kernel arch specific memory
> > management code.
> > 
> > Citing POSIX:
> > 
> > [ENOMEM]
> > 	MAP_FIXED was specified, and the range [addr,addr+len) exceeds that
> > 	allowed for the address space of a process;
> > 
> 
> It also says:
> 
> [EINVAL]
>   The addr argument (if MAP_FIXED was specified) or off is not a multiple
>   of the page size as returned by sysconf(), or is considered invalid by
>   the implementation.
> 
> "addr" used in testcase (HIGH_ADDR) is large enough for implementation to
> reject it without even looking at len and range it would occupy.
> Wouldn't this fit the EINVAL description too?

My view on this is that you have to take the more specific errors into
consideration first otherwise there is no need to define them in the
first place and you can return the most generic errors in all applicable
cases.

But given that interpreting POSIX is like interpreting religious texts
(POSIX it cryptic, POSIX contains logical errors and people tend to
 quarrel about smallest things) I'm open to any reasonable solution we
 can all agree on (so we can move on to more important things to test).

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
