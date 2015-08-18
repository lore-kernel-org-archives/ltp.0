Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZRgJd-0007TP-Qs
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:48:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRgJc-00024q-PK
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2015 12:48:33 +0000
Date: Tue, 18 Aug 2015 14:48:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150818124759.GB22482@rei.suse.de>
References: <CACwVHNqEdn8kuQ-pdD35=O64criD+d3R1S2jUnMgVQt-XxrTyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACwVHNqEdn8kuQ-pdD35=O64criD+d3R1S2jUnMgVQt-XxrTyg@mail.gmail.com>
Subject: Re: [LTP] Test Patch for diotest6
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
To: Sandy Sun <a22017@motorola.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I found pointer issue in diotest6. It wrongly use iov1/iov2 as pointer to
> "buf" when read/write
> from fd_r/w.  It should be iov1[j].iov_base.

Looks like you are right. But since none of the syscalls the test
uses works with struct iovec can't we get rid of them?

As far as I can see the testcase can work with just two buffers, one
gets initialized in each iteration and one is read back and compared
with the initialized one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
