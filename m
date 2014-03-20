Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WQhyi-00013j-Jj
	for ltp-list@lists.sourceforge.net; Thu, 20 Mar 2014 18:46:08 +0000
Date: Thu, 20 Mar 2014 19:45:46 +0100
From: chrubis@suse.cz
Message-ID: <20140320184545.GB5013@rei.Home>
References: <1393914721-5288-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1393914721-5288-4-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393914721-5288-4-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/4] mknodat/mknodat02.c: add ELOOP and EROFS
 error value test
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
> And create mknodat.h to encapsulate mknodat syscall.
>
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Pushed, thanks.

PS: I've fixed the mknodat01 testcase, which was wrong on several
    things. Most problematic was return 0; in main() instead of
    tst_exit(), so the test returned success no matter what happened.

    And it looks like most of the *at testcases are similarily wrong :(
    At least I've allready fixed the mkdirat01 and mknodat01...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
