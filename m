Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VK08u-0001Hr-7K
	for ltp-list@lists.sourceforge.net; Thu, 12 Sep 2013 06:12:40 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VK08s-00010I-Cu
	for ltp-list@lists.sourceforge.net; Thu, 12 Sep 2013 06:12:40 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8C6CVIP002578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Sep 2013 06:12:32 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8C6CVce024185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Sep 2013 06:12:31 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8C6CV0F008976
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Sep 2013 06:12:31 GMT
Message-ID: <52315B4D.1020902@oracle.com>
Date: Thu, 12 Sep 2013 10:12:29 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: [LTP] FORK_OR_VFORK
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

Hello!

LTP employs FORK_OR_VFORK macro which is defined as:

#ifdef UCLINUX
#define FORK_OR_VFORK                   vfork
#define MAP_PRIVATE_EXCEPT_UCLINUX      0
#else
#define FORK_OR_VFORK                   fork
#define MAP_PRIVATE_EXCEPT_UCLINUX      MAP_PRIVATE
#endif

So, on UCLINUX it is a vfork call.

But many testcases use this macro and try to use functions other than 
exec() and _exit() inside a child.
Example - syscalls/setfsuid/setfsuid04.c.
And I suppose that because of that fact these testcases may fail on 
UCLINUX (or behave unexpectedly).

Is this situation left intentionally? Does somebody care about this 
issue? Or we simply ignore it.

I'm just curious. :)

Thanks.














------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
