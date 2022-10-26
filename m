Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C95C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 19:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189BE3CA7AF
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 21:23:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 602D83C5FB7
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 21:23:02 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 111241400517
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 21:23:02 +0200 (CEST)
Received: by mail-pg1-x531.google.com with SMTP id q1so15859137pgl.11
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bJch6r+pORxlhcQTq2ZH0rxYNq1tjSng28hhL6CNXpU=;
 b=0eulWncclSMznsr/qxJLAIiogTgvlICLINYsLkk60xPvPoKw7skvS4AROEZmepmEDR
 iEMCGAQbBB1aB7juD+CkpCEuL2XEDqzVwP3iAswZKO+Y2lLIhrU2C+XjNW4yHDB5lXqi
 wTIoG2OSSYAt+YXc45+jyx+A4baSpZKJ/gtL1jXiF0yXbNNQ5JwL3OqldQTA25rjJ7DG
 8w2Dj7EcYcQAo8zHNtTJBQfLiboa/m3sqkwR9QoPT4jJRCwEmZ32CWlqZoojgB05CBLr
 56nIXLBalL1UeltCpI0z9se5Fui2pIWaGDm8plRxcE6ow25wQj+RFd2lUSmIuCLYr/Pr
 y6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJch6r+pORxlhcQTq2ZH0rxYNq1tjSng28hhL6CNXpU=;
 b=Snsw8vvq4y0zcYg2M2u83I5b6XgljSIhyWrPXrZRVtFPZEgxymGeOWEdK2DvGByAnq
 aNFq7GkqWXYrC/PhL/0d7QlydlbgnORFQJMZpvOxZGmUCX6YC5N74ASDCOVzQ+WE6dLq
 OVmZeUKpZqeG2jw/1z2Fw7fcr4Qgv8PPL2tQXZZlgQlboeVhpwg1wvLOSVBclx45WkW7
 t/uZGE2wIpje886+zD1s8MVMKHbs5jxcCv7YgOSmUwVdwB3tLpL6azlxWBTZYUTCrvXz
 DL1TOq1E1RXX3LXssuKIyK6htSRcZWG3mQblAmT2Bp0kRvmA6vE1v9Ezh5Jh67aXaRmU
 2C+w==
X-Gm-Message-State: ACrzQf3OcgRH2K1LuxvtlgvM5EcdGxKs8Pobx4OfLedYXFEstmgMr+F4
 ppjm9ej7HKV/hW85xnunPufMKQ==
X-Google-Smtp-Source: AMsMyM7xOmPGxjfUMixhyAg8XVFDc8C8DTrBc8A4IN+d4ehdH2lk3n0f2MX5JFFviGVzpWdOZdjcew==
X-Received: by 2002:a05:6a00:1993:b0:56c:7b8:ea37 with SMTP id
 d19-20020a056a00199300b0056c07b8ea37mr12908632pfl.20.1666812180263; 
 Wed, 26 Oct 2022 12:23:00 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a170903231000b0018099c9618esm3259493plh.231.2022.10.26.12.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Oct 2022 12:22:59 -0700 (PDT)
Message-ID: <5be433f9-a459-883d-53cf-c702f2b8ae5d@daynix.com>
Date: Thu, 27 Oct 2022 04:22:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
 <Y1GWOPpb+Z8hwhQd@pevik> <Y1I6u1a7RAS1wmZL@pevik>
 <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com> <Y1Ze470vch74uGNg@pevik>
 <Y1Zmk9kheWANsZ9Z@pevik>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y1Zmk9kheWANsZ9Z@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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

Hi,

Thanks for suggestions, improvements, and merging.

This test assumes FTP is set up and running and that defeats the purpose 
of netns. It is certainly possible to say the FTP test functionality is 
covered with testcases/network/stress/ftp and this test can be removed, 
but for now, the fixes allows me to execute net.tcp_cmds tests without 
explicitly excluding this.

Regards,
Akihiko Odaki

On 2022/10/24 19:18, Petr Vorel wrote:
> Hi Akihiko,
> 
> ...
>>> I just modified this test because it is annoying to set up rsh just to fix
>>> this test so I would rather not put more effort for further improvement.
>> Understand, ack. Thanks for your work!
> 
>>> Personally I don't object to remove this test either.
>> The fastest solution is to merge your fixed version.
>> But there should be even more modifications:
>> RHOST is obsolete, instead $(tst_ipaddr rhost) should be used.
> 
>> Therefore we should decide if this smoke test (and other FTP tests in LTP) is
>> worth effort. If yes, I should force myself to create ftp_lib.sh and migrate
>> everything to work similar way as ftp-upload-stress.sh.
> 
> Merged as it's some improvement. I'm not sure if I invest time to FTP in the
> future, maybe we should really delete it.
> 
> The only significant change I did was to force running over SSH:
> with RHOST="${RHOST:-localhost}"
> 
> In my case only first half of the tests is working (suppose just wrong setup),
> but on netns everything si broken and you also tested it on SSH I dared to do
> this change. I documented the proper fix above in case anybody cares.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
