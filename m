Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z9aHI-0000Rz-AU
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2015 14:43:20 +0000
Date: Mon, 29 Jun 2015 16:41:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150629144159.GB24350@rei.suse.de>
References: <1434610097-15874-1-git-send-email-liwang@redhat.com>
	<1750983670.20645133.1435571726272.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1750983670.20645133.1435571726272.JavaMail.zimbra@redhat.com>
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
> Ping~
> Any comments?

Sorry for the delay. Looks good, but the race codintion with the
semaphores is still possible, although unlikely.

Because the semaphore is posted before the second thread is locked on
the futex, there is slight possibility that the futex_wake() (from the
main thread) is called before the second thread sleeps in the futex
which will cause the testcase to fail.

I will isolate the function to assert that threads are sleeping in
kernel from the futex testcase and change this test to make use of it
and commit it.

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
