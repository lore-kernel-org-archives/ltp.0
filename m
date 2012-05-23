Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SXBwk-0001vY-Pf
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 13:49:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXBwi-0004jJ-T8
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 13:49:50 +0000
Message-ID: <4FBCEAC4.60602@cn.fujitsu.com>
Date: Wed, 23 May 2012 21:48:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4FBCC3E1.70302@redhat.com>
In-Reply-To: <4FBCC3E1.70302@redhat.com>
Subject: Re: [LTP] [PATCH] mbind01,
 get_mempolicy01: dont use hardcoded node 0
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/23/2012 07:02 PM, Jan Stancek wrote:

> 
> These tests are failing on following setup:
>   # numactl -H
>   available: 2 nodes (0-1)
>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
>   23 24 25 26 27 28 29 30 31
>   node 0 size: 0 MB
>   node 0 free: 0 MB
>   node 1 cpus:
>   node 1 size: 12288 MB
>   node 1 free: 9998 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
> 
> Avoid hardcoded node 0 by using numa_get_mems_allowed().
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>


Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  .../syscalls/get_mempolicy/get_mempolicy01.c       |    7 ++++---
>  testcases/kernel/syscalls/mbind/mbind01.c          |    7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
