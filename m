Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yn4o0-00025L-L5
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:40:04 +0000
Date: Tue, 28 Apr 2015 14:39:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150428123935.GA21433@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
	<20150401143314.GA23093@rei> <551CB5CD.5030903@huawei.com>
	<20150402083344.GA27984@rei> <552D1041.9010103@huawei.com>
	<20150422140404.GA32660@rei> <55399C3A.70800@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55399C3A.70800@huawei.com>
Subject: Re: [LTP] [PATCH v5 1/2] syscalls/utimensat01: Use test.sh library
 for test case
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi!
> Using test.sh in the case:
> * Change the tst_resm() followed by exit to tst_brkm and remove the exit
> * Changing the check_result() to call tst_resm TPASS and the test_failed() which is
>   called by check_result() to call tst_resm TFAIL
> * Delete the exit -1 at the end of the test and change exit to tst_exit at the
>   very end of the test

Pushed, thanks.

BTW: The test still can be cleaned up to use tst_tmpdir/tst_rmdir
     instead of creating it manually, it should stop working with
     global path to subtest binaries (the path to these is in $PATH),
     etc.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
