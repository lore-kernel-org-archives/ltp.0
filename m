Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PHz8x-0002s5-Oz
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 13:30:47 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PHz8w-0001PO-KT
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 13:30:47 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAFDUeqV025869
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Nov 2010 08:30:40 -0500
Date: Mon, 15 Nov 2010 08:30:40 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <431327867.2904911289827840762.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1428547509.2904601289827655670.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] maximum seconds of -I
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi, I am wondering if there is a limitation of seconds you can specify in standard command-line options for,

-I x    Execute test for x seconds

I noticed that when given a value like 3600, the test returned immediately like,

./hugemmap04 -I 3600 -H /var/hugetlbfs

Is this expected?

CAI Qian

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
