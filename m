Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yn4nt-0005BB-F8
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:39:57 +0000
Date: Tue, 28 Apr 2015 14:39:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150428123928.GA22189@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
	<20150401143314.GA23093@rei> <551CB5CD.5030903@huawei.com>
	<20150402083344.GA27984@rei> <552D112E.4040104@huawei.com>
	<20150422140630.GB32660@rei> <55399C8E.40608@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55399C8E.40608@huawei.com>
Subject: Re: [LTP] [PATCH v5 2/2] syscalls/utimensat01: "chattr" command
	error
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
> +# Make sure chattr command is supported
> +touch $TEST_DIR/tmp_file
> +chattr +a $TEST_DIR/tmp_file
> +if [ $? -ne 0 ] ; then

You should remove the TEST_DIR here, otherwise it looks fine.

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
