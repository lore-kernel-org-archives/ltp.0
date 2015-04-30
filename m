Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YnjFy-0002I5-IY
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 07:51:38 +0000
Date: Thu, 30 Apr 2015 09:51:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430075108.GC479@rei.suse.de>
References: <20150422125819.GB32110@rei>
	<1429784431-14017-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<20150428141018.GA22688@rei>
	<1430270054.7745.11.camel@G08JYZSD130126.localdomain>
	<55417DFD.1040207@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55417DFD.1040207@huawei.com>
Subject: Re: [LTP] [PATCH v3 1/2] testcases/lib/test.sh: Added ROD_SILENT()
 and ROD()
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I update the repository and got the documentation. It looks good, and
> > thank you very much.
> > 
> Maybe you can write the descriptive file such as tar/00_Descriptions.txt,
> but I don't know if it's necessary.

My opinion is that the less documentation is needed the better. Which
means that one should write clean code and if possible avoid cryptic
constructs and comment only parts that needs to be.

In LTP we usually add a short description of the testcase in a comment
at the start of the test source. Looking at the tar testcase, I would be
better to move the description to the comment at the start of the
tar_tests.sh. Having it in separate file is not good idea.

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
