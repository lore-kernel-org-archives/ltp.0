Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T4ozh-0003jw-E0
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 08:11:53 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4ozb-0003kq-QF
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 08:11:53 +0000
Date: Fri, 24 Aug 2012 04:11:41 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1802694099.58389885.1345795901969.JavaMail.root@redhat.com>
In-Reply-To: <1345704181-5596-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
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
To: shuang qiu <shuang.qiu@oracle.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, August 23, 2012 2:43:01 PM
> Subject: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> The value of min_free_kbytes is set too high(half of mem_free) during
> testing min_free_kbytes tunable.It often cause the system to become
> out-of-memory.Using 20% of mem_free to avoid oom and system hang.

Hi, shuang

I met the issue that min_free_kbytes caused system hang before, and what you said made sense.

but after tested the patch, I found it still make the system hang with the patch, so I don't think
this patch can fix the issue completely, maybe there are other factors, or need lower tune value.
always suppose it was because of the high tune value, it's more better to add an optional to control it.
also I will investigate it deeper to look after the real reason. please comment if you have other ideas.

Thanks,
Zhouping

> ---
>  testcases/kernel/mem/tunable/min_free_kbytes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c
> b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index 00ead04..8a03f85 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -128,7 +128,7 @@ static void test_tune(unsigned long
> overcommit_policy)
>  		/* case2 */
>  		else {
>  			memfree = read_meminfo("MemFree:");
> -			tune = memfree / 2;
> +			tune = memfree / 5;
>  			set_sys_tune("min_free_kbytes", tune, 1);
>  		}
>  
> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
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
