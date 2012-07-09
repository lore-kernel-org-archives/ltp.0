Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SoDGm-0006pt-Cv
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:40:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoDGg-0006ux-K0
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 12:40:52 +0000
Message-ID: <4FFACA0F.80605@cn.fujitsu.com>
Date: Mon, 09 Jul 2012 20:09:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
	<1340609583-8300-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1340609583-8300-2-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 2/2] mm/vma01: create a bighole
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Wang Sheng-Hui <shhuiw@gmail.com>

On 06/25/2012 03:33 PM, Caspar Zhang wrote:
> 
> There are two mmaps in vma01, sometimes first mmap succeeds while
> second mmap might fail due to a small hole (3*ps <= hole < 6*ps)
> produced by /etc/ld.so.cache and /etc/libc.so.6, I created a big hole
> and then munmap it to make sure both allocations can succeed.

Can you share how to produce the hole and make the previous case FAIL?

Thanks,
Wanlong Gao

> 
>     |-3*ps-|
> 	|------|------|------| hole
> 	t      p
> 	|======|------|        top-down alloc
> 	       |------|======| bottom-up alloc
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/vma/vma01.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
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
> 



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
