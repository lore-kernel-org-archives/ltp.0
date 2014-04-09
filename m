Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXvwS-0000mo-HD
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 17:05:40 +0000
Date: Wed, 9 Apr 2014 19:04:56 +0200
From: chrubis@suse.cz
Message-ID: <20140409170455.GA31198@rei>
References: <1395044011-31911-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1395044011-31911-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140331150821.GB9824@rei.suse.cz>
	<533A864A.4040109@cn.fujitsu.com>
	<20140401115800.GB12474@rei.suse.cz>
	<5344EA26.8010209@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5344EA26.8010209@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/3] performance_counters: make
 performance_counters run default
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
Hi!
> The Number Hardware Counters is 7, But according to above ./perf_event_open02 in RHEL7.0beta,  the output is 5.
> Whether two slots in PMU has been used, or the output of papi_avail is not correct :-) .

I would guess that these are used by kernel or system for something else.

> I tried to figure out how papi_avail gets the number of hardware counters, It seems that it just predefines some const values for
> specific cpus, but I am not very sure, I do not have much time to read the papi_library source code.
> 
> And I afraid that this library does not support enough kinds of cpus. I also met some compilation errors in Fedora19 about this library.
> 
> So whether we can use the first method I mentioned. I think it is more reasonable, at least according to perf_even_open()'s manpage
> and the intent of perf_event_open02 case.

Your method is better, because the testcase only cares if perf events
are multiplexed or not which is implied by different time_enabled and
time_running fields.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
