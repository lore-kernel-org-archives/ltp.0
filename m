Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NerMo-0000al-En
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 14:47:06 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NerMn-0003fo-Hg
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 14:47:06 +0000
Received: by pxi33 with SMTP id 33so243260pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Feb 2010 06:46:59 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4B712BBF.3060704@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2010 06:46:27 -0800
Message-Id: <E374CB37-8AF0-4C79-8B2A-9E51F9861275@gmail.com>
References: <4B712BBF.3060704@linux.vnet.ibm.com>
Subject: Re: [LTP] container_test.sh failure
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Feb 9, 2010, at 1:32 AM, Rishikesh wrote:

> Hi Garret,
> 
> With today's cvs getting following error while running the container testcases.
> 
> ...
> /opt/ltp/testcases/bin/container_test.sh: line 52: check_mqns_enabled: command not found
> Posix message queues or ipc namespaces not enabled in kernel.
> Not running mqns tests.
> /opt/ltp/testcases/bin/container_test.sh: line 61: check_netns_enabled: command not found
> Network namespaces not enabled in kernel.  Not running netns tests.
> <<<execution_status>>>
> initiation_status="ok"
> duration=10 termination_type=exited termination_id=0 corefile=no
> cutime=7 cstime=22
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100131
> 
>       ###############################################################"
> 
>            Done executing testcases."
>            LTP Version:  LTP-20100131
>       ###############################################################"
> 
> x440:/opt/ltp #
> 
> Do you think we need to just do the fix as you did for pidns ? I feel check_*_enabled.c does more a lot than just checking kernel version. So keeping that file will be a good idea. Please let me know your thought.

	The issue should be resolved now (check_netns_enabled wasn't being compiled and check_mqns_enabled was no longer in the repo).
Thanks!
-Garrett
------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
