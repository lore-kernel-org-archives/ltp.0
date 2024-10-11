Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ACDD2447F
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728629795; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=REzXzfb8uOoAhqdda6HYhMbRhtMNnMx8lCuEmMvZv3E=;
 b=rmQCFbEKqp0F3Qmc1cW/z94qOfDbmqQhZhhTdiX3MfrGe+rTQpyXl26qmpAKwERrLklDz
 eGPqpUIWccPmmFy2U0ti6f+qzhiYq4XqfgTLnqEzMIufkKDWBGhMAMk7YZRzA7s4eT+LHcS
 0pjyLwYUeO1JFHl24n03yrKLGRSrVUE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5670C3C5581
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 08:56:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5773A3C04EF
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 08:56:13 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEA3F100FB31
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 08:56:12 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c918c067a1so2026469a12.3
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 23:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728629772; x=1729234572; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5FMUC+AYUh0VNe+FD7FCq8YkOolb4+mR/Rinl3Sd5kQ=;
 b=gbCA+uYXE3GC415Sh8YpWuGhAnhcQ3cxtCas5TszKUfgvrDjEA0oDRoi4YOCbRq+65
 QF8F1dMsF+dcdW2hy/wMJbUbP/WFB87Z7ZVJoKaMgVTADTp46LoFuNYGT9jK1axmowqh
 yxj2gtr1nG6bp7b1cBvWAzVz6SlruNBe7tw4akZgxyTIb7ESZWzavlRyQFWYiQoTi3vY
 h51x6VQWXBMosO37T2SB2+zFKWdiIzZGACHOR5Dg+YFdDBiJj9WdnNMCEEnfPS1f+DpI
 pqYKrCwCYKLcTsfSWzBehGTzry+gQWVR+caPoydwxv/hnERjhTz36ntpuSZGO8hEnN/c
 VUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728629772; x=1729234572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FMUC+AYUh0VNe+FD7FCq8YkOolb4+mR/Rinl3Sd5kQ=;
 b=airPqGUee9idAS2ZQ6YsqHcsCPp3EEvyboqkSohOxGESTt6LaGS2O1MS1vSo5sVZZz
 2GxA2smvP7epsjvHXjcB2r7A2SKVHvLOqo4ZaE1UrkWQN1QyS0X6JJbDtEsbtNHIYykf
 qb/i2wPxVwZyWBgFCwkyYYYWt+lTsTXhdCLDyLE1r8yPQrFv5B+B+Km0zfBvhqrU3Fcy
 rycteCWoQ8zP2SfmD3GKySZ9AZzbMRJgkrX8WvCz/yGME1EVgOZW2FVc2LSoN33TVmdb
 tbAl2ixGo+qMNC1F2c1JmPpM8XHjfxLXpIUNsnnVBfMHs+cUEaoKAp3slhbWvDF6VXm9
 4e5w==
X-Gm-Message-State: AOJu0YxxZNg98QT5uekUuULPtBpIuXTWo4TCmPe2VeKrneukH+SmPVR4
 ve0ZPTQERSqd/hYdjLdDPA/mbvsr/+heTCNnPbJpXI4oG+wRLn5LFsbypguOl6Y6XUWfUCouKjK
 7kt0=
X-Google-Smtp-Source: AGHT+IEKCFcEXcuNuNvZkHQIxe+fseJLXquwaNNGnVenpCC+JSpOrb6DHVCZpUxSXRcVzZ65ruwu5A==
X-Received: by 2002:a17:907:9620:b0:a99:4b5a:a59 with SMTP id
 a640c23a62f3a-a99b937b1b0mr113313866b.18.1728629772151; 
 Thu, 10 Oct 2024 23:56:12 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80c0737sm176469066b.136.2024.10.10.23.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 23:56:11 -0700 (PDT)
Message-ID: <09db9e97-da63-43b2-835d-daab733a3e4a@suse.com>
Date: Fri, 11 Oct 2024 08:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
 <20241009-ioctl_ficlone01_fix-v5-1-943238be9923@suse.com>
 <ZwfUcY7ShiepjJ7J@yuki.lan> <ZwfV_f89AbQpQX-l@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwfV_f89AbQpQX-l@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Filter mkfs version in tst_fs
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 10/10/24 15:26, Cyril Hrubis wrote:
> Hi!
>>> @@ -1832,7 +1839,7 @@ static int run_tcases_per_fs(void)
>>>   		if (!fs)
>>>   			continue;
>>>   
>>> -		run_tcase_on_fs(fs, filesystems[i]);
>>> +		ret = run_tcase_on_fs(fs, filesystems[i]);
>> I guess that I didn't explain it clearly enough, I would like to have a
>> patch merged that only fixes this (ideally with your reviewed-by) rather
>> than fixing this in a patchset that adds new functionality. I've send
>> the patch here quite a while ago:
>>
>> http://patchwork.ozlabs.org/project/ltp/patch/20241001151918.12097-1-chrubis@suse.cz/
> And other than this the rest of the patchset is fine.
>
If it's ok for you, I will push all patches with your patch included and 
Reviewed-by tag in the last one.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
