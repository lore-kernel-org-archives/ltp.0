Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkBZJ-0005j9-7q
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 12:12:25 +0000
Date: Tue, 13 May 2014 14:11:23 +0200
From: chrubis@suse.cz
Message-ID: <20140513121123.GD12144@rei>
References: <53720837.8010805@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53720837.8010805@cn.fujitsu.com>
Subject: Re: [LTP] How to get detailed system information between running
	tests
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi,
> Recently I met some fails in RHEL7.0Beta by running "./runltp", the fails are below:
>    ------------------------------------------
>            hugemmap01 FAIL 2
>            hugemmap03 FAIL 2
>            hugemmap04 FAIL 2
>  ------------------------------------------
> After some investigation, I found that it is "echo 128 > /proc/sys/vm/nr_hugepages" causing
> these fails. By catting /proc/buddyinfo  or catting /proc/pagetypeinfo, I found that the system
> has too many memory fragments and was not able to allocate 128 hugepages. So I also want
> to know which test cases results in these too many memory fragments.
> 
> It seems that LTP does not provide a method to get the system's status information between these
> tests. I think we may add patches to support providing a shell script to ltp-pan, which will be called before
> and after every test case, to record some system status information. In this shell script, you can collect
> system information you has interests in, then save these information to files. Then we can analysis these
> files to know which case causing the big system status changes.
> 
> Anybody has some better ideas, thanks.

That sounds more like a job for MMTests[1]. The upside of MMTests is
that all the scripts for collection system information are allready
written along with exporters to html and comparsion tools. The downside
is that there is not much of documentation and LTP support is untested.

[1] https://github.com/gormanm/mmtests

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
