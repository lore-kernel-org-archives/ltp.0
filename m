Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D80C433FE
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 00:28:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E803CB28A
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 02:28:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51793CA708
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 02:28:14 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AAC2A20004F
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 02:28:13 +0200 (CEST)
Received: by mail-pg1-x52d.google.com with SMTP id 128so3962166pga.1
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3FKOMGBMoCWBCJ9GUo4BVtc/aLPNsB2ZH5Zd7HWbDw=;
 b=ptj2oSmG10v71qOA2UhVszRQn7jsqqm7DZ8c+GB6EXfBPpfOyd7d2k4+LepafeWcCl
 uckCFOE4HvQaXBrk0wulbsZ9UrDNPoI1S76SSMZTmB6xVidMGaFH5dh9yRmY9sYTKnN4
 bBwiFXzTn/mn/qJVxZPyo1VHN+p8kOp0HZfUKAp0MMxIv49a/dSE/LF/85NMrouAX+OP
 JuiKqkDRA1ooOZSFKk6pYNCO6jEjvQ/0ge+3n2p4tsqc/NKCtkm2cO2JANldLGHMzp0W
 e+TPdgd2Yt8W6raanPQozsICHyNea+4CvnF7uZ64We4kUaYUugFaN3NxVaKp2znIUo28
 FeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3FKOMGBMoCWBCJ9GUo4BVtc/aLPNsB2ZH5Zd7HWbDw=;
 b=C7UXoNITV9uKT/mqOMJJmi4A37Vs5iL2MUL6GKp5ioCMw2eHA6RUbgwqlH0X873UjU
 qk9161D6QH4hi+/wwwz90VDj4/oP0+Dv4JAUJA/oFcUJkDwfqHLBT+qX/01FCLf8rK4y
 C+ZqXr0vk/INEFHQQNDWqu8Whoez0on3vSyBAhIZSeK56xknuDUsnscD3yHZBk4LCTGj
 TtD8dLy9s7kSKY0k1pB7bEdqghTRXSaU4S5y6qUrt8/5JVEfxGZsva9KdWwHkmhLksXf
 sSXE42rJWSROnuk+ZCdB8aOj8KOWxjkN02ZJY74D8j81WSEVa0zCq4Exv488BDL4KkvV
 2xjw==
X-Gm-Message-State: ACrzQf0SPZyzcatQ2+FiFpTxgQojIMdM1gkzI4r9GqMpReJUezNjxjI+
 7x89PnL4QlYisCzJz2u4ylqOcw==
X-Google-Smtp-Source: AMsMyM6x37e7BPv42TwNjVl2bKxbwlzFi4Y93YAGYtypsGJTyrWVuWCv6w/pzQINvyBMZUteUDl3dw==
X-Received: by 2002:a05:6a00:23c6:b0:563:a1e9:eab8 with SMTP id
 g6-20020a056a0023c600b00563a1e9eab8mr22285096pfc.16.1666398492032; 
 Fri, 21 Oct 2022 17:28:12 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a63f757000000b00460c67afbd5sm13883476pgk.7.2022.10.21.17.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Oct 2022 17:28:11 -0700 (PDT)
Message-ID: <82b10e4d-292f-51c2-da70-0c2ad7722a8f@daynix.com>
Date: Sat, 22 Oct 2022 09:28:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-2-pvorel@suse.cz>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20221021115333.13725-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Makefile: set LC_ALL and LANG to C
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

On 2022/10/21 20:53, Petr Vorel wrote:
> * have reproducible builds (no locale dependencies)
> * English only output - easier to debug problem
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: if we want to have only reproducible build, but keep localized
> messages, we could use kernel approach:
> unexport LC_ALL
> LC_COLLATE=C
> LC_NUMERIC=C
> export LC_COLLATE LC_NUMERIC
> 
> They deliberately kept LC_CTYPE to have localized messages.
> 
> See also
> c051346b7db2 ("Makefile: set LC_CTYPE, LC_COLLATE, LC_NUMERIC to C")
> 07105202bdeb ("Makefile: do not override LC_CTYPE")
> 
>   Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index d4399bae6..ea11ac7f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,6 +21,10 @@
>   # Ngie Cooper, July 2009
>   #
>   
> +# Avoid funny character set dependencies
> +export LANG=C

Hi,

Setting LANG should not be necessary as long as LC_ALL is set. That is 
what my patch "tst_test.sh: Normalize the locale" does.

Regards,
Akihiko Odaki

> +export LC_ALL=C
> +
>   top_srcdir		?= $(CURDIR)
>   
>   include $(top_srcdir)/include/mk/env_pre.mk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
