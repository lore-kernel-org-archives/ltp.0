Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z9bv2-0005pN-AZ
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2015 16:28:28 +0000
Date: Mon, 29 Jun 2015 18:27:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150629162708.GA30308@rei.suse.de>
References: <1434610097-15874-1-git-send-email-liwang@redhat.com>
	<1750983670.20645133.1435571726272.JavaMail.zimbra@redhat.com>
	<20150629144159.GB24350@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150629144159.GB24350@rei.suse.de>
Subject: Re: [LTP] [PATCH v2] futex: regression test for take hugepages
	into	account when generating futex_key
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
And I've pushed the test with following changes.

* Use the wait_for_threads() function instead of semaphores

* Wake the futex on first thread before the first thread is joined
  (otherwise the test waits for 30 seconds doing nothing before it
   reports success)

* Do not fail the test if mmaping hugepage fails with ENOMEM
  this may happen on machines that run for days without reboot
  and memory gets fragmented too much
  (this is no TCONF)

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
