Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7391FC27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718003723; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ufMLrodUhknYZ7eazICc+LY+IK1+jfSqNp5WtUGbny0=;
 b=T0QKmfLgCBxicgWVkxgtKTpM7y+3l9xxF+oSJsmFVZIge4iPsRJZ+/i3137XlM9NbA9Bx
 ohh2oTd5LE/xvDiSRVvXi8U6zh2JGiktn+5fT2ySm8BpUcNnKDuIl7jdAwmBA3NQbwGD+ym
 E4sEqxmC/26ogolcztcfIEhv8NYukak=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C42703D0B2D
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:15:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 610053C74EA
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 09:15:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B0121401703
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 09:15:01 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57c714a1e24so1638883a12.2
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718003700; x=1718608500; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwiT9JuJNzruG9ru4+SLh1YFh+kAn5knJ7ba2OpclB4=;
 b=FzC1N6BRNfv5FIW1oU+GJ56FzxyPo4eBx8y3aGXoZ03bKyQvdupVZwK29NJ13LkdZR
 FmCHzxPIcIjg45mpYGKFMDvrhQSEi6C6blAgdAZC0yGcIIijqDOdr9stJ5+0nPwZ23Nq
 yYm6D48VIiwdk7GmkkA0owcbZyNvpJsNM/BpRt90rrErT5nHQENZRnQPH/Q5WNqH5rax
 BVdcs8+Z2qc5HAzNyENslybZ999cu/rWEvJ6ecXERzpNpQq31K513rPFgSkv/pRe4RHg
 G8LvyN7V9638mvCkA9tPqhwNrPIKetd6U47P+xNPjWeoPOXIEOySVDZkyC7uMu7Q+oSs
 fcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718003700; x=1718608500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwiT9JuJNzruG9ru4+SLh1YFh+kAn5knJ7ba2OpclB4=;
 b=tnt2J55jeaa6bBVKqAnTXPVe9FGvmcwwD4LWAGZpfqq6se3wCuAe/gXLmGTVTgab7M
 PWpencXYaO8y55d7Clx7UO1Q2xRRwWaY54/DdqTFABDVxuig9weOClGp9uZqoTuk1KKm
 gHAgUDnTRwKmzPb+OA7e/KCwROJBTQMOKx/3SmszBgFFV7PpkBUtebHXnEXvsFSygIr/
 A2OsdgpvfwhLQD/JDJpLdYtMHzCHPdgw1I6GyvNT8etiY8zj0935+AhOih8FV2BCjbuI
 1JH1ObmPiFIIvd80tT55G0WVxQJlqn8i+Qb/I9JeaQzVJQONvG6nrNKvxEqAxhkEcn8E
 coJA==
X-Gm-Message-State: AOJu0YzJ0KBwQM79zXeyjfKBAntxjiL59cjnCA/X8hXeAdq3eXomxFqL
 erEVLhH2ggrGd8ViDPi3yb9REGhfR5vDZD1/2m6WSKPMP6M5WyZhswv1+WkegimDE0M72xtIAgj
 t
X-Google-Smtp-Source: AGHT+IFJPjmpgq12sB9VmZOUj0CbBxmeqZdRUvTbNKhb9HOYcNy3fbkHpKXlmOEg0MYGj1HaXuHWHg==
X-Received: by 2002:a17:906:dfe5:b0:a6f:10d0:f3e0 with SMTP id
 a640c23a62f3a-a6f10d0f4d7mr239636866b.21.1718003700142; 
 Mon, 10 Jun 2024 00:15:00 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.42.167])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c2b1e80sm143358466b.145.2024.06.10.00.14.59
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 00:14:59 -0700 (PDT)
Message-ID: <4a19e93b-b009-4b0f-9be8-8c348a9ab214@suse.com>
Date: Mon, 10 Jun 2024 09:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

My 2 cents below.

On 6/7/24 23:17, Bird, Tim wrote:
>> -----Original Message-----
>> From: Cyril Hrubis <chrubis@suse.cz>
>>>> I'm afraid that's not a good solution either. The end goal for kirk is
>>>> to have a small binary locked in RAM and with realtime priority to
>>>> execute tests and send back logs, in case of qemu over virtio, to the
>>>> kirk. That is to make sure that logs are collected properly even when
>>>> kernel is out of memory and in a similar situations.
>>>>
>>>> If you run kirk on the VM, reporting is not going to be reliable.
>>> This means you're effectively mandating how ltp be run and the only
>>> variable would be the kernel binary. Whilst I can understand that, I'm
>>> not sure how useful us testing with this would be.
>> Not at all. As I replied to Tim, there is no secret sauce in runltp or
>> kirk. In the end it's a tool to execute a test binaries. If you have a
>> system that can execute binaries, reliably transfer logs and handle
>> kernel crashes you can as well just execute the tests yourself. All you
>> need from us is a tooling that will produce a list(s) of tests to
>> execute.
> I don't think it's that simple.
>
> Currently, Fuego users can choose to either:
> 1. run a suite of tests (specified in the runtest file) using runltp executing on the target
> 2. run an individual test, not using runltp.
>
> In the first case, since some of the suites have a large number of tests,
> there are options in Fuego to convert the results into spreadsheet files
> or PDF reports.  But this is based on the multi-test output from runltp.
>
> Does kirk provide the same output formats and output options as runltp?
No, but it provides something better than that: a JSON file that can be 
easily parsed by most of the libraries out there.
kirk can be literally used as it is runltp, with difference of python 
dependency. If you have python, you can run kirk on
host as well as on target. All features like Qemu, LTX, SSH (etc.) 
supports are meant to be used by host only.
>
> If runltp is eventually removed, I'll have to come up with a solution
> for executing suites of tests on the target, and making sure the output
> is the same as runltp (or modifying the report generation code to handle
> a new output).
>
> Fuego supports multiple "transport" layers.  ssh, serial console,
> and adb transfers are supported, as well as a few weird transports
> (such as ssh to a controller board that then transfers over serial).
> I wouldn't request kirk to support these oddball transport mechanisms,
> but if it had support for mapping it's communication mechanisms
> onto these, or supporting some pluggable mechanism for transferring
> files and executing programs (collecting stdout, stderr and return code),
> that might be useful.
>
> ...
>>>> We do have the ltx binary, which is the small dispatcher supposed to run
>>>> on the VM. And in an ideal world we would have a python library that
>>>> talks to it on the other end, as a part of kirk, that could be reused
>>>> separately. And the same for building lists of test to execute, ideally
>>>> we would have a python library that would export a simple interface so
>>>> that everyone could integrate the blocks that they really need into
>>>> their solution.
>>> Automated testing is a hard problem to solve generically and even if
>>> you do manage that, this all looks like a lot of work even just to
>>> reproduce what works today :/.
>> Indeed. However I stil think that there are reusable parts that may be
>> worth putting together.
> Possibly.  I tried for a few years to integrate Fuego and KernelCI,
> but their architectures were too different, and I eventually gave up.
> Now that KernelCI is changing, I've thought about going back
> and seeing if I could transfer anything between the projects.
>
> Usually, you have to write some kind of mapping layer, and the mappings
> turn out to be harder than expected, due to assumptions baked in to
> the architecture.
>
>   -- Tim
>
>
Regards,

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
