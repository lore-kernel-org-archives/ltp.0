Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U7cli-0002wq-TU
	for ltp-list@lists.sourceforge.net; Tue, 19 Feb 2013 02:17:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U7clg-0001Mw-61
	for ltp-list@lists.sourceforge.net; Tue, 19 Feb 2013 02:17:18 +0000
Message-ID: <5122E06B.8090206@cn.fujitsu.com>
Date: Tue, 19 Feb 2013 10:16:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1361196214.git.jstancek@redhat.com>
	<b553e0adb83db2ce4db549dce2643ac49c7b9141.1361196214.git.jstancek@redhat.com>
In-Reply-To: <b553e0adb83db2ce4db549dce2643ac49c7b9141.1361196214.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 3/3] setns: add new syscall test setns02
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

On 02/18/2013 10:05 PM, Jan Stancek wrote:
> functional test for setns(2) - reassociate thread with a namespace
> involving CLONE_NEWIPC and CLONE_NEWUTS.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
