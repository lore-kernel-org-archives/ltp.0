Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB025C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:15:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F95161242
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 09:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F95161242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB98C3C8FA5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 11:15:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90E3B3C8F57
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:15:11 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1ABA1001286
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 11:15:08 +0200 (CEST)
X-QQ-mid: bizesmtp33t1632388501t0o1q0db
Received: from [10.4.23.19] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 17:15:00 +0800 (CST)
X-QQ-SSF: 0140000000000040C000000B0000000
X-QQ-FEAT: g1CXZ3gRPwwLQMjuvi6Ak/tUz7p+Emr2HNsY20pu1x3AZQSKVRowM1SfmyJ8g
 +oDaCSQ4YiPb3KzEJzGLed2jm4Gc3cAv4lR0mtZEDKAKxIDJdocG9bW8hVZE4wX+9vZWxSA
 IROz5wFkZdq5yF2rAchQFrSInpO9b9cfBuuXf6PelguPqPQbW3DXQf6+v3dW+ocLp/X1Jcf
 9e/cwwox6riyrANTZzTPijRz0diGXG6Fdgh9xCVjJkwRD7y6puomhQLnXOEUMQs8dQ4KBct
 KpubE60oO486YTr+ePPWGfm2UAhnewTL0Wj+oAFHvH055ty6IPRJ/rfDGljxGZb9y0I9wQo
 rC5QAOeHyIrIKbD29ggelhrvfdtrlntQKxdGIbp
X-QQ-GoodBg: 2
To: Petr Vorel <pvorel@suse.cz>
References: <20210902010814.32448-1-zhanglianjie@uniontech.com>
 <YTBo6ZS2GKWb8edF@pevik> <c0a5fa20-dd40-161c-352f-407b8a2d6b08@uniontech.com>
 <YUxDQBYdEXdf5RPf@pevik>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <5f3c73e2-3361-9b9a-5359-79afe87a11be@uniontech.com>+EDA5AA9D33C97A9F
Date: Thu, 23 Sep 2021 17:14:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YUxDQBYdEXdf5RPf@pevik>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] syscalls/clone01: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Oh thank you. ^_^

On 2021-09-23 17:05, Petr Vorel wrote:
> Hi zhanglianjie,
> 
>> Hi,
>> Please ignore other patches about clone testcases and just focus on
>> v3.thanks.
> 
> FYI you can register on our patchwork instance [1] with email you use for
> sending patches and update status of your patches (e.g. set patches to be
> ignored to "Superseded" or "Changes Requested").
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/register/
> 

-- 
Regards,
Zhang Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
