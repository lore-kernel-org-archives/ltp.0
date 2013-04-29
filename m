Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UWloa-0005is-TQ
	for ltp-list@lists.sourceforge.net; Mon, 29 Apr 2013 11:00:12 +0000
Date: Mon, 29 Apr 2013 13:01:10 +0200
From: chrubis@suse.cz
Message-ID: <20130429110110.GB5569@rei>
References: <20130416065202.9634.qmail@f5mail-224-131.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130416065202.9634.qmail@f5mail-224-131.rediffmail.com>
Subject: Re: [LTP] Pre requisites needed to run LTP on Embedded devices
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
To: devaraja b v <sunildev_63@rediffmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Please treat this request on high importance and do the needful.I need
> to run LTP on one of my Embedded device,which is having 2GB of free
> RAM.While running some of the LTP test cases in syscalls group, system
> will go for Out of memory and the device will be rebooted. So I would
> like to know what is the minimum amount of free memory required to run
> LTP on the device?I heard that there is a separate configuration or
> settings needs to be done for embedded systems.Could you please point
> me to that link/page?It is good if you can put the Pre-requisite
> details under
> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3&nbsp;Before
> you Begin section. No where I got such information.Could you please
> add this detail and let me know?Thanks much in advance.

Having 2GB of memory should be more than enough, I run the testsuite
regulary on x86 machines with less than that regulary.

Do you have a swap partition set up?

Do you know which testcase is causing this?

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
