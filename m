Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SolIa-0000NN-RH
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 01:01:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SolIZ-0005tU-8P
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 01:01:00 +0000
Message-ID: <4FFCD02B.5020103@cn.fujitsu.com>
Date: Wed, 11 Jul 2012 09:00:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 1/2] mm/vma01: consider topdown and bottomup
	allocation
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
> When calculating VMAs, results differ in topdown and bottomup memory
> allocation mechanisms. This patch fix the potential failures and should
> work like below:
> 
> In topdown allocation, the start addr in second VMA should be smaller
> than first one, i.e.:
> 
>     u======t------(t+3*ps)
>       2nd    1st
> 
> Thus, in buggy kernel, if we find a VMA mapping entry in child like:
> 
>     start_addr == u && end_addr == t+3*ps;
> 
> the test would go fail. Otherwise, in good kernel, we should see
> 
>     start_addr1 == u && end_addr1 == t;
>     start_addr2 == t && end_addr2 == t+3*ps;
> 
> While in bottomup allocation, it's different:
> 
>     t------u======(t+6*ps)
>       1st    2nd
> 
> Here in buggy kernel, we can see VMA mapping entry like this:
> 
>     start_addr == t && end_addr == t+6*ps;
> 
> And in good kernel:
> 
>     start_addr1 == t && end_addr1 == u;
>     start_addr2 == u && end_addr2 == t+6*ps;
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Pushed this series without objection, thank you.

Wanlong Gao

> ---
>  testcases/kernel/mem/vma/vma01.c |   35 ++++++++++++++++++++++-------------
>  1 files changed, 22 insertions(+), 13 deletions(-)
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
