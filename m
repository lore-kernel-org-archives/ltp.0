Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gang.chen@asianux.com>) id 1TVJST-0004vr-Qj
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 09:59:05 +0000
Received: from intranet.asianux.com ([58.214.24.6])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TVJSM-0006W0-2Y
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 09:59:05 +0000
Received: from [10.1.0.143] (unknown [219.143.36.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranet.asianux.com (Postfix) with ESMTP id 2EFB7184020C
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 Nov 2012 17:38:05 +0800 (CST)
Message-ID: <5097893B.7060105@asianux.com>
Date: Mon, 05 Nov 2012 17:39:07 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [LTP] [Issue Report] the stress test which includes nfs test with
 client and server under same machine
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

Hello ltp-list@lists.sorceforge.net 

1) Firstly:

   A) LTP is a very useful tools for Asianux to test Linux kernel.
   B) Thank LTP very much.
   C) During test, Asianux find an issue about LTP
      Asianux think maybe it will be better to let LTP know about it.


2) Description:

   A) with default configuration for /opt/ltp/testscripts/ltpstress.sh
   B) it tests the nfs with client and server under the same machine
   C) it is an known issue about it.

3) Reference

   A) Red Hat Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=858978
   B) LKVM Mailing list: https://lkml.org/lkml/2012/10/16/1  (at tail)

> Running the client and server on the same machine is likely to deadlock
> due to memory pressure issues. The client needs to be able to _increase_
> memory pressure on the server in order to reduce its own pressure. That
> doesn't work well when client == server.



  At last, hope these information are useful for LTP,  thanks.

-- 
Chen Gang

Asianux Corporation

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
