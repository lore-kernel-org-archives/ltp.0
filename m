Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SPJ-000847-AG
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:06:57 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SPH-0006sj-8i
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:06:57 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ025ZIWBB2OD0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:06:47 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:41 +0530
Message-id: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 00/13] Use ARRAY_SIZE Macro where possible
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
Cc: pankaj.m@samsung.com

Following patchset provides use of ARRAY_SIZE macro
instead of sizeof(type)/sizeof(type[0]).

Created with following coccinelle patch:- 

@@
type T;
T[] E;
@@
- (sizeof(E)/sizeof(E[0]))
+ ARRAY_SIZE(E)


Maninder Singh (13):
  kernel/pidns: use ARRAY_SIZE
  kernel/fs: use ARRAY_SIZE
  kernel/fs: use ARRAY_SIZE
  kernel/mq_timedreceive: use ARRAY_SIZE
  kernel/mq_open: use ARRAY_SIZE
  kernel/getxattr: use ARRAY_SIZE
  kernel/socketpair: use ARRAY_SIZE
  kernel/mq_timedsend: use ARRAY_SIZE
  kernel/fadvise: use ARRAY_SIZE
  kernel/dup2: use ARRAY_SIZE
  kernel/mq_unlink: use of ARRAY_SIZE
  kernel/rt_sigaction: use ARRAY_SIZE
  kernel/nft: use ARRAY_SIZE
  
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com> 
  
 testcases/kernel/containers/pidns/pidns17.c        |    4 ++--
 testcases/kernel/fs/fsstress/fsstress.c            |    7 ++++---
 testcases/kernel/fs/ftest/ftest02.c                |    2 +-
 testcases/kernel/fs/ftest/ftest06.c                |    2 +-
 testcases/kernel/syscalls/dup2/dup204.c            |    2 +-
 .../kernel/syscalls/fadvise/posix_fadvise01.c      |    2 +-
 .../kernel/syscalls/fadvise/posix_fadvise03.c      |    2 +-
 testcases/kernel/syscalls/getxattr/getxattr01.c    |    4 ++--
 testcases/kernel/syscalls/mq_open/mq_open01.c      |    2 +-
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    2 +-
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    2 +-
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c  |    2 +-
 testcases/kernel/syscalls/nftw/nftw.c              |    8 ++++----
 testcases/kernel/syscalls/nftw/nftw64.c            |    8 ++++----
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |    3 +--
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    2 +-
 .../kernel/syscalls/socketpair/socketpair02.c      |    4 ++--
 18 files changed, 30 insertions(+), 30 deletions(-)

-- 
1.7.9.5


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
