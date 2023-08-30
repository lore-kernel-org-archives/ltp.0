Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB54C83F01
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 07:58:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D2FF3CBFE6
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 09:58:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1F543CB700
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 09:58:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 969F9601BCA
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 09:58:18 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 655DD1F461;
 Wed, 30 Aug 2023 07:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693382297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8rbOucr817qNFjDuJtQd6uTjauyHyhqDOMtRGV8cEI=;
 b=dOEEuPmP1fqWY/1whdYwpakk3OVmzc6Xm0J9qCmTkJ38iQEhkuG1mFMUkoqFJBy33abi7m
 ZDcq73pzVONvHjOsV50TfIpl/NSRtOn/DKw3pJ8n2fr7bWw0Sqaf/BKGkDc3npjIgklw8M
 6ZvnUVDyMWgDaxGAEBPfpPwU/WkPfHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693382297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8rbOucr817qNFjDuJtQd6uTjauyHyhqDOMtRGV8cEI=;
 b=nLoxL5351P9u34j6rI3WUPT8Ac/TD5TFMmU4q/dPtoIS5ba7pJAL/NUZKe/2l96k+6xiwJ
 jadPoBgk4MD5kHDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6B6292C142;
 Wed, 30 Aug 2023 07:58:16 +0000 (UTC)
References: <20230830064250.31904-1-zhanghongchen@loongson.cn>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Date: Wed, 30 Aug 2023 08:45:12 +0100
Organization: Linux Private Site
In-reply-to: <20230830064250.31904-1-zhanghongchen@loongson.cn>
Message-ID: <87r0nlhsh7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cpuset_memory_spread: set lowerlimit according
 to pagesize
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Hongchen Zhang <zhanghongchen@loongson.cn> writes:

> When I test the cpuset_memory_spread case,this case FAIL too often.
> After dig into the code, I find out that the fowlloing things trigger
> the FAIL:
> 1) random events,the probability is very small and can be ignored
> 2) get_meminfo which before send signal to test_pid
> 3) account_memsinfo before result_check
>
> About 2) and 3), we can increase the value of lowerlimit to keep
> the result as SUCCESS.
>
> After discussing with Richard, we all agree to use the following
> formula to calculate the lowerlimit:
> lowerlimit(kb) = pagesize(byte) * 512 / 1024
>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  .../cpuset_memory_spread_testset.sh                    | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git
> a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> index e2767ef05..f7230a4ea 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
> @@ -38,7 +38,15 @@ nr_mems=$N_NODES
>  # on which it is running. The other nodes' slab space has littler change.(less
>  # than 1000 kb).
>  upperlimit=10000
> -lowerlimit=2000
> +
> +# set lowerlimit according to pagesize
> +# pagesize(bytes)  | lowerlimit(kb)
> +# ------------------------------------
> +#  4096            | 2048
> +#  16384           | 8192
> +
> +PAGE_SIZE=`tst_getconf PAGESIZE`
> +lowerlimit=$((PAGE_SIZE * 512 / 1024))
>  
>  cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
>  mems_all="$(seq -s, 0 $((nr_mems-1)))"
>
> base-commit: 020f3985a5ca86c8bbece27eef8fb0315a10463e

If we don't set the upperlimit what happens if we have 64Kb pages and
the lowerlimit > upperlimit?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
