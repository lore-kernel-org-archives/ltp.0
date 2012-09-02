Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gang.chen@asianux.com>) id 1T837b-0006Hz-8X
	for ltp-list@lists.sourceforge.net; Sun, 02 Sep 2012 05:53:23 +0000
Received: from intranet.asianux.com ([58.214.24.6])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T837Y-0002sr-5X
	for ltp-list@lists.sourceforge.net; Sun, 02 Sep 2012 05:53:23 +0000
Received: from [10.1.0.143] (unknown [219.143.36.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranet.asianux.com (Postfix) with ESMTP id F35C51840226
	for <ltp-list@lists.sourceforge.net>;
	Sun,  2 Sep 2012 13:29:30 +0800 (CST)
Message-ID: <5042EF01.9020700@asianux.com>
Date: Sun, 02 Sep 2012 13:30:41 +0800
From: gchen <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [LTP] [QUESTION] ltp stress test for RHEL5 and  NFS local mount
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

Hello ltp-list@lists.sourceforge.net


Question:

Use ltp stress test (/opt/ltp/ltpstress.sh) with ltp-full-20100331.gz
to test RHEL5 (kernel-2.6.18-308.4.1.el5) for 72 hours.

Not give any more configurations for NFS (using default configuration:
mount NFS locally, so the NFS client and NFS server are on the same
machine).

My question is that "for stress test, is it suitable to let NFS server and
client on the same machine ?"


Background;

This configuration will cause deadlock for RHEL5, and can not boot
machine in normal way.

someone from Red Hat has said that:
--------------------------------------------------------------------------------------------------------------

"Have configuration where the same host is acting as both NFS client
and server. That's a configuration known to cause deadlocks."

--------------------------------------------------------------------------------------------------------------

can reference Red Hat Bugzilla (bug 848706) for more details.




thanks.

gchen.

Asianux Corporation.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
