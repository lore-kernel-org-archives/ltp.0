Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C33FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777536489; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CWSRYcv7XrLsbYv2eze2kCltBFRDqu1lZuQmuVzauqw=;
 b=Jptuu6WGAc6+2ZpWY/ypIpFX3PiImAcB1zq4TGb1m46VjvqLFJrVpeI1hjbdmootR8x3i
 QAsg9umCLHM+nPURY3cCy1IhTdAB0/dEm3Bq6O9TMbbf5poXl3Spmm3OEQgK6DVn/N2e+Pf
 +V5AXkWU6KgZ6GO+v9M1ft+NnBo/XP0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B8C13E2897
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:08:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C19183C4EAA
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:07:45 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D109100092F
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:07:44 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483487335c2so6720655e9.2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777536464; x=1778141264; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlnAfDgOP2eWlzCfyvgtE7w2salMELWdla3nx/uDahQ=;
 b=ce1AM2KusU6JLyXyroVtWBtDeJtwm6/a5Sw2AKXF3RDMCgbL4TMAGK1EgFRFlOIOHz
 EZUCAgtsTXAijNIgIKy+kTyleEwM8Q1egkCulTBXI7FZTlwTX+kPT9+sluNRKeVFKqOC
 c8QbxoKc43BBcP8IYOCXaOFsNso6/2i7EDIA4RP7tRMpo/Gj8BmjuzmM28RO/6kzXfgq
 f9oQxCT4fzlkET8ZnPCzC9pmDS333bJNOK4bct+5L7LVc4P81xjsAQ8ONGnosERFf9A2
 jUVhIFR7lr5sjIxUjitU2DW0P2fuILw8RrekZOlfb9lxEfkNmEPulFmV8upC9pYWo+zV
 ayKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536464; x=1778141264;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QlnAfDgOP2eWlzCfyvgtE7w2salMELWdla3nx/uDahQ=;
 b=Q+8f9O24C+T6ni5lN6t3dbsIzvDU3kmP5qRb2fBDeUR/mBgPa/JPEqUNiOx94Mj5Ce
 ZwpeWOc1d+4QLh+fSQpuIzju/OopGeBA1//ch1CT8ND7sFt+ZOZPbsUBH6hpnjfqsZ+w
 ra9rexDFiXjpd1wzvDbDqvp0fTfws/31sXLwSgEq7louD+t5g3BeBNE97qIAu/X9CQY5
 vcVDz6Ww6a4Yq25UvdZ4DkR3fa+llWi22vbxe385Lz6BqBPuNF09NTNN8vQMrLV2a0BF
 bC5p6kcVaWbqYTbsOhsnvYDCLc00rksO5hA7vVvCTrUwpW77to5ECkcalUrs2rmAAjJ6
 31+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OqMCJGKi3u+u4HdluHlUTcc4EYFfZc1yhJEO1qRWgZJvlOi2sPqGa3uE0XbSY2NTjnYg=@lists.linux.it
X-Gm-Message-State: AOJu0Yx7RFH8p2D8I81AT9krwjtlTeRrzNnqs4AFBJT0Jr9ye3OjutDs
 LoW0QisDK9alxeYhAcznO8M5c/AuyAGrDsg+bFi8SEkvKvP8GKDK+SggKj6UdsI5qUE=
X-Gm-Gg: AeBDieua5222WdK1kIsHo4QBUjYPw7lmyd+4khnU7vGS/Vxd4znelh2U6xguDwIvtRO
 Ohwrm6o1CS4VCPl+S3YgXuOS5O7FLvo4283Lm2yfDNeMtAeE7Rm8sdFU9BJF7B8WwB25RQiJioJ
 hIWvTRITnKbFaFFv4OfLYymejapXtvtNT07yNevJK5DVeK6yZThnSfgtv9OZdwoHn13sOjlxxrA
 1lT5HykUQCAuGGblWBBjKwOa37tN9SrcA4X+E5UvVF24YHp91re2o+jVFybM1X3LlHwrytBQAw3
 wGLREHL4mEsyjxO+AiszIqgCxTJzbFBi2zmVoyCl3qwAMWTeQw6+ucdkXd2wqwySE9RnXquL6+/
 oXuvxqUP11ucOcfF3D4KOOG6Fw7i32FzF+OX35zD/Yuugg45iz5ZmOtnKjxKgoqLwHn8OFz/jzQ
 rqB1A/5zRlAQ5Wr7LHq+wm1CQdOAUSSJnXiU2KI1kcverXqRTBSFqiPxUY63GbDSUHvFxT/MC8Q
 2JPPDfeUX9mz51puqc8M2z1phY=
X-Received: by 2002:a05:600c:638f:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48a845210a5mr29197845e9.19.1777536463593; 
 Thu, 30 Apr 2026 01:07:43 -0700 (PDT)
Received: from ?IPV6:2401:4900:88d6:a675:2691:5d4e:58a0:eb9b?
 ([2401:4900:88d6:a675:2691:5d4e:58a0:eb9b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c30571fsm37730315e9.19.2026.04.30.01.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 01:07:42 -0700 (PDT)
Message-ID: <601eef2c-5c90-4086-bc82-67a28dbba68f@suse.com>
Date: Thu, 30 Apr 2026 10:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>
References: <202602122354.412c5e65-lkp@intel.com> <aY7wZwHXH2zS_Sj-@yuki.lan>
 <20260214-ausformuliert-aufgearbeitet-7b45890e036a@brauner>
Content-Language: en-US
In-Reply-To: <20260214-ausformuliert-aufgearbeitet-7b45890e036a@brauner>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [mount] 4f5ba37ddc: ltp.fsmount02.fail
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kernel test robot <oliver.sang@intel.com>,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 2/14/26 1:24 PM, Christian Brauner via ltp wrote:
> On Fri, Feb 13, 2026 at 10:35:35AM +0100, Cyril Hrubis wrote:
>> Hi!
>>> commit: 4f5ba37ddcdf5eaac2408178050183345d56b2d3 ("mount: add FSMOUNT_NAMESPACE")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> The relevant part of the log is:
>>
>> fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)
>>
>> This is another case where new flag was added so the invalid flag value
>> is not invalid anymore. The test needs to be adjusted if/once the patch
>> hits mainline.
FYI, 
https://lore.kernel.org/ltp/20260430063326.53566-1-avinesh.kumar@suse.com/T/#u 

Please review if this is correct solution.

Regards,
Avinesh

> Ah, very good to know. Adding Mark so he's aware that this is an
> expected failure.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
