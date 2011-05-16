Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QLzPl-0002hm-Tf
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 15:08:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QLzPk-0004NO-SN
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 15:08:57 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4GF8pg0014712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 May 2011 11:08:51 -0400
Message-ID: <4DD13DFB.3060505@redhat.com>
Date: Mon, 16 May 2011 23:08:43 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
In-Reply-To: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [syscalls] getrusage03: test ru_maxrss
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 05/16/2011 11:05 PM, Caspar Zhang wrote:
> 
> getrusage03 - test ru_maxrss behaviors in struct rusage
> 
> This test program is backported from upstream commit:
> 1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
> value in struct rusage according to rss hiwater mark. To make sure
> this feature works correctly, a series of tests are executed in
> this program.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  runtest/syscalls                                  |    1 +
>  testcases/kernel/syscalls/getrusage/child.c       |  165 ++++++++++
>  testcases/kernel/syscalls/getrusage/getrusage03.c |  341 +++++++++++++++++++++
>  3 files changed, 507 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/getrusage/child.c
>  create mode 100644 testcases/kernel/syscalls/getrusage/getrusage03.c
> 

PASS/FAIL Criteria
==================
This test PASS when all sub-tests executed successfully and return code
is 0. The test gets FAIL when any TFAIL/TBROK information occurs on
output or/and the return code is a non-zero value.

EXAMPLE OUTPUT
==============
getrusage03    0  TINFO  :  allocate 100MB
getrusage03    0  TINFO  :  Testcase #01: fork inherit
getrusage03    0  TINFO  :  initial.self = 108456
child_proc     0  TINFO  :  child.self = 103632
getrusage03    1  TPASS  :  initial.self ~= child.self
getrusage03    0  TINFO  :  Testcase #02: fork inherit(cont.)
getrusage03    0  TINFO  :  initial.children = 105244
getrusage03    2  TPASS  :  initial.children ~= 100MB
child_proc     0  TINFO  :  child.children = 0
getrusage03    3  TPASS  :  child.children == 0
getrusage03    0  TINFO  :  Testcase #03: fork + malloc
getrusage03    0  TINFO  :  initial.self = 108716
child_proc     0  TINFO  :  child allocate +50MB
child_proc     0  TINFO  :  child.self = 154744
getrusage03    4  TPASS  :  initial.self + 50MB ~= child.self
getrusage03    0  TINFO  :  Testcase #04: grandchild maxrss
getrusage03    0  TINFO  :  initial.children = 156460
child_proc     0  TINFO  :  grandchild allocate 300MB
getrusage03    0  TINFO  :  post_wait.children = 310028
getrusage03    5  TPASS  :  child.children ~= 300MB
getrusage03    0  TINFO  :  Testcase #05: zombie
getrusage03    0  TINFO  :  initial.children = 310028
child_proc     0  TINFO  :  child allocate 400MB
getrusage03    0  TINFO  :  pre_wait.children = 310028
getrusage03    6  TPASS  :  initial.children ~= pre_wait.children
getrusage03    0  TINFO  :  post_wait.children = 415972
getrusage03    7  TPASS  :  post_wait.children ~= 400MB
getrusage03    0  TINFO  :  Testcase #06: SIG_IGN
getrusage03    0  TINFO  :  initial.children = 415972
child_proc     0  TINFO  :  child allocate 500MB
getrusage03    0  TINFO  :  after_zombie.children = 415972
getrusage03    8  TPASS  :  initial.children ~= after_zombie.children
getrusage03    0  TINFO  :  Testcase #07: exec without fork
getrusage03    0  TINFO  :  initial.self = 108720, initial.children = 415972
child_proc     0  TINFO  :  exec.self = 108732, exec.children = 415972
child_proc     1  TPASS  :  initial.self ~= exec.self
child_proc     2  TPASS  :  initial.children ~= exec.children

# echo $?
0

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
