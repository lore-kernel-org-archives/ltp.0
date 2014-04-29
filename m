Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wf2Vm-0006W4-BN
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 07:31:30 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wf2Vl-0008Rg-Cg
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 07:31:30 +0000
Message-ID: <535F553A.2070900@oracle.com>
Date: Tue, 29 Apr 2014 11:31:06 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1398687969-16853-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1398687969-16853-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] kernel/mem/lib/mem.c: make tests continue to
 run even though KSM is not enabled
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Hi!

On 04/28/2014 04:26 PM, Xiaoguang Wang wrote:
> When kernel KSM configuration is not enabled, we make testcases continue to run
> instead of returning TCONF, e.g. oom01. And if KSM configuration is not enabled, in
> the original code, "tst_brkm(TCONF, NULL, ...)" will be called, in this case, we
> will forget to execute the restore operations defined in cleanup, which will forget
> to restore the /proc/sys/vm/overcommit_memory to 0, and this will impact other test
> cases in LTP, for example, fork14 in RHEL5 will succeed unexpectedly.
>
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>   testcases/kernel/mem/lib/mem.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 188a5ef..b975c62 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -146,11 +146,13 @@ void testoom(int mempolicy, int lite)
>   	tst_resm(TINFO, "start OOM testing for mlocked pages.");
>   	oom(MLOCK, lite);
>
> -	if (access(PATH_KSM, F_OK) == -1)
> -		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> -
> -	tst_resm(TINFO, "start OOM testing for KSM pages.");
> -	oom(KSM, lite);
> +	if (access(PATH_KSM, F_OK) == -1) {
> +		tst_resm(TINFO, "KSM configuration is not enabled, "
> +			 "skip OOM test for KSM pags");
> +	} else {
> +		tst_resm(TINFO, "start OOM testing for KSM pages.");
> +		oom(KSM, lite);
> +	}
>   }
>
>   /* KSM */
>

Took kernel 3.14.0, compiled without CONFIG_KSM set and booted with 
'numa=fake=4' (I have a 4-core Intel desktop). All oom0* tests passed.

Acked-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
