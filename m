Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1NLGos-00015c-EB
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 13:55:06 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLGon-0000U9-8a
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 13:55:06 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id nBHDe4wA012156
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Dec 2009 19:10:04 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBHDe4WF2674786
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Dec 2009 19:10:04 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBHDe3Cv009227
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Dec 2009 19:10:04 +0530
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2009 19:10:01 +0530
Message-ID: <1261057201.11550.21.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] Configuration error while installing ltp-intermediate-20091209
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

I faced the following error while running ./configure in the latest LTP.
After changing the system date to some random future date, issue is
resolved.

[root@xxx ltp-intermediate-20091209.orig]# ./configure 
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... configure: error: newly
created file is older than distributed files!
Check your system clock

[root@xxx ]# date --set="Thu Dec 19 2009 18:54:00"
[root@xxx ltp-intermediate-20091209.orig]# ./configure 
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
...
...



Thanks
Muni


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
