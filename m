Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C60D7497D
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 08:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730277640; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=2vFlni24RuysvHm+CVMB4ivnQnADqfr5bHzX88d/qfc=;
 b=qQJBeZ74OZs1iSpZOLB9gD8QhZsIZldauqSSEbDRseoD1LuTVoHjH/k6tDTEYkl4m33jj
 Cxtjwdl2UyzxDVhzGfLzUl69D7hX+RQB3f/srj+1a7XhQCZWjac9oD4xf7kCwgEEYvFEDlp
 Ewbstky5Z6ZWuAeX6cKVHn1vMAgNrak=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8353CAA26
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 09:40:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9033CA9FB
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:40:20 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 933F31BD7DD8
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:40:19 +0100 (CET)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e63c8678so6517564e87.0
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730277619; x=1730882419; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfJb0REzvHVM6TUBTpEp40mBCM1dVmQWjowDJo75ijM=;
 b=IVjtWRICfSoyA9z2VoUqO9PvsgojodlMMiinSqEGYpEN3wh3OEzaSJ5mMmJpc6VqZ2
 wHrrN2y3etoCaaLNJseo8xga/NCrPLFF90bzPx7bX6ZKa81mn5EaCccjgGM3bP7aLyCd
 THf2ToC0bMZOEN0Vh6AJdj+R40RTHPgcpEwHJ7yLbv9mLcrzMbWfnFdV0DeMLW5X2pQM
 fCrHkhnCeNlVaUEe8uaxZoLokqPDQmIEYunYENgzrk2OJnIxkrUZP0y6zjtZzDcR48Tg
 BPVMh8OD4zDm6k3dEL+4PFUSbABHr39RmbbltdCp88gxFIleevwltKZCEbX0M4ssGGus
 fLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730277619; x=1730882419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tfJb0REzvHVM6TUBTpEp40mBCM1dVmQWjowDJo75ijM=;
 b=n8+O3PvoyiU/YOBYhOjTHXyk2995/ex/4C9mkYgo+yWDI2xKAjMr5B/lsVrTiiPFHB
 QJl2fArxq5ux+i86q1Ck18zut2SXAEItJi+819lymN7fzwRhY+nxS+fkzhnbzwLHQdZF
 0B0VN3qSmWh/ARaxHPc/SOMQK/sr2i3PTWR3u1gmkJPLwNQUWteKcFPgsZgyx/1rxXt2
 QiGtjFUi2GX352lJKaMxLqCd3M2ckkgYME9O9OliVZB+D0M6qfVl5kDsmLNFA348qvvS
 bKgc6VkqEhjqErOCZaAVjucvM3WfLuLbASGB4g7NxcoZDREwXbfzfPJKpysNNvHTi6p1
 Qg8w==
X-Gm-Message-State: AOJu0Ywwhv3oCRZUSGGCQSVONQOiTczx0S9wxJnUF62lvPsG7OM7I0Yh
 oFQjPFZ7KMsICcxtUWTyVv9paHJvZtdb+cHoCzkIPRPTaJbrxfEDEt40X8qLD9I=
X-Google-Smtp-Source: AGHT+IGskIEY4yblDJP/alcqUIyUGIFkXc9aCMEK+fuUPZNCa5DF/TP38fAoT+bh1tdeqJsHrgG2dw==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-53b348cf0c0mr7075523e87.14.1730277618770; 
 Wed, 30 Oct 2024 01:40:18 -0700 (PDT)
Received: from [10.232.133.6] ([88.128.90.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b0ed63sm14871608f8f.22.2024.10.30.01.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 01:40:18 -0700 (PDT)
Message-ID: <6e9a066c-4f57-4ee4-b80b-52f14ddd9394@suse.com>
Date: Wed, 30 Oct 2024 09:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-2-5328a785bbad@suse.com>
 <20241025102037.GB681652@pevik>
Content-Language: en-US
In-Reply-To: <20241025102037.GB681652@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] Add script to generate arch(s) dependant
 syscalls
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

Hi Petr,

On 10/25/24 12:20, Petr Vorel wrote:
> Hi Andrea,
>
>> Add generate_arch.sh script which can be used to generate arch(s)
>> dependant syscalls file. The way it works is pretty simple: for each
>> architecture defined into supported-arch.txt, compile kernel headers,
>> extract the list of syscalls and generate a .in file containing all of
>> them, associated with their own syscall's number.
> Nice improvement, thanks!
>
>> The way syscalls files are generated, passes through a C application
>> which is automatically checking the availability of the syscalls in
>> the user space environment.
> This C application is in the Linux kernel and we only consume the result right?
>
> If the C app was needed to be run for LTP, that would broke LTP cross compilation.
> (There are people compiling LTP with cross compilation, e.g. arm folks in yocto
> and Buildroot, riscv64 on openSUSE Tumbleweed).
The application is auto generated and compiled by this script during 
syscalls files generation. It's the same approach syscalls-table project 
is using 
https://github.com/hrw/syscalls-table/blob/master/scripts/update-tables.sh#L69
>> diff --git a/include/lapi/syscalls/generate_arch.sh b/include/lapi/syscalls/generate_arch.sh
>> new file mode 100755
>> index 000000000..abdb52256
>> --- /dev/null
>> +++ b/include/lapi/syscalls/generate_arch.sh
>> @@ -0,0 +1,205 @@
>> +#!/bin/sh
>> +#
>> +# This is an adaptation of the update-tables.sh script, included in the
>> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
>> +# under the MIT license.
>> +#
>> +# Author: Andrea Cervesato <andrea.cervesato@suse.com>
> nit: I would still use some SPDX + copyright here.
Sure
>
>> +
>> +KERNELSRC=$1
> Generally all shell variables should be quoted to avoid problems with space.
> Feel free to do that before merge.
>
> KERNELSRC="$1"
>
>> +
>> +# to keep sorting in order
>> +export LC_ALL=C
>> +
>> +if [ -z $KERNELSRC ]; then
> Also here and on other places.
>
> if [ -z "$KERNELSRC" ]; then
>
> Try run script with:
> KERNELSRC="foo bar"
>
> [: aa: unexpected operator
>
> Kind regards,
> Petr

Good point.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
