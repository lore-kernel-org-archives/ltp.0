Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YzQVz-0003bN-Js
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:16:31 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YzQVt-0004PE-Jf
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:16:31 +0000
Date: Mon, 1 Jun 2015 10:16:17 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <480835441.8555246.1433168177005.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAAJEG239+Hb2NAzaLh_9Q15m9mCj=wSBxHC5D3VhYy=1Ery31g@mail.gmail.com>
References: <CAAJEG239+Hb2NAzaLh_9Q15m9mCj=wSBxHC5D3VhYy=1Ery31g@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] Getting segmentation fault
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
To: Jatinder Kumar <rinkusaini32@gmail.com>
Cc: ltp-list@lists.sourceforge.net




----- Original Message -----
> From: "Jatinder Kumar" <rinkusaini32@gmail.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 1 June, 2015 3:07:53 PM
> Subject: [LTP] Getting segmentation fault
> 
> Hi All,
> I am new to this mailing list.
> 
> I am running ltp-test version is 20140422. ltp-test. The result is fine. But
> when I run the open_posix test. I am getting Segmentation fault in
> pthread_cond_signal_4-2.run-test.
> 
> Test environment.
> Target Board: Panda version a4
> Kernel version 3.10.67.
> gcc version 4.8.2.
> 
> The same test case is passed for other target board on same kernel. Can you
> please help me or give me some hint in this regards.

Some testcases are known to crash, but I haven't seen this one crashing before.
Can you run it in gdb and attach backtrace from all threads when it crashes?

Regards,
Jan

> 
> am I missing any target specific kernel configuration.
> 
> 
> Thanks & Regards,
> Jatinder Kumar
> E-mail : rinkusaini32@gmail.com
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
