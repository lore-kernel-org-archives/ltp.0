Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rfxsm-0004rq-NE
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 18:05:44 +0000
Date: Wed, 28 Dec 2011 19:16:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111228181600.GA28606@saboteur.suse.cz>
References: <4EFAF5BB.2030407@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EFAF5BB.2030407@windriver.com>
Subject: Re: [LTP] Posix test case mmap/31-1 fails on Linux/eglibc
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I run mmap/31-1 failed with ENOMEM on linux, with error message:
> off: fffffffffffff000, len: fffffffffffff000
> Test FAIL: expect EOVERFLOW but get other error: Cannot allocate memory
> 
> But compare to mmap/24-2, it mmap() the same length but pass. Its output:
> available memory: 18446744073709551615
> addr: 7f78c54fa000, len: ffffffffffffffff
> addr: 7f78c54fa000, len: fffffffffffff000
> Test Pass: mmap/24-2.c Get ENOMEM: Cannot allocate memory

At least the mmap/31-1, mmap/28-1, mmap/27-1, mmap/24-2, mmap/11-4 and
mmap/11-5 are known to fail sometimes and most likely are coded
incorrecly.

> So I suppose that mmap/31-1 may need update, but I don't know how to 
> make mmap() overflow as expect.
> Any suggestion is appreciated.

I would start with careful reading of the mmap() manpages/docs, as most
likely some of the assumptions that the testcase makes is incorrect.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
