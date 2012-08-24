Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4luI-00022h-4w
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:06 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4luH-0001OS-AH
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:06 +0000
Received: by pbcwy7 with SMTP id wy7so2433895pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Aug 2012 21:53:59 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri, 24 Aug 2012 12:53:31 +0800
Message-Id: <cover.1345783919.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.12"
Subject: [LTP] [PATCH v2 0/4] cma testcases
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.12
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Thanks Jan for helping with solving the race issue. I have updated the 
patches and get them sanity tested.

Caspar Zhang (4):
  syscall/process_vm_readv02: new testcase
  syscall/process_vm_readv03: new testcase
  syscall/process_vm_writev02: new testcase
  runtest/syscalls: add cma testcases

 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/cma/process_vm.h         |  47 ++++
 testcases/kernel/syscalls/cma/process_vm_readv02.c | 172 +++++++++++++
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 281 +++++++++++++++++++++
 .../kernel/syscalls/cma/process_vm_writev02.c      | 212 ++++++++++++++++
 5 files changed, 715 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv02.c
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv03.c
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev02.c

-- 
1.7.12



--------------1.7.12
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.12
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.12--
