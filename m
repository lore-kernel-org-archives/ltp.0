Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ashish.g@teldevice.co.jp>) id 1NWpAy-0000Rc-63
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 10:49:40 +0000
Received: from mail-gw.teldevice.co.jp ([124.215.243.245] helo=teldevice.co.jp)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NWpAw-0002aI-4E
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 10:49:39 +0000
Received: from victory.ykc.teldevice.co.jp (victory.ykc.teldevice.co.jp
	[127.0.0.1])
	by victory.ykc.teldevice.co.jp (Postfix) with ESMTP id 747C01988001
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 19:49:20 +0900 (JST)
Received: from victory.ykc.teldevice.co.jp (victory.ykc.teldevice.co.jp
	[127.0.0.1]) by postfix.imss70 (Postfix) with ESMTP id 4EF711988002
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 19:49:20 +0900 (JST)
Received: from [172.29.112.161] (unknown [172.29.112.161])
	by victory.ykc.teldevice.co.jp (Postfix) with ESMTP id 3FF0E1988001
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 19:49:20 +0900 (JST)
Message-ID: <4B543CB0.8090801@teldevice.co.jp>
Date: Mon, 18 Jan 2010 19:49:20 +0900
From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
MIME-Version: 1.0
Subject: [LTP] i.MX31 Platform Embedded Linux LTP Test
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

Hello All,

This is Ashish Agarwal, I am new to LTP.

Last day i was succeeded to install the LTP over Fedora 7 system. and run test as well.

As my main motive of LTP learn is to Test a customized Embedded Linux system for Freescale i.Mx31 CPU.

My Project specs are as below:

Kernel: 2.6.19.2
CPU: i.MX31
Rootfs mounted over : Flash (jffs2 file system, 256MB)

So my motive is to install the LTP and run the test.

Because my system is mounted over Flash, so it can be seen as the memory is remained is not so much as we can use in general projects (PC's).
and i had not include any "make" and "gcc" components to my customized kernel. (because of memory)

So how can i install the LTP over the system.  (i have USB ports, and mass storage driver support).

--

Ashish Agarwal

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
