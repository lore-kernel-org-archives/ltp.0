Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UVJcX-000516-Aa
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 10:41:45 +0000
Date: Thu, 25 Apr 2013 12:42:38 +0200
From: chrubis@suse.cz
Message-ID: <20130425104238.GA28986@rei>
References: <605746806.1323310.1360671766487.JavaMail.root@redhat.com>
	<51218CB1.8040709@cn.fujitsu.com> <20130227143845.GA2178@rei>
	<20130227171118.GB30351@rei> <20130423134844.GE28044@rei>
	<1822042882.3039242.1366879006975.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1822042882.3039242.1366879006975.JavaMail.root@redhat.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I think I didn't see these ones failing before:
> Failed testcases:
> stress/mqueues/mqueues_multi_send_rev_1
> stress/mqueues/mqueues_multi_send_rev_2
> 
> from logfile.stress-test:
> stress/mqueues/mqueues_multi_send_rev_1: execution: FAILED: Output:
> Usage: ./mqueues_multi_send_rev_1.run-test number_of_threads
> stress/mqueues/mqueues_multi_send_rev_2: execution: FAILED: Output:
> Usage: ./mqueues_multi_send_rev_2.run-test number_of_threads
> 
> Tweaking bin/run-tests.sh or just renaming those ".args" files should do the trick.
> 
> # find . | grep .args
> ./stress/mqueues/multi_send_rev_1.args
> ./stress/mqueues/multi_send_rev_2.args

Thanks I've missed this.

Given that these are only two occurencies I've commited
a patch that just renames the arg files.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
