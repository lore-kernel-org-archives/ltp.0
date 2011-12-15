Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Rb7ih-0001lo-41
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 09:35:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rb7ig-0000Bt-AB
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 09:35:19 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBF9ZCX8003169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Dec 2011 04:35:12 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id pBF9ZB34002146
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Dec 2011 04:35:11 -0500
Message-ID: <4EE9BF4E.3080606@redhat.com>
Date: Thu, 15 Dec 2011 10:35:10 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 0/2] pipeio: prevent race between SIGCHLD and open()
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

Changes in v2:
- use TERRNO instead of strerror(errno)
- differentiate error messages from semaphores
- add warning if parent times out while waiting for
   child processes to exit

Jan Stancek (2):
   pipeio: convert strerror(errno) to TERRNO
   pipeio: prevent race between SIGCHLD and open()

  testcases/kernel/ipc/pipeio/pipeio.c |   71 
+++++++++++++++++++++++++--------
  1 files changed, 54 insertions(+), 17 deletions(-)


------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
