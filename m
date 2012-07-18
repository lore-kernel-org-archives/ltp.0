Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrQEt-0000GR-KW
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:08:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrQEs-0007of-Et
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:08:11 +0000
Message-ID: <50067CCD.9050403@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 17:07:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cd2c28ba71de86eba7b5348d6372a240b835be22.1342601407.git.zliu@redhat.com>
In-Reply-To: <cd2c28ba71de86eba7b5348d6372a240b835be22.1342601407.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] mm/lib: correct the log messages
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/18/2012 04:51 PM, Zhouping Liu wrote:
> commit 5ad42f6cae increased the sleep time of ksmd scanning
> inside _wait_ksm_done(), but it forgot to update the log messages.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Pushed, thank you.

Wanlong Gao

> ---
>  testcases/kernel/mem/lib/mem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 9ec0454..81410d8 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -183,7 +183,7 @@ static void _wait_ksmd_done(void)
>  	}
>  
>  	tst_resm(TINFO, "ksm daemon takes %ds to scan all mergeable pages",
> -		    count * 5);
> +		    count * 10);
>  }
>  
>  static void _group_check(int run, int pages_shared, int pages_sharing,
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
