Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U7RLf-0002hy-UJ
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 14:05:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U7RLe-0006C7-4y
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 14:05:39 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1IE5Wjc029809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Feb 2013 09:05:32 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Feb 2013 15:05:14 +0100
Message-Id: <cover.1361196214.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 0/3] add new syscall test for setns(2)
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

changes in v3:
- added missing "void" to functions without parameters
- INIT_NS_TYPE macro converted to function
- use ltp_syscall in setup()

Jan Stancek (3):
  setns: setup directory at kernel/syscalls/setns
  setns: add new syscall test setns01
  setns: add new syscall test setns02

 runtest/syscalls                          |    3 +
 testcases/kernel/syscalls/.gitignore      |    2 +
 testcases/kernel/syscalls/setns/Makefile  |   23 +++
 testcases/kernel/syscalls/setns/setns.h   |   88 +++++++++++
 testcases/kernel/syscalls/setns/setns01.c |  240 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/setns/setns02.c |  231 +++++++++++++++++++++++++++
 6 files changed, 587 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setns/Makefile
 create mode 100644 testcases/kernel/syscalls/setns/setns.h
 create mode 100644 testcases/kernel/syscalls/setns/setns01.c
 create mode 100644 testcases/kernel/syscalls/setns/setns02.c


------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
