Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2E9C48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708358273; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=IF+RsenXJEDpse0hCb8eVHA8CCfVJj9NFjUwIY7woJw=;
 b=nePAo1CYaiteADC34q7uQ/nYQ1nCfqL2/p7Sn7eHh422miLCVqa4SSHJ/gL1S9V2B4xOf
 BRmPeyyNyuF60n8u+UxXFTQ+TpLAb2ADRvMZlnSWy/50hT9N5Q3khRSllymJpHBvSsJ/bDO
 b4cCjbYacOm5L5k0YV3Mw2sxzfWJLWU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BDCC3D1385
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:57:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7CD3CDB95
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:57:32 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 657DC601B0C
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:57:31 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41262ec677fso9722195e9.1
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708358251; x=1708963051; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3Wfyd/dZfkl1bXSuBTuQhXA6qrG+vT6qnZMmDQGQ5Q=;
 b=TcTdXsKKK5gKmCNzFabtRA2UDhZr0fg4MtzGzyQnOh2eX+xwVJa97dYnSHxLBe+pcz
 kqW91k0tVRQgCnBQUH7BkoYi0/1TmkzVCXN1ItapFveTk70x26dROKNwCSj4+HnSiWJ8
 TfNIANZbIn3Jbcm97SqEL0HfaYguQWPETVet+/pmkfoIzOFR/KBrNYKmefC4wPehJZQc
 vUM48+qBmmzQ23NEXDv6I/EJNiXMYgEsQWiSoWCf9Lv3DoA70jNLE024/W5C40fipgAz
 1ZwOiS3HApwsP1EnPAcQLXhmw2xa4JP+kX+WxhL+82EEG0gMWQ7plAphloZhbYrYCVS6
 hKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708358251; x=1708963051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3Wfyd/dZfkl1bXSuBTuQhXA6qrG+vT6qnZMmDQGQ5Q=;
 b=EMthL4iVc+tiGiLYRhCWXj/1NI+Y0R9dfiKn5sJjQxXOW570w9TIrrJY/TYA9syrQU
 /BkeAhgYwO1LRWLhRP3PlRriVFkJCcy/vcTfvK8sdGMFFlLNcHsuutDNyy3JU3nmXl5L
 uWbmf9zw/SJY4l4QGib85mNSUVNt9LcRfRYB+B5Cpp7VhRfpx7aJtipvsDz5B1G7K92l
 B0B4MFdHM9jxeX746S91TOtP1QTcK7EfvS0HUSLNmql3RNECyv7puC4sr9ay/6zjc3iw
 6n1vipvsJGysRznIjUf/1kCLzTg08SiGUehUDiW/qDcHSGlpRLoYXkjG4RUwamCZvKVj
 FghA==
X-Gm-Message-State: AOJu0YzFouGCgOPqyWa8AeWvJ/VEI5OIpdBFA1X6HKZsZArKSf+dKXbF
 5VdE/ZlrWo7m/qlTzVb9BaSsVpJ3ymAqYYL+39GT4uUDIt7PC6CeWw/VjrMbY7k=
X-Google-Smtp-Source: AGHT+IHeBadjjjcMkypvvBKWhTeF20HbNNGHW/B39QJ+iYv7QkjvR92y9U2Q4i2sRgjXpFrSPMBoPA==
X-Received: by 2002:a05:600c:4f53:b0:412:5f58:53a5 with SMTP id
 m19-20020a05600c4f5300b004125f5853a5mr3756042wmq.24.1708358250757; 
 Mon, 19 Feb 2024 07:57:30 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.52])
 by smtp.gmail.com with ESMTPSA id
 jv14-20020a05600c570e00b0040fe3147babsm11866221wmb.0.2024.02.19.07.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:57:30 -0800 (PST)
Message-ID: <5c4b0e5c-b193-45b7-8539-d695b02e4223@suse.com>
Date: Mon, 19 Feb 2024 16:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240119085622.10743-1-andrea.cervesato@suse.de>
 <Zb0jAC_SBgsmoUXK@yuki>
In-Reply-To: <Zb0jAC_SBgsmoUXK@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add rmdir04 test
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

Hi,
please don't consider this patch anymore.

On 2/2/24 18:14, Cyril Hrubis wrote:
> Hi!
>> +#include "tst_test.h"
>> +
>> +static void run(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +
>> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
>> +	TST_EXP_FAIL(rmdir(symname), ENOTDIR);
>> +
>> +	SAFE_UNLINK(symname);
>> +}
> Here as well, easily added to rmdir02 along with a few more different
> ENOTDIR cases.
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
