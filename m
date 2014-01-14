Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anasuya@linux.vnet.ibm.com>) id 1W337u-0006Li-5d
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 12:29:50 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W337s-0004Rg-SF
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 12:29:50 +0000
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <anasuya@linux.vnet.ibm.com>; 
	Tue, 14 Jan 2014 17:59:40 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9D90D394004E
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jan 2014 17:59:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s0ECTWBk50200668
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Jan 2014 17:59:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s0ECTaJB011823
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Jan 2014 17:59:37 +0530
Received: from oc5474148834.ibm.com ([9.124.39.82])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s0ECTa0p011809
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Jan 2014 17:59:36 +0530
Message-ID: <52D52DB0.3020003@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 17:59:36 +0530
From: Anasuya M Shankar <anasuya@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]:config.guess: Inclusion of ppc64le architecture
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

The patch is to provide support for power little endian architecture.
The ./configure command fails when this is not taken care on ppc64le 
machines.

Signed-off-by: Anasuya M Shankar <anasuya@linux.vnet.ibm.com>

--- config.guess.orig    2014-01-14 17:21:55.601214002 +0530
+++ config.guess    2014-01-14 17:22:13.746971128 +0530
@@ -952,6 +952,9 @@ EOF
      ppc64:Linux:*:*)
      echo powerpc64-unknown-linux-gnu
      exit ;;
+    ppc64le:Linux:*:*)
+        echo powerpc64le-unknown-linux-gnu
+        exit ;;
      ppc:Linux:*:*)
      echo powerpc-unknown-linux-gnu
      exit ;;

Thanks
Anasuya M Shankar.


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
