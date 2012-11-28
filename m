Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TdYoj-0004ko-Bx
	for ltp-list@lists.sourceforge.net; Wed, 28 Nov 2012 04:00:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TdYoi-0004DC-0d
	for ltp-list@lists.sourceforge.net; Wed, 28 Nov 2012 04:00:09 +0000
Message-ID: <50B5857E.6080901@cn.fujitsu.com>
Date: Wed, 28 Nov 2012 11:31:10 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1353656410-4670-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1353656410-4670-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] numa01: fix the wrong method of getting numa
	nodes number
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
To: LTP <ltp-list@lists.sourceforge.net>

On 11/23/2012 03:40 PM, Wanlong Gao wrote:
> Fix the method of getting the number of numa nodes.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

FYI, Applied.

Wanlong Gao

> ---
>  testcases/kernel/numa/numa01.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
> index 9790ef4..9b491fc 100644
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -807,7 +807,7 @@ test010()
>          fi
>  
>              col=2                       #column represents node0 in numastat o/p
> -        numnodes=$(ls /sys/devices/system/node | wc -l)
> +        numnodes=$(ls /sys/devices/system/node | grep -Ec "node?")
>          Preferred_node=$[$[$numnodes/2]-1]
>          col=$[$Preferred_node+2]
>          numastat > $LTPTMP/numalog
> 


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
INSIGHTS What's next for parallel hardware, programming and related areas?
Interviews and blogs by thought leaders keep you ahead of the curve.
http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
