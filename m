Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6zhN-0000EC-07
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 10:11:01 +0000
Date: Tue, 15 Jul 2014 12:10:31 +0200
From: chrubis@suse.cz
Message-ID: <20140715101030.GB27102@rei>
References: <20140704031641.GA20446@localhost.localdomain>
	<53BB90C6.9020101@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BB90C6.9020101@cn.fujitsu.com>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at
	2G
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> > Please review this patch. Thanks.
> > 
> > There is a bug on 64bit sendfile() with large file, please see
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
> > for details.
> 
> I'd like to ask an irrelevant question about that where can we get such bug report or similar issues
> about syscalls from a stable place(url), or how did you found this issue, thanks.

This is IMHO most problematic part of producing LTP testcases. There is
no single place to pickup kernel regression/bug reports and produce
testcases for them. This is partly caused by the nature of how the
community works and partly because nobody cared about this (this happens
to change slowly now).

> Give that currently there are 1039 test cases about syscalls in LTP(cat runtest/syscalls | grep -v "^#" | sed -e '/^$/d' | wc -l),
> we can tell that syscalls is a very big test suite in LTP, so I'd like to add all similar regression test about
> syscalls to LTP, which will expand ltp's test coverage, thanks.

And we don't have 100% coverage either, there are numerous
syscalls/ioctls/... that are not even documented properly.

But at least new syscalls along with documentation and example source
code are starting to appear on linux-api mailing list.

See also:

https://www.kernel.org/doc/man-pages/maintaining.html

which lists various sources where to get information about kernel/libc
interfaces.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
