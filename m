Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z72Ou-0003Bv-EX
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:08:40 +0000
Date: Mon, 22 Jun 2015 16:07:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150622140726.GB7982@rei.suse.de>
References: <CAHNg1SqHWzfKM3f3b-OsSp7_WRdWPfzDbvzvgYBt6+0_-bgygA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHNg1SqHWzfKM3f3b-OsSp7_WRdWPfzDbvzvgYBt6+0_-bgygA@mail.gmail.com>
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
> Can we configure ltp to skip some tests while installing on target ?

This is not supported. You can hack makefiles manually to omit some
subdirectories if you really need that (have a look for FILTER_OUT_DIRS
in testcases/Makefil).

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
