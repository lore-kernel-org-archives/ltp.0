Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QcIng-0002jR-V0
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 15:05:04 +0000
Date: Thu, 30 Jun 2011 17:05:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110630150527.GB20247@saboteur.suse.cz>
References: <4E0BD224.6060903@cn.fujitsu.com> <4E0C349E.1090104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E0C349E.1090104@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pthread_cond_init: Fix a problem making the case
 sometimes passed and sometimes failed.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm sorry. Here, I made a mistake. 
> sched_yield() is a system call, which calls schedule() in kernel. It yields 
> the current CPU to other tasks.
> So why did it sometimes pass, but sometimes fail? But when using sleep(1) 
> instead of sched_yield(), it always passed? 
> Does it have anything to do with multi cpus?

I've just commited patch to remove the test as after careful review, it
turned out that there is no reasonable way how to test that two
condition variables are initalized exactly same way. (same goes for 1-3
and 2-2).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
