Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BEAC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:20:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3057460F48
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3057460F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DEA43C8781
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:20:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4223C1CC5
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 07:20:11 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEF9E60090E
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 07:20:10 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.255.100])
 by mail.jv-coder.de (Postfix) with ESMTPSA id C2FDD9FBF7;
 Mon, 20 Sep 2021 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1632115209; bh=OHdH6PO3OmyGQrfHeDZ9JzG210AqWJTOVGtAzij4HD8=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=T0+SB/U/5E5NC6bEEI7iVirxf0sasq9mkmElkYajwSWcA9wWaY5Bb+XBpHRFtWyhS
 ZwqGSKWBhyzSzHsmbx0AY5sU4sdGEKWSoK2dzp01McS8SGSxIvuqGrGVyxQQBcP6JU
 djy6lh3JdrE83pU9AALJnEtj1YPK1xSBRNwAj5/c=
To: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
References: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
 <20210914083444.23848-1-rpalethorpe@suse.com>
From: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <940b657a-ae79-a9f3-c2aa-30d441ad1e4e@jv-coder.de>
Date: Mon, 20 Sep 2021 07:20:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914083444.23848-1-rpalethorpe@suse.com>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_subgroup_charge: Remove limiting of parent
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
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi

On 9/14/2021 10:34 AM, Richard Palethorpe via ltp wrote:
> It is not important how much memory is assigned to the parent
> group. The stated purpose of the test is to check no memory is
> assigned to the child group.
I still don't know why the test even wants to limit anything, when it is 
just checking what is charged.
So I would still vote for completely removing the limits and simplifying 
to just one test case.

But removing one limitation for now is a step in the right direction, so 
I will not argue anymore :)

>
> Also add the usage stats for the memcg_process because it appears
> the test will fail because the starting memory counter already
> includes some buffer/cache on linux-next. I'm not sure this
> is exactly what happens, but displaying the stats might help.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>   .../controllers/memcg/functional/memcg_lib.sh    |  2 +-
>   .../memcg/functional/memcg_subgroup_charge.sh    | 16 +++++-----------
>   2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index ac9ad8268..1b76b6597 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -240,7 +240,7 @@ signal_memcg_process()
>   
>   		loops=$((loops - 1))
>   		if [ $loops -le 0 ]; then
> -			tst_brk TBROK "timed out on memory.usage_in_bytes"
> +			tst_brk TBROK "timed out on memory.usage_in_bytes" $usage $usage_start $size
>   		fi
>   	done
>   }
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> index 3fa016102..cda624923 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
> @@ -18,22 +18,16 @@ TST_CNT=3
>   MEM_TO_ALLOC=$((PAGESIZES * 2))
>   
>   # Test the memory charge won't move to subgroup
> -# $1 - memory.limit_in_bytes in parent group
> -# $2 - memory.limit_in_bytes in sub group
> +# $1 - memory.limit_in_bytes in sub group
>   test_subgroup()
>   {
> -	local limit_parent=$1
> -	local limit_subgroup=$2
> +	local limit_subgroup=$1
>   
> -	if [ $limit_parent -ne 0 ]; then
> -		limit_parent=$(memcg_adjust_limit_for_kmem $limit_parent)
> -	fi
>   	if [ $limit_subgroup -ne 0 ]; then
>   		limit_subgroup=$(memcg_adjust_limit_for_kmem $limit_subgroup)
>   	fi
>   
>   	ROD mkdir subgroup
> -	EXPECT_PASS echo $limit_parent \> memory.limit_in_bytes
>   	EXPECT_PASS echo $limit_subgroup \> subgroup/memory.limit_in_bytes
>   
>   	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
> @@ -60,17 +54,17 @@ test_subgroup()
>   test1()
>   {
>   	tst_res TINFO "Test that group and subgroup have no relationship"
> -	test_subgroup $MEM_TO_ALLOC $((2 * MEM_TO_ALLOC))
> +	test_subgroup $((2 * MEM_TO_ALLOC))
>   }
>   
>   test2()
>   {
> -	test_subgroup $MEM_TO_ALLOC $MEM_TO_ALLOC
> +	test_subgroup $MEM_TO_ALLOC
>   }
>   
>   test3()
>   {
> -	test_subgroup $MEM_TO_ALLOC 0
> +	test_subgroup 0
>   }
>   
>   tst_run

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
