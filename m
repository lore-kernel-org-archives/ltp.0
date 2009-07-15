Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <macli@brc.ubc.ca>) id 1MRCea-0005V6-HF
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 22:08:44 +0000
Received: from sparc.brc.ubc.ca ([137.82.2.12])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRCeZ-0007SD-GQ
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 22:08:44 +0000
Date: Wed, 15 Jul 2009 15:26:52 -0700 (PDT)
From: "Li, Ming Chun" <macli@brc.ubc.ca>
In-Reply-To: <8368651DACC1964480F951191B94A078D01C80@svexch01.mvista.com>
Message-ID: <alpine.DEB.1.00.0907151516430.3715@mail.selltech.ca>
References: <alpine.DEB.1.00.0907151048120.3370@mail.selltech.ca>
	<8368651DACC1964480F951191B94A078D01C80@svexch01.mvista.com>
MIME-Version: 1.0
Subject: Re: [LTP] LTP hung on 2.6.31-rc3 kernel and buffer overflow detected
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 15 Jul 2009, Henry Yei wrote:

> Ming,
> 
> The first thing to do is figure out what testcase is causing it and run that test by itself, then debug from there.
> This is easy to find out by looking at your output and result files and see which was the last reported test. 
> 
> Note: I had no such problem on Ubuntu 9.04, but with the 2.6.28-13 kernel.

I looked at the fail report by 

#tail -5 output/LTP_RUN_ON-2009_Jul_14-14h_15m_46s.failed

ftest03 ftest03
ftest07 ftest07
fs_di fs_di -d /tmp/
quota_remount_test01 quota_remount_test01.sh
Containers container_test.sh

Is container_test.sh test the fault one? How to run that single test 
properly? I ran ./testcases/bin/container_test.sh at command line simply 
gave me error like:

./testcases/bin/container_test.sh: 13: check_for_unshare: not found
./testcases/bin/container_test.sh: 18: check_utsns_enabled: not found
Uts namespaces not enabled in kernel.  Not running utsns tests.
./testcases/bin/container_test.sh: 41: check_ipcns_enabled: not found
ipc namespaces not enabled in kernel.  Not running ipcns tests.
./testcases/bin/container_test.sh: 49: check_pidns_enabled: not found
Process id namespaces not enabled in kernel.  Not running pidns tests.
./testcases/bin/container_test.sh: 57: check_mqns_enabled: not found
Posix message queues or ipc namespaces not enabled in kernel.
Not running mqns tests.
./testcases/bin/container_test.sh: 66: check_netns_enabled: not found
Network namespaces not enabled in kernel.  Not running netns tests.


Regards,

Vincent

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
