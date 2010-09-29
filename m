Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P0qgK-0001hP-6o
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 07:02:24 +0000
Received: from out22.sjc.mx.trendmicro.com ([216.99.131.79])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0qgI-0007H3-0O
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 07:02:24 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.130])
	by out22.sjc.mx.trendmicro.com (Postfix) with ESMTP id E66B7980427
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 07:02:15 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 46DAA1D784E
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 07:02:15 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Sep 2010 16:02:12 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 29 Sep 2010 16:02:12 +0900
Message-ID: <000001cb5fa4$3def0160$b9cd0420$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] POSIX some testsets failed by permission error
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


I noticed that following POSIX testsets failed with "Permission denied".
  - pthread_attr_getschedparam/2-1
  - pthread_attr_setschedparam/2-1
  - pthread_rwlock_destroy/2-1

------------
conformance/interfaces/pthread_attr_getschedparam/2-1: execution: FAILED:
Output: 
Unable to run child application: Permission denied
[...]
conformance/interfaces/pthread_attr_setschedparam/2-1: execution: FAILED:
Output: 
Unable to run child application: Permission denied
[...]
conformance/interfaces/pthread_rwlock_destroy/2-1: execution: FAILED:
Output: 
Unable to run child application: Permission denied
------------

They are shell scripts, but they weren't given rights of execution.

It is necessary to give them rights of execution and to make them 
into package, I think.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
