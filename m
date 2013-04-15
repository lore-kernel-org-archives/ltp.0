Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URZq7-0002wV-BC
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:12:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URZq5-0007wn-Ek
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 03:12:19 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3F3C4Z4007051
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Apr 2013 11:12:05 +0800
Message-ID: <516B7026.8070106@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 11:12:38 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5163C37E.9@cn.fujitsu.com> <5163CA00.9040505@cn.fujitsu.com>
In-Reply-To: <5163CA00.9040505@cn.fujitsu.com>
Subject: Re: [LTP] [PATCHv2] testscripts/test_fs_bind.sh: adapt to system
 which marks mount point as "shared" defaultly
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/09/2013 03:57 PM, DAN LI wrote:
> Linux kernel does not allow to move a mount residing under a
> shared mount.
> 
> This patch tries to make sure test cases of "move" run under
> a private mount.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
