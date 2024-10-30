Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5637D5CCB1
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730298082; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SAg2LAbFUOxEgezfkCT+9t6YlWSc99+XDkabD8kupqY=;
 b=ReWheQ7GEyv+bExU9g0fD8yGlXl+y9CXaDyqWubpxf9Ci4luK/tOOdV3r7ctqIXy9u1xY
 Jgba3yJt3q+ZK6qVzZxXgHXgnJHD7/VA+t6f9q3pXGZuyj99hGMn9FJT9AITgRlyq80QA41
 0vQO6vRAMYXT3Rtgb2pjSMDrBN/HSK4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BCF23CB096
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 15:21:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A89CB3CAE63
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 15:21:00 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6575613F2C
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 15:20:59 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso5969123f8f.0
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730298059; x=1730902859; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+gL1sWQ/7xo6shi3rU7ei5maVpHK5HoNXtEO2lcjVA=;
 b=HfKx/MBTqwNkj7v+fyUoXQm9hlVfNGy8GFvdJhyFsjXHlWi25URQ8vSde5Lp5Bk3xy
 DtCs/6XQOoCnJJYw+Rgf5DA8IjFGf8yZXh1uQ3acDE8k1V0cQYeJP6rsIa+6/aC2fWGV
 wMaPvSr5ne2YkrcpNK+01xvZ/EvZSZjrUJpoJzWa7flqoBYtOZHyQle78F+PC/DVy37q
 UJ2+Yl0s4Qp5uqMWMpOuIMwbVbg9ptd0XQOGkJBggY7jp+GjsplyQPyBNLc3F7SwnzTR
 relwSXcaTMPDqBQOeA3kRm69NLEAsi/5cZkT5OOq40cT/847fbh7i/sGF7rfcaEKH9Gg
 zjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730298059; x=1730902859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+gL1sWQ/7xo6shi3rU7ei5maVpHK5HoNXtEO2lcjVA=;
 b=p7asq7y7jrtXf/1MsBd4RMLaKEqRBf5WN6y3tqoPnmBt9LSpPgx43mWZE/hHNCBkFg
 j8BTpZEeFfWvxyaUdXY3XyN+72Wm63/1gpIQ5yY8iZa1glOzdN3CBarWhOcGoSqKMxt9
 w4cbu4RqnSUaUJNZG1zOS3L+bP6D5ToZgLyfooXI3sQi6fWavq+r9TBZSAPbczcLasHh
 xEs0QHw0FxyntTAr1uaXVeC0h8jS5IMrfNXGO/oTBrmXlFcQ3ZClrHnluWOfvmbULQT9
 ZeRxKJeqJ/HNyzALC7OXNfjpwZuTPQi0RnEjlzF9Yvv7QZFmx2duqJ1To+m9XnLXVKF4
 CCPA==
X-Gm-Message-State: AOJu0YwMgkBEiyO7aabUf9VW8pLmtiUQHgunbbi8KGa7doj4tpl9S+ix
 g2//jo8g1UdXrTE9SbNEjUszu0dA9KqnwJTv9Otcg6hFxUECXRdV+n8Wsq44dfM=
X-Google-Smtp-Source: AGHT+IHbtmcRGlD6BAmvw3X9t/gISrO/xXf/VkZvPMVpowelUj86xJfg1D6V7l/S6lVzaIM8d4L7UA==
X-Received: by 2002:a5d:444f:0:b0:37c:c832:cf95 with SMTP id
 ffacd0b85a97d-3806123eecfmr12929785f8f.50.1730298059241; 
 Wed, 30 Oct 2024 07:20:59 -0700 (PDT)
Received: from [10.232.133.6] ([88.128.90.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b712cbsm15571498f8f.77.2024.10.30.07.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 07:20:58 -0700 (PDT)
Message-ID: <4e4ff14e-43d8-4a97-8dd6-f8609cd38404@suse.com>
Date: Wed, 30 Oct 2024 15:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
 <ZyI42B6qhZCf0Qwo@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZyI42B6qhZCf0Qwo@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
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

Hi Cyril,

On 10/30/24 14:47, Cyril Hrubis wrote:
> Hi!
>> +(
>> +	echo
>> +	echo "/* Common stubs */"
>> +	while IFS= read -r arch; do
>> +		while IFS= read -r line; do
>> +			set -- ${line}
>> +			syscall_nr="__NR_$1"
>> +			shift
>> +
>> +			echo "# ifndef ${syscall_nr}"
>> +			echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
>> +			echo "# endif"
>> +		done <"${SCRIPT_DIR}/${arch}.in"
>> +	done <${SUPPORTED_ARCH}
>> +	echo "#endif"
>> +) >>${SYSCALLS_FILE}
> This will generate multiple fallback definitions, one per architecture
> for common syscall, there was a good reason why these files were parsed
> by awk with sort -u
I wrote the code a few weeks ago, so I needed to read it again to 
understand the reason.

If you take a look at the drop_bad_entries() and generate_tables() you 
will see that `sort` command is used to remove duplicates and to sort 
the entire list per architecture.

Or am I missing something?

>> -echo "#define __LTP__NR_INVALID_SYSCALL -1" >> "${output_pid}"
>> -for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u) ; do
> This is the important part that IMHO should stay.
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
