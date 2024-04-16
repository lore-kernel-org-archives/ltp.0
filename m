Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CDCC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713277011; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=j9TcHp2nowP3ySuAcHFkhh1pjf0Ryo5eCLfr3AVRFN4=;
 b=UfxncziYtizzhHk8jmPkw+ND1+Hu6gFW4C0eY3gyn7s2dOhTDxC4j5f5qZc2C2gQAqhDX
 Hwdr+Wrd7K/Mig+J3qkozW9u1IYdncaxcFkiXCJdpSfQHZaojoNhTH2jDj3zmwp1ROBOEfY
 VvTcwLfjVd72YqisgywlvKma93UZezg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463663CFAEE
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 16:16:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BFC03CFAA5
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:16:29 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D22D605657
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:16:26 +0200 (CEST)
Received: by mail-lj1-x241.google.com with SMTP id
 38308e7fff4ca-2d88a869ce6so53886961fa.3
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713276985; x=1713881785; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lw5/NMFvtN2Jl7Lnd4b7Vty1NaQIDEeup12C3B9asEE=;
 b=ZB6sJOGdM10QKTzcq3SWxlDCmHX06FPpcghOLnusW/AhFRdQLJircPquFwaytOBHiE
 c2/kWHiLvfkHeS4fViw+2RHu8vZZ5rnyk+M40buDQGyB5AKyN7zFXqFpDAWugIUFILkn
 iWHSXL+mHulv5uCP27SFi0aq5rUjTBO6KqigngT3IVXKA3owEpbSXuuNXFUHuYwp/hiM
 42Of7uvHkkPnWSX3QnT2Mv5J9d1x78Vb9RGu4z4F7+wV8PyPgL5BdCrCmltxaN+3uqE6
 5Vzw64HKGB98GkEEzrSuoc0An1KDzyRRdp7CQme48G3DrwwcS4QvSD7SEnI1RCtlZ+Jx
 XCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713276985; x=1713881785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw5/NMFvtN2Jl7Lnd4b7Vty1NaQIDEeup12C3B9asEE=;
 b=pr6xqG1wT2XMYxggYqFYNGVdGEqV1p2rdWm6NUpfpdDP/YcVJaBFKVdCU7SF8uaqRF
 YLYAv4RfwPQ+y2KIremZbNJZ5eLsRWF4RDu5NQ9yyVoBDhzosfojtcmsNkitFtKfPSyE
 IBFaD+E3Sl/uXnhCgKZXsPCExhoVhJu+yRCohu3zZ5A+WOVDC/jM5qJDVLleI7XUZArV
 ZG8MXnlZDc0pCYObbI8CMB5mipBm989AuKc5RxaMua3Rb748JVYZnIAOVkcYjDSUbJJ9
 XWDUZpgtM+IK3OJX2dfv0/1Ta9hsF1WBkivQZLC3qUjRFEfxhNKDfhi3vJfDq8G0KFxT
 im0A==
X-Gm-Message-State: AOJu0YxIShdMV6ZzFXtPSEWLw0JWHpcCBblut0VcDnYMpGsRy+BY+GYV
 oUKYahMDgcMoAitNkc2Vdfk1ziEEdZhOzu+ews8+qM7UzOiUoKV1QiG2GQwEvgs=
X-Google-Smtp-Source: AGHT+IGdzazPZZcPSJgpOJZAuG3kk8529lAzZoeI4r4Mq9oCJjqLDVYOTttMzBvtX9nPxo8JQWM/IQ==
X-Received: by 2002:a2e:9d06:0:b0:2d9:f818:1736 with SMTP id
 t6-20020a2e9d06000000b002d9f8181736mr9383429lji.40.1713276985183; 
 Tue, 16 Apr 2024 07:16:25 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 bg25-20020a05600c3c9900b004162d06768bsm23654299wmb.21.2024.04.16.07.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 07:16:24 -0700 (PDT)
Message-ID: <2c65cdac-d874-4796-b8e2-260c8aa0e7cf@suse.com>
Date: Tue, 16 Apr 2024 16:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240415121719.3798-1-andrea.cervesato@suse.de>
 <Zh54TZT7boknYdN8@rei>
Content-Language: en-US
In-Reply-To: <Zh54TZT7boknYdN8@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: Add new API conversion stats
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

On 4/16/24 15:08, Cyril Hrubis wrote:
>> +def generate_old_api_stats(_):
>> +    """
>> +    Generate statistics for old API tests. We enter the tests folder and we
>> +    count all tests implementations using old API. The way we count them, is to
>> +    open every *.c file and to verify that "#include <test.h>" directive is
>> +    present.
>> +    """
>> +    output = '_static/old_api.rst'
>> +
>> +    old_regex = re.compile(r'#include.*[<"\']test\.h[>"\']')
>> +    new_regex = re.compile(r'#include.*[<"\']tst_test\.h[>"\']')
>> +
>> +    old_tests = 0
>> +    new_tests = 0
>> +
>> +    for root, _, files in os.walk('../testcases'):
>> +        for fname in files:
>> +            if not fname.endswith('.c'):
>> +                continue
> There are at least two cases where the test.h header is included
> indirectly from a test specific header. I guess that it would be cleaner
> to actually fix these tests instead of working around it here.
I can filter out .h and .c eventually, but the problem is that 
implementing inside headers is a bad practice by itself and it's not 
easy to recognize automatically.
>> +            path = os.path.join(root, fname)
>> +            with open(path, 'r', errors='ignore') as fdata:
>> +                for line in fdata:
>> +                    if old_regex.match(line):
>> +                        old_tests += 1
>> +                        break
>> +
>> +                    if new_regex.match(line):
>> +                        new_tests += 1
>> +                        break
>> +
>> +    if old_tests == 0 and new_tests == 0:
>> +        return
>> +
>> +    text = [
>> +        'New API conversion status\n',
>> +        '-------------------------\n\n',
>> +        'The current LTP refactoring plan aims to convert all LTP test\n',
>> +        f'cases using the new LTP API. There are currently **{old_tests}** tests\n',
>> +        f'which need to be converted and **{new_tests}** have been converted\n',
>> +        'already.\n',
>> +    ]
>> +
>> +    with open(output, 'w+') as stats:
>> +        stats.writelines(text)
> Maybe we should generate a table with the test filenames and links to
> github code here? So that people interested in rewriting these tests
> could check here and click on the filename to see the code?
I tried at first, but it's quite confusing to add this in the same 
section and creating a new page seems a bit too much.
>
>>   def generate_syscalls_stats(_):
>>       """
>>       Generate statistics for syscalls. We fetch the syscalls list from the kernel
>> @@ -198,4 +245,5 @@ def generate_syscalls_stats(_):
>>   
>>   def setup(app):
>>       app.add_css_file('custom.css')
>> +    app.connect('builder-inited', generate_old_api_stats)
>>       app.connect('builder-inited', generate_syscalls_stats)
>> diff --git a/doc/users/stats.rst b/doc/users/stats.rst
>> index 7073442aa..a8b322b5f 100644
>> --- a/doc/users/stats.rst
>> +++ b/doc/users/stats.rst
>> @@ -6,4 +6,5 @@ Statistics
>>   In this section we collect some statistics related to the current state of
>>   LTP tests.
>>   
>> +.. include:: ../_static/old_api.rst
>>   .. include:: ../_static/syscalls.rst
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
