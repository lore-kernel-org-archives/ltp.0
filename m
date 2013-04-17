Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1USSGE-0001Ap-Gc
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 13:18:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USSGC-0007MZ-Nv
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 13:18:54 +0000
Message-ID: <516EA14E.1020407@cn.fujitsu.com>
Date: Wed, 17 Apr 2013 21:19:10 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <516E68ED.3040507@gmail.com>
In-Reply-To: <516E68ED.3040507@gmail.com>
Subject: Re: [LTP] [PATCH V3]  Fix short of nodemask array.
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
To: Lans Zhang <lans.zhang2008@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 04/17/2013 05:18 PM, Lans Zhang wrote:
> Changes since V2:
> remove unused parameter in set_node()
> 
> In kernel, if user specified more nodes, e.g, 512 nodes, than the
> supported, e.g, 4 nodes, kernel will check if the non supported
> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
> are overrunning "nmask", whose length is shorter than MAXNODES,
> and where the unsupported bits should be cleared to pass the check.
> 
> Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>

Applied, thank you all involved.

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
