Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Riolm-0001YS-JR
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 14:58:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Riolh-0008Ve-5H
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 14:58:18 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q05Ew7dL001913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Jan 2012 09:58:07 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Thu,  5 Jan 2012 22:57:47 +0800
Message-Id: <1325775471-19975-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.5"
Subject: [LTP] [PATCH v3 0/4] new testcases to test setxattr(2)/getxattr(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.7.5
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Basic tests for setxattr(2)/getxattr(2) and make sure they handle error
conditions correctly.

v2 -> v3:
	1. Remove unnecessary variables
	2. Add setxattr02 and getxattr02 testcases
v1 -> v2:
	1. Statically initialize test case array
	2. Use TTERRNO with TPASS and TFAIL to print TEST_ERRNO message

Eryu Guan (4):
  syscalls/setxattr01: new testcase to test setxattr(2) basic function
  syscalls/getxattr01: new testcase to test getxattr(2) basic function
  syscalls/setxattr02: new testcase to test setxattr(2)
  syscalls/getxattr02: new testcase to test getxattr(2)

 runtest/syscalls                                |    6 +
 testcases/kernel/syscalls/getxattr/Makefile     |   23 +++
 testcases/kernel/syscalls/getxattr/getxattr01.c |  173 +++++++++++++++++
 testcases/kernel/syscalls/getxattr/getxattr02.c |  152 +++++++++++++++
 testcases/kernel/syscalls/setxattr/Makefile     |   23 +++
 testcases/kernel/syscalls/setxattr/setxattr01.c |  223 +++++++++++++++++++++
 testcases/kernel/syscalls/setxattr/setxattr02.c |  235 +++++++++++++++++++++++
 7 files changed, 835 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr01.c
 create mode 100644 testcases/kernel/syscalls/getxattr/getxattr02.c
 create mode 100644 testcases/kernel/syscalls/setxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/setxattr/setxattr01.c
 create mode 100644 testcases/kernel/syscalls/setxattr/setxattr02.c

-- 
1.7.7.5

--------------1.7.7.5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--------------1.7.7.5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.5--

