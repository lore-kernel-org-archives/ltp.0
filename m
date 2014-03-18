Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPvWf-0000JD-15
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 15:01:57 +0000
Date: Tue, 18 Mar 2014 16:01:35 +0100
From: chrubis@suse.cz
Message-ID: <20140318150135.GA13153@rei.Home>
References: <1392899852-18058-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392899852-18058-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] testscripts/test_robind.sh: cleanup and make
 some fixes
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
> Remove useless comments and abandon the operation which creates
> a 500MB image-file. If user wants to run these tests, a big block
> device should be specified by running runltp with -z option.
> 
> And we split tests in testscripts/fs_ro_tests into separate testcases,
> keep one entry per test in runtest/fs_readonly
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/fs_readonly        |  56 +++++++-
>  testscripts/fs_ro_tests    |   1 -
>  testscripts/test_robind.sh | 310 ++++++++++++++++++---------------------------
>  3 files changed, 176 insertions(+), 191 deletions(-)

Is the fs_ro_tests file needed now? Doing git grep fs_ro_tests showed
only one reference in testscripts/Makefile. Can we remove the file?

Othewise it looks OK.

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
