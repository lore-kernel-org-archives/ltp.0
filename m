Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1O732B-0008Ff-Bx
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 08:54:19 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7329-0005lp-RJ
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 08:54:19 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3S8s8HG025425
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 14:24:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3S8s8SZ3141700
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 14:24:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3S8s72C013562
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 18:54:07 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Date: Wed, 28 Apr 2010 14:24:07 +0530
Message-ID: <1272444847.5696.9.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP]  mqns tests are failing
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

I noticed that mqns test cases are failing. I am using March 2010 LTP.
After changing mq_open syscall in mqns_01.c file, test is passing. Same
thing is happening w.r.t. other mqns test cases. Below is the change I
made.

Changed 
   mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,0777,
NULL);

to
   mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);

Failure output I got is below:
# ./mqns_01
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

mq_open: Permission denied
posixmq_namespace_01    1  TFAIL  :  mq_open failed

After changing as above, I got the below output:
# ./mqns_01
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_01    0  TINFO  :  Checking namespaces isolation from
parent to child

posixmq_namespace_01    1  TPASS  :  child process didn't find mqueue

So, my question is that what is the difference between the two, i.e.,
the previous one and the changed one. Both are calling the same mq_open
system call. But first one is failing whereas the second one is
succeeding.

So, do we need to modify all mqns test cases to the new form?

Thanks
Muni


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
