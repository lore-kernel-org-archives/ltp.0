Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WQza4-0001nE-MU
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WQza2-0005jA-UM
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2LDXgOw003871
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Mar 2014 21:33:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 21 Mar 2014 19:43:58 +0800
Message-Id: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] Usage about LTP_BIG_DEV exported by runltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Some tests may need a big block device to complete test. When having
this demand, users may run runltp script with "-z" option to specify
such a big block device.

When a big block device is specified, related test cases will run. But
these tests may need different requirement about the size of the block
device. If testA needs 500MB and testB needs 1GB, and if one user
has interest in testA and he also doesn't know the existence of testB,
when he specifies a block device size of 600MB, then testB will fail.

So when user needs a big block device, he may first need to determine
the mounted block device's free space. If the specified device does not
have enouth free space, the test should also return TCONF.

Maybe this also need to be updated to doc/test-writing-guidelines.txt.

Thanks.


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
