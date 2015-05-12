Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ys6nT-0002gd-Id
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 09:48:19 +0000
Date: Tue, 12 May 2015 11:47:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150512094741.GB3735@rei.suse.de>
References: <1429865144-3141-1-git-send-email-cuibixuan@huawei.com>
	<20150505103538.GA10502@rei.suse.de> <5548AC8B.6080702@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5548AC8B.6080702@huawei.com>
Subject: Re: [LTP] [PATCH v2] ftp/ftp02: case failed when vsftpd is not
 running
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
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com, zhuyanpeng@huawei.com

Hi!
> Before the test, checking if vsftpd is running will be better.
> Otherwise some cases will passed even vsftpd stop and others
> will failed.

Pushed, thanks.

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
