Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527ABC3DA6F
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 09:07:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 576F63CC3AC
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 11:07:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40CF33C6D29
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:06:57 +0200 (CEST)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D615600CEE
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 11:06:55 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="129493899"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; d="scan'208";a="129493899"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 18:06:53 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 312F8CD7E0
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:06:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 638A8D946E
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 18:06:49 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E54CC20093094;
 Fri, 25 Aug 2023 18:06:48 +0900 (JST)
Message-ID: <68d82f6f-2c42-0c2d-3d8a-618d387675dc@fujitsu.com>
Date: Fri, 25 Aug 2023 17:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <1692875480-22494-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27834.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27834.006
X-TMASE-Result: 10--13.700100-10.000000
X-TMASE-MatchedRID: hwtUKlde9zGPvrMjLFD6eJVRzPxemJL0ZR+OFNkbtdpWjSWvFszxq4u3
 renu5Y0wbJfPbBoXyMOxUiJMMML0+y/7QU2czuUNA9lly13c/gFS3D9gYw52fxe1yJq6HIhHiER
 aZd+PxAHi8zVgXoAltkWL4rBlm20vt7DW3B48kkHYoM82yqmFMvoLR4+zsDTtviI7BBDiM2L1Zh
 hinEXF3LTs57gAuJyMlSQSahD4pqgcPb5SIcCaFA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] hugeshmctl01: Mark struct tcase as static
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

The Subject seems not exact. You marked struct struct tcase and several 
functions as static.

Other than that, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/8/24 19:11, Yang Xu wrote:
> To follow LTP conventions.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> index 11cd69050..8cacde7cd 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> @@ -53,7 +53,7 @@ static void func_set(void);
>   static void func_rmid(void);
>   static void *set_shmat(void);
>   
> -struct tcase {
> +static struct tcase {
>   	int cmd;
>   	void (*func_test) (void);
>   	void (*func_setup) (void);
> @@ -90,7 +90,7 @@ static void test_hugeshmctl(unsigned int i)
>   /*
>    * set_shmat() - Attach the shared memory and return the pointer.
>    */
> -void *set_shmat(void)
> +static void *set_shmat(void)
>   {
>   	void *rval;
>   
> @@ -279,7 +279,7 @@ static void func_rmid(void)
>   	shm_id_1 = -1;
>   }
>   
> -void setup(void)
> +static void setup(void)
>   {
>   	long hpage_size;
>   
> @@ -293,7 +293,7 @@ void setup(void)
>   	shmkey = getipckey();
>   }
>   
> -void cleanup(void)
> +static void cleanup(void)
>   {
>   	rm_shm(shm_id_1);
>   }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
