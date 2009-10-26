Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miaox@cn.fujitsu.com>) id 1N2K0O-0006iA-5k
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 07:28:40 +0000
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2K0F-00026U-RN
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 07:28:40 +0000
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n9Q7SPC2024934 for <ltp-list@lists.sourceforge.net> (envelope-from
	miaox@cn.fujitsu.com); Mon, 26 Oct 2009 16:28:25 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 68CFD45DE60
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 16:28:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3149445DE6E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 16:28:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EB29EE18002
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 16:28:24 +0900 (JST)
Received: from vs00.gw.fujitsu.co.jp (vs00.gw.fujitsu.co.jp [133.161.11.20])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F6AD1DB803B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 16:28:24 +0900 (JST)
Received: from root01.fujitsu.com (root01.fujitsu.com [133.161.11.11])
	by vs00.gw.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id n9Q7SO2e030610
	for <ltp-list@lists.sourceforge.net> (envelope-from
	miaox@cn.fujitsu.com); Mon, 26 Oct 2009 16:28:24 +0900
Message-ID: <4AE54F96.7060502@cn.fujitsu.com>
Date: Mon, 26 Oct 2009 16:28:22 +0900
From: Miao Xie <miaox@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AE54BCA.7060104@cn.fujitsu.com>
In-Reply-To: <4AE54BCA.7060104@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
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
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

Hi, Mr.Subrata

The patch that you made to fix the problem of ffsb was not merged into
this patch. So if you want to run this testcases, you must applied your
patch before compiling the testcases.

Regards.
Miao

on 2009-10-26 16:12, Miao Xie wrote:
> This is the patch of testcases for the ext4 new features test.
> It contains multi-block alloc/delayed alloc test, inode version test,
> journal checksumming test, nanosec timestamps test, online defrag test,
> persist prealloc test, subdirectory limit test and uninit groups test
> of ext4.
> 
> In this test suite, there is two FAIL in the subdirectory limit test.
> It is because we cann't create more than 32000 subdirectory when block
> size is small, such as 1024, and the name of every subdirectory is very
> long, such as every name is 255 bytes. I think it is the bug of the ext4.
> 
> Note: Your MUST run configure in the directory
>     testcases/kernel/fs/ext4-new-features
>       to config the tool of ffsb, and specify a partition to be used for 
> test
>       before compiling the tool. The data on the specified partition 
> would be
>       DESTROYED.
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
