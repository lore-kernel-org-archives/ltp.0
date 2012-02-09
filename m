Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvVwl-0003db-BQ
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 15:30:07 +0000
Date: Thu, 9 Feb 2012 16:44:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209154402.GD29442@saboteur.suse.cz>
References: <CAGH67wTKz+VPzN_-+7uKfeBguhuKZK_mj-m8oy2kY6pyKNihzw@mail.gmail.com>
	<1A42CE6F5F474C41B63392A5F80372B212E050913C@shsmsx501.ccr.corp.intel.com>
	<20120125183628.GD8067@saboteur.suse.cz>
	<D908B1B9E708C047A32444772B58AE880414C8@SHSMSX101.ccr.corp.intel.com>
	<CAGH67wSw9nGvHOg_Ywp5p0CsjJgycpF1NNfXiG38pFyLyNSQTw@mail.gmail.com>
	<D908B1B9E708C047A32444772B58AE88041512@SHSMSX101.ccr.corp.intel.com>
	<20120201152611.GA29203@saboteur.suse.cz>
	<D908B1B9E708C047A32444772B58AE88043030@SHSMSX101.ccr.corp.intel.com>
	<20120209130945.GA27782@saboteur.suse.cz>
	<D908B1B9E708C047A32444772B58AE88044FE2@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D908B1B9E708C047A32444772B58AE88044FE2@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patch] Power Management: add notification
 once 'sched_debug' not in boot cmdline
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
To: "Xu, Anhua" <anhua.xu@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>     Power Management: fix configuration check for sched_domain.py
>     
>     Add checking for "sched_debug" in kernel cmdline parameter.
>     Without this option, power policy change via sched_mc/smt_power_savings
>     will not cause any output from dmesg that is needed for sched_domain.py
> 
>     Signed-off-by: Anhua Xu <anhua.xu@intel.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
