Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TNfW2-0006Im-RC
	for ltp-list@lists.sourceforge.net; Mon, 15 Oct 2012 07:55:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TNfVx-0004XF-5m
	for ltp-list@lists.sourceforge.net; Mon, 15 Oct 2012 07:55:10 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9F7swCZ005734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Oct 2012 03:54:58 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q9F7svMJ022594
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Oct 2012 03:54:58 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 Oct 2012 09:54:49 +0200
Message-Id: <cover.1350287148.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 0/2] new restcases: readahead01/02
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Changes in v3:
remove unused argv parameter from setup -> setup(void)
add parentheses to else blocks where needed
free tmp buffer before TBROK

Jan Stancek (2):
  new syscall test: readahead01
  new syscall test: readahead02

 runtest/syscalls                                  |    3 +
 testcases/kernel/syscalls/readahead/Makefile      |   22 ++
 testcases/kernel/syscalls/readahead/readahead01.c |  172 ++++++++++
 testcases/kernel/syscalls/readahead/readahead02.c |  378 +++++++++++++++++++++
 4 files changed, 575 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/readahead/Makefile
 create mode 100644 testcases/kernel/syscalls/readahead/readahead01.c
 create mode 100644 testcases/kernel/syscalls/readahead/readahead02.c


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
