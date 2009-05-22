Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1M7R4l-00073y-26
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:30:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7R4g-0000nW-8t
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 09:30:03 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 591D617014D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 May 2009 17:38:07 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n4M9UbCh018637
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 17:30:37 +0800
Received: from [10.167.141.76] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id DE66FD4038
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 May 2009 17:40:09 +0800 (CST)
Message-ID: <4A166FB6.6010208@cn.fujitsu.com>
Date: Fri, 22 May 2009 17:26:14 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [QUESTION] about test execve04 which testing for EMFILE
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

recently kernel commit e7b9b550f53e81ea38e71d322d6f95730df058a2
has removed the file get code. The execve syscall will never
return EMFILE.

Call to execve() will be suceess even if the the process has the
maximum number of files open, because execve() never open any file.

Can anyone tell me what does this test case test for? It be wrote
base on which document? Just the man page?



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
