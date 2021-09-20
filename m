Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4FDC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:32:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0332B61019
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0332B61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 095BC3C864C
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:32:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55FDF3C1B0A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 07:32:23 +0200 (CEST)
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id A86CA200990
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 07:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=Eodk4
 mW1IncHtkThSxcuW2e9wUMZY2OfJZFnG1BIlyE=; b=FP9M6x/HVv/+fbKDoUuHu
 z6higx3Ww158oPAcetzsYbClyn5scazzeDd/r8XuhnKXO+a0yJScFUzIa9EyL8Dx
 L216AfTvIhlBaTtCdmFxlQz8i0PHY/WLoFn95oZz27cFArSrPm9OukvbQP/dKP9w
 tyZ0Piz2EFN6kygsAS2suM=
Received: from [192.168.0.11] (unknown [183.210.46.254])
 by smtp12 (Coremail) with SMTP id EMCowAB3h7HcHEhhxRJMBg--.1093S2;
 Mon, 20 Sep 2021 13:32:14 +0800 (CST)
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210920033705.20544-1-qi.fuli@fujitsu.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <3b698f71-b8d8-2ef6-3a83-d978f659c4d1@163.com>
Date: Mon, 20 Sep 2021 13:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210920033705.20544-1-qi.fuli@fujitsu.com>
Content-Language: en-US
X-CM-TRANSID: EMCowAB3h7HcHEhhxRJMBg--.1093S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4kZF4rGF4DKw1xAFW5Jrb_yoWftwcEvF
 yUJFy5Jr4UAa9xJFnxGrsYqrs8KrWkJFs5JrnxG395JrsF9r17CFnIyr45ZFn5WFWrWF93
 Grs8KrW5J3sxAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0hYFtUUUUU==
X-Originating-IP: [183.210.46.254]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiTB4UXlSIpCCgFAAAs0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/5] Convert syscalls/dup2/dup2{01...05} to new
 API
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Qi,

I have pushed the patch set with two minor changes:

1) Fix some warnings from checkpatch.pl.

2) Fix the description in dup204.

Best Regards,

Xiao Yang

On 9/20/21 11:37 AM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Convert syscalls/dup2/dup2{01...05} to new API
>
> QI Fuli (5):
>    syscalls/dup2/dup201: Convert to new API
>    syscalls/dup2/dup202: Convert to new API
>    syscalls/dup2/dup203: Convert to new API
>    syscalls/dup2/dup204: Convert to new API
>    syscalls/dup2/dup205: Convert to new API
>
>   testcases/kernel/syscalls/dup2/dup201.c | 174 +++-------------
>   testcases/kernel/syscalls/dup2/dup202.c | 196 ++++++------------
>   testcases/kernel/syscalls/dup2/dup203.c | 265 ++++++++----------------
>   testcases/kernel/syscalls/dup2/dup204.c | 147 ++++---------
>   testcases/kernel/syscalls/dup2/dup205.c | 178 ++++++----------
>   5 files changed, 276 insertions(+), 684 deletions(-)
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
