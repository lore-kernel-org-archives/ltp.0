Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YW3fH-0007gJ-Kb
	for ltp-list@lists.sourceforge.net; Thu, 12 Mar 2015 14:00:43 +0000
Date: Thu, 12 Mar 2015 14:59:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150312135950.GA32405@rei>
References: <CAHTgTXUTmdb=JWZmgEyi6SyAWEgiqN-UFF4VnGEpp_DK+n0EaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHTgTXUTmdb=JWZmgEyi6SyAWEgiqN-UFF4VnGEpp_DK+n0EaQ@mail.gmail.com>
Subject: Re: [LTP] TCONF results appearing in FAILCMDFILE logs
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
To: Vinson Lee <vlee@twopensource.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm seeing several testcases with a TCONF result end up in the
> FAILCMDFILE log file. This makes triaging actual failures more
> difficult. Should TCONF results not be placed in FAILCMDFILE?
> 
> As an example, adjtimer02 has a TCONF on recent upstream kernels.

That should have been fixed in:

commit 5f71cf97d5753c5506cdf8287812f28e2fffe4aa
Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date:   Tue Sep 23 15:59:43 2014 +0800

    runltp, pan/ltp-pan.c: record test cases(not fully tested) into file

    Since commit 6f6878f4e1406d79cae53564777c5e1245d2a124, we start to
    differentiate TCONF from TFAIL, but in pan/ltp-pan.c, we still write
    test cases that return TCONF into failcmdfile, this is wrong, fix this.


Since that commit, the TCONF testcases should be written into a separate file.

And that commit should be part of the latest release 20150119.

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
