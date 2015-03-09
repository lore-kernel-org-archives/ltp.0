Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YUzN4-0007Cl-FS
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 15:13:30 +0000
Date: Mon, 9 Mar 2015 16:12:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150309151242.GA28617@rei.suse.de>
References: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1425889922-13650-7-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425889922-13650-7-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 7/7] ipv6_lib: add it into default
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> * Add ipv6_lib tests to scenario_groups/default.
> 
> * Currently I'm not very clear about some test
>   cases eg. asapi_04.c, so disable them. Later
>   I will add it subsequently.

I've pushed the cleanups, thanks.

But before we enable these testcases runcc.c must be at least fixed to
report TCONF instead of TBROK if no C compiler is present (the 127 from
system()). I'm also thinking if we can avoid creating the temp file if
we feed the compiler input to the cc stdin with popen() and 'cc -x c -'.

We may also enable all of them once the rest of the tests if
fixed/reviewed so that we don't have to shuffle the # back and forth.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
