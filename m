Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sj0Gv-0000xE-41
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 03:47:29 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Sj0Gr-00057J-8h
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 03:47:29 +0000
Received: by pbbrq2 with SMTP id rq2so5516479pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 24 Jun 2012 20:47:19 -0700 (PDT)
Message-ID: <4FE7DF2A.4010208@casparzhang.com>
Date: Mon, 25 Jun 2012 11:46:50 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1340594555-32059-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1340594555-32059-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] mm/vma01: consider topdown and bottomup allocation
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
To: hejianet@linux.vnet.ibm.com, Wang Sheng-Hui <shhuiw@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/25/2012 11:22 AM, Caspar Zhang wrote:
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
> ---
>  testcases/kernel/mem/vma/vma01.c |   35 ++++++++++++++++++++++-------------
>  1 files changed, 22 insertions(+), 13 deletions(-)
> 

The patch itself passes my test, yet I give it a self-NAK for now. Needs
one more patch to resolve the issue hejianet brought up.

Caspar

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
