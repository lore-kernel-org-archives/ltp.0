Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1ZAVCX-0000pJ-42
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 03:30:13 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZAVCV-00080I-8d
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 03:30:13 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQU029TFCE3KU80@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 12:30:03 +0900 (KST)
Date: Thu, 02 Jul 2015 03:30:03 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1882611005.154971435807803449.JavaMail.weblogic@ep2mlwas01a>
Subject: Re: [LTP] [PATCH 00/13] Use ARRAY_SIZE Macro where possible
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: PANKAJ MISHRA <pankaj.m@samsung.com>

Hello,

Using generic functions is always better than open coded stuff.
Also most of ltp code use ARRAY_SIZE , so make remaining code to
use the same.

Any Comments ?  :)

------- Original Message -------
Sender : Maninder Singh<maninder1.s@samsung.com> 
Date : Jun 26, 2015 21:04 (GMT+09:00)
Title : [PATCH 00/13] Use ARRAY_SIZE Macro where possible
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
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
