Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U0Mll-00030D-AZ
	for ltp-list@lists.sourceforge.net; Wed, 30 Jan 2013 01:47:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U0Mlj-0000DQ-RG
	for ltp-list@lists.sourceforge.net; Wed, 30 Jan 2013 01:47:21 +0000
Message-ID: <51087B8E.6000102@cn.fujitsu.com>
Date: Wed, 30 Jan 2013 09:46:54 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4b6d511bffcb48649da90750ac07179bf9923292.1359366562.git.jstancek@redhat.com>
In-Reply-To: <4b6d511bffcb48649da90750ac07179bf9923292.1359366562.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] aio_fsync/2-1.c: fix race at exit,
 check if write completed
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 01/28/2013 06:36 PM, Jan Stancek wrote:
> This is same issue as:
>   commit 4558bfae923a715ac78b5b3d3ecdfa16f9424808
>   Author: Jan Stancek <jstancek@redhat.com>
>   Date:   Wed Dec 5 12:49:47 2012 +0100
>       aio_read/7-1.c: fix race at exit
> 
> This patch waits for aio_fsync to complete and after that
> checks that previously queued write is also completed.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
