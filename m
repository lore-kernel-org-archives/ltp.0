Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WG3am-0005tW-NZ
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 09:37:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WG3al-0007sO-Mo
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 09:37:24 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1J9af7S020771
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 17:36:42 +0800
Message-ID: <53047AA8.6080202@cn.fujitsu.com>
Date: Wed, 19 Feb 2014 17:34:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1390210456.6682.12.camel@G08JYZSD130126>	<1390210861.6682.14.camel@G08JYZSD130126>	<1392736686.2654.13.camel@G08JYZSD130126>
	<1392736891.2654.15.camel@G08JYZSD130126>
In-Reply-To: <1392736891.2654.15.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] mkdir/mkdir03.c: add new error number tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 02/18/2014 11:21 PM, Zeng Linggang wrote:
> Add ELOOP, EROFS error number tests fof mkdir(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mkdir/mkdir03.c | 61 +++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
