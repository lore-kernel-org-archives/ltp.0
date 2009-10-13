Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1MxY1i-0006Dk-73
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 03:26:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxY1b-0000ac-QE
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 03:26:18 +0000
Received: from int-mx04.intmail.prod.int.phx2.redhat.com
	(int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n9D3Q5ie005899
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Oct 2009 23:26:05 -0400
Received: from hushan-t.usersys.redhat.com (dhcp-65-44.nay.redhat.com
	[10.66.65.44])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id n9D3Q4pA006643
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Oct 2009 23:26:04 -0400
Message-ID: <4AD3F376.9080506@redhat.com>
Date: Tue, 13 Oct 2009 11:26:46 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] network: fix rpc use rsh instead of ssh
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

Hello,

rpcinfo01 testcase use ssh to run command on remote machine, which will prompt for authentication
and password.
I think it is a typo because all network tests use rsh.

Thanks & Regards,
Hushan

---

network: fix rpc use rsh instead of ssh

Signed-off-by: Hushan Jia <hjia@redhat.com>

---

--- ltp/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.orig	2009-10-13 10:52:59.000000000 +0800
+++ ltp/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01	2009-10-13 10:54:51.000000000 +0800
@@ -94,8 +94,8 @@ else
 	fi
 fi
 
-ssh -n $RHOST "ps -ewf" | grep portmap | grep -v grep > /dev/null
-[ $? -eq 0 ] || ssh -n $RHOST "ps -ewf" | grep rpcbind | grep -v grep > /dev/null
+rsh -n $RHOST "ps -ewf" | grep portmap | grep -v grep > /dev/null
+[ $? -eq 0 ] || rsh -n $RHOST "ps -ewf" | grep rpcbind | grep -v grep > /dev/null
 [ $? -eq 0 ] || end_testcase "The portmap or rpcbind daemon is NOT running on $RHOST"
 
 echo "Test rpcinfo with default options"



------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
