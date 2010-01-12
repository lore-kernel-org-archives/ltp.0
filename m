Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NUaei-0002A8-NS
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 06:55:08 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUaeh-0005K6-CN
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 06:55:08 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id DA50B211013
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 06:54:51 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 35EDF3DD016
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 06:54:51 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Jan 2010 15:54:49 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 12 Jan 2010 15:54:49 +0900
Message-ID: <001401ca9354$224c92a0$66e5b7e0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Build failure with 2010-01-08 cvs
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

I tried to make with 2010-01-08 version cvs in my RHEL5.4 
(2.6.18-164.el5) system.
But it failed with following message:

------------
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2010-01-08/testcases/kernel/include
-I/home/LTP/ltp-2010-01-08/testcases/kernel/syscalls/move_pages/../utils
-I../../../../include -I../../../../include  -c -o move_pages01.o
move_pages01.c
In file included from move_pages01.c:58:
move_pages_support.h:22:20: error: numaif.h: No such file or directory
make[4]: *** [move_pages01.o] Error 1
------------

2010-01-07 version cvs doesn't fail.

Perhaps, this error is caused by revision of RHEL4.8's make error, I think.
(URL:http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09180.htm
l)
I'm sorry If I mistaked.

In above revising, "${LTPROOT/testcases/kernel/syscalls/utils/numaif.h"
is removed. But "move_pages01.c" uses this file indirectly.

Is the plan to delete a definition of "nodemask_dump" from "${LTPROOT/
testcases/kernel/syscalls/get_mempolicy/../utils/numa_helpers.h" file
no use?


Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
