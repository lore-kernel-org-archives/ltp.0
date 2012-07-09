Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1So52s-0008Ov-FK
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 03:53:58 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1So52q-0004Pn-8S
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 03:53:58 +0000
Received: by pbbrq2 with SMTP id rq2so17523911pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 08 Jul 2012 20:53:50 -0700 (PDT)
Message-ID: <4FFA5428.50802@casparzhang.com>
Date: Mon, 09 Jul 2012 11:46:48 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1341800766-5786-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1341800766-5786-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] hugeshmat01: fix the wrong generated addr
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 07/09/2012 10:26 AM, Wanlong Gao wrote:
> The missed parentheses made the wrong operation.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Thanks for catching this. Pushed.

Caspar

> ---
>  testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> index 84a9121..2206dad 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> @@ -128,8 +128,8 @@ int main(int ac, char **av)
>  			 * address for TC[1]
>  			 */
>  			if (i == 0 && addr != (void *)-1)
> -				TC[1].addr = (void *)((unsigned long)addr &
> -					    ~(SHMLBA-1) + SHMLBA - 1);
> +				TC[1].addr = (void *)(((unsigned long)addr &
> +					     ~(SHMLBA-1)) + SHMLBA - 1);
>  			if (shmdt(addr) == -1)
>  				tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
>  		}
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
