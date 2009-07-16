Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <macli@brc.ubc.ca>) id 1MRaFm-0006f8-SA
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 23:20:42 +0000
Received: from sparc.brc.ubc.ca ([137.82.2.12])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRaFd-0001Kh-2U
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2009 23:20:37 +0000
Received: from mail (unknown [137.82.2.7])
	by sparc.brc.ubc.ca (Postfix) with ESMTP id D1974523B36B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Jul 2009 16:25:51 -0700 (PDT)
Date: Thu, 16 Jul 2009 16:38:48 -0700 (PDT)
From: "Li, Ming Chun" <macli@brc.ubc.ca>
Message-ID: <alpine.DEB.1.00.0907161630140.16435@mail.selltech.ca>
MIME-Version: 1.0
Subject: [LTP] LTP stress test bring the system completely down
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
To: ltp-list@lists.sourceforge.net


Hi,

I run ./runltplite.sh -i 1 -m 1 -p -q  -l /home/vincent/ltp.log -d 
/home/vincent/ltp_tmp command would completely freeze Ubuntu 9.04 with 
2.6.31-rc3 kernel built, Has anyone of you experience the same thing?

I had to Alt + SysRq + b to reboot the system and I can see that many test 
passed in the ltp.log  file. This machine is HP Proliant ML 110 with 1G 
memory. 

Regards,

Vincent Li
Biomedical Research Center
University of British Columbia

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
