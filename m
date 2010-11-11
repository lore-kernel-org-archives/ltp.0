Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PGNWz-0007bz-HE
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 03:08:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGNWw-000100-6m
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 03:08:57 +0000
Message-ID: <4CDB5E53.6070604@cn.fujitsu.com>
Date: Thu, 11 Nov 2010 11:09:07 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH 0/2]aio_suspend may be interrupted by
 completion signal.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

aio_suspend may be interrupted by IO request's completion signal, so we
should use aio_error instead signal hander to check whether this request
has complete.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

-----

 .../conformance/interfaces/aio_suspend/1-1.c       |   49 ++++++---------
 .../conformance/interfaces/aio_suspend/4-1.c       |   65 +++++++-------------
 2 files changed, 41 insertions(+), 73 deletions(-)

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
