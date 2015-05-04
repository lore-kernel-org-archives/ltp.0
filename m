Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YpGWC-0002T6-32
	for ltp-list@lists.sourceforge.net; Mon, 04 May 2015 13:34:44 +0000
Date: Mon, 4 May 2015 15:34:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150504133335.GA11354@rei.suse.de>
References: <1428375071-99253-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1428375071-99253-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATH] gzip/gzip_tests.sh: remove the tmp dir of test02
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
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com, huawei.com.zhuyanpeng@huawei.com

Hi!
Pushed, thanks.

Side note, the test should be fixed to use tst_tmpdir() and tst_resm()
to return correct exit status at the end. As it is if both tests fail it
will return 2 (TBROK) instead of 1 (TFAIL).

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
