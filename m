Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SXoke-0006jj-N4
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 07:15:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXokd-0001fs-Dz
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 07:15:56 +0000
Message-ID: <4FBF3170.80901@cn.fujitsu.com>
Date: Fri, 25 May 2012 15:14:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4FBF2F29.6030603@redhat.com>
In-Reply-To: <4FBF2F29.6030603@redhat.com>
Subject: Re: [LTP] [PATCH v3] mbind01,
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

On 05/25/2012 03:05 PM, Jan Stancek wrote:

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
> Avoid hardcoded node 0 by picking first available node obtained using
> get_mempolicy(..., MPOL_F_MEMS_ALLOWED);
> 
> Using whole nodemask doesn't work with MPOL_PREFERRED, because set_mempolicy
> will use only first node and subsequent check for bitmask equality fails.
> 


Thank you Jan,

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   22 ++++++++++++++++++-
>  testcases/kernel/syscalls/mbind/mbind01.c          |   22 ++++++++++++++++++-
>  2 files changed, 40 insertions(+), 4 deletions(-)
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
