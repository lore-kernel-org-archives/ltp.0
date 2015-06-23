Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z7LCl-0003E7-BD
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2015 10:13:23 +0000
Date: Tue, 23 Jun 2015 12:12:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150623101209.GA17751@rei.suse.de>
References: <CAHNg1SqHWzfKM3f3b-OsSp7_WRdWPfzDbvzvgYBt6+0_-bgygA@mail.gmail.com>
	<1434982460893.630809266@boxbe>
	<CAHNg1SrBPwESiU4KtbjxTMUAqy4iMpc5hVRvuwjcPc6jpD_iqA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHNg1SrBPwESiU4KtbjxTMUAqy4iMpc5hVRvuwjcPc6jpD_iqA@mail.gmail.com>
Subject: Re: [LTP] Option to skip some tests from install
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
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have added directories to FILTER_OUT_DIRS variable in testcases/Makefile
> but it only works when i ran make from testcases directory. If i run make
> from top-level Makefile (outside of testcases) then it builds all.
> So how to tweak top-level Makefile?

I've tried that just now and it works fine. Both for make all and make
install.

It breaks only if you disable all subdirectories in testcases/ but if
you do that there is no point in compiling and installing LTP anyway.

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
