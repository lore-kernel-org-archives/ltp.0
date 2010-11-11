Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PGOMx-00027u-JX
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 04:02:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGOMw-0005MO-2p
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 04:02:39 +0000
Message-ID: <4CDB6AEC.9090604@cn.fujitsu.com>
Date: Thu, 11 Nov 2010 12:02:52 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH 0/4]Get rid of some test for aio_suspend.
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

Some aio_suspend tests are redundantly, so we should remove them.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

------

 .../conformance/interfaces/aio_suspend/6-1.c       |  217 ------------------
 .../conformance/interfaces/aio_suspend/7-1.c       |  242 --------------------
 .../conformance/interfaces/aio_suspend/8-1.c       |  240 -------------------
 .../conformance/interfaces/aio_suspend/9-1.c       |  242 --------------------
 4 files changed, 0 insertions(+), 941 deletions(-)


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
