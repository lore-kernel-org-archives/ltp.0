Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F78AC02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738584869; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=WQ3CgACN31IvbD4Jm4+Q+HBz0XhS+qxfcltK521UTrc=;
 b=TgGSyV8KVUNwsO1AEMuo5tw4y7GUTIsWG4R0lqJkf9aicRM0cwkaTx464qIa/iU6DiUwz
 mTIUaagMJgnoXvVTe1J75oReo1xdIxbYBIdLMrg6gbr5nCEvF1+dfuZ8qibfXKw8eA6xLns
 GSycymrKRCn5TSrieRzp/owq1G3ZDaw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A495C3C8EBD
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 13:14:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16AFF3C2DB0
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 13:14:08 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43C2A6002A9
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 13:14:07 +0100 (CET)
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso5903936a12.0
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738584847; x=1739189647; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIChSTvLdC9mwSKGo3gkLU+RsGVAsYHDVadJCpbHi18=;
 b=Wsekep6exixcYpDTvn9RCZw4uuPzodw77naa5nGB/5GARflQKfMXf+hrt/qfL5UAUD
 kpE9QyRmcKfoP0bh6+GzyMTEAiAH1nW9MEKhc7x97lfTz4g5SN4piJCsVKMPWNJiB4Yc
 i04vu0hnG84oeGFtlCBQBVITMAlSq2kq7roFZq/rhd7VCB1R9bCp66gqi0jrcK5vtEm0
 54y7hQC1mLdIZoUWD5Ocofyql7CDWC2vCA7SM9K9qmJw2zss/zbCafQVA3SrvRUZDQFC
 PDHw3aPGNySRhZWko60rXzPk5Edj6g85EwhdzdoOYmNEVdCZBx1o00gmOijunUmNVf8Z
 C0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738584847; x=1739189647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIChSTvLdC9mwSKGo3gkLU+RsGVAsYHDVadJCpbHi18=;
 b=G7ofzibU4Dk6IQhUpXQWdgGa6iAGGDbk6Fp7Ps87Yz8JWWjxs2B+5Go1+TC1zgAnhp
 QqK9cA+ESfgm/cVIjbDs2SHuqGI7LApp4yGmpyDowNzVOOyK3e309MsJsm09pv9l1/1X
 pd67bAOGMdPLLq1UDEYh1OqxaC0XpimWtX9dAmYBintX+g08YoSW4FCskI/zHX5blwXa
 cb+QpK1OPKyY9JtY/RBir4F3npy9COr12LlexSCC66w+boJOGTJoqGV9hCofRTOPFvxU
 IXjy7T5ftz3RNKNlvZ9ClXUPbJQ0shdllj89pYTU8tBLKI97kUdTes7m+1nw1mfBUWwp
 JmDw==
X-Gm-Message-State: AOJu0Ywx6PA8D2z27A363irtG2Ud2H/JMQ38wW0w4eycrJl5twV0zQJA
 /ehgnR9oU1OJ3GlTSK4moPmNt4aiAmqXJIXGslAvJLfIGVP6x571w8CaXmLfU+g=
X-Gm-Gg: ASbGnctauBN4V3xowkTcR6Ne8xZp/RWSfwTdZQfPnjUZX5SGBdlhOlieDmORyPpbg8T
 q9XcU7emFnlivcAzh8wH22iQypoYj1mBMHM6LoT4K24rOkzv5WKMM/64UdrR4c86u+US+7hZCnD
 VpkaaQjBIxsoV+tIUv9pEV5aHLodC/5/xou5n9mFJmOKVO+WUloYzKLFrZmR3E02kTpB2u988Vf
 vI9nkWaAyfm9WpwfFCyQqkTmZ+0nEAKWr+uqQw/92h52mYDkHLv2DMu9VQPYxgACUzZe4TNkHHt
 k2cFlj3wpP0DiSfPwRA0WmRbvA==
X-Google-Smtp-Source: AGHT+IEIcBVmUg9D+/uzXQF4HUbkeWmrrIO/OuxG4TV3KurmIgv2Q2tiGRIvB6gXp3C9c3aFOx6dWA==
X-Received: by 2002:a05:6402:4026:b0:5dc:7fbe:7303 with SMTP id
 4fb4d7f45d1cf-5dc7fcdb6afmr16850964a12.5.1738584846607; 
 Mon, 03 Feb 2025 04:14:06 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723d0006sm7650459a12.2.2025.02.03.04.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 04:14:06 -0800 (PST)
Message-ID: <7f6d9a5d-284a-4c25-b491-cfd7b15da2dd@suse.com>
Date: Mon, 3 Feb 2025 13:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
 <Z6CxekRPhvsSdfLc@rei>
Content-Language: en-US
In-Reply-To: <Z6CxekRPhvsSdfLc@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add tests catalog page
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

On 2/3/25 13:07, Cyril Hrubis wrote:
> Hi!
>> Add a new section in the LTP documentation website, where we list all
>> tests which are available in LTP and supporting new API.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> This patch-set is meant to introduce a new page in the LTP
>> documentation, showing tests which are currently available with their
>> description and information.
>> ---
>>   doc/.gitignore             |   1 +
>>   doc/conf.py                | 101 +++++++++++++++++++++++++++++++++++++++++++--
>>   doc/index.rst              |   4 ++
>>   doc/users/test_catalog.rst |   7 ++++
>>   4 files changed, 109 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/.gitignore b/doc/.gitignore
>> index 173179852070f25acb6a729975df9d52d171b422..2b05a1ec368573778cfe7ee6a1cb5d6c5ecb0b5a 100644
>> --- a/doc/.gitignore
>> +++ b/doc/.gitignore
>> @@ -1,4 +1,5 @@
>>   html/
>>   build/
>>   _static/syscalls.rst
>> +_static/tests.rst
>>   syscalls.tbl
>> diff --git a/doc/conf.py b/doc/conf.py
>> index c6a84ea5810424ce6e1c21d81946c1819f10a3cc..2ecfeb80ece1e14f94b757f26fa5e08fb79f1c69 100644
>> --- a/doc/conf.py
>> +++ b/doc/conf.py
>> @@ -5,6 +5,7 @@
>>   
>>   import os
>>   import re
>> +import json
>>   import socket
>>   import urllib.request
>>   import sphinx
>> @@ -17,6 +18,7 @@ copyright = '2024, Linux Test Project'
>>   author = 'Linux Test Project'
>>   release = '1.0'
>>   ltp_repo = 'https://github.com/linux-test-project/ltp'
>> +ltp_repo_base_url = f"{ltp_repo}/tree/master"
>>   
>>   # -- General configuration ---------------------------------------------------
>>   # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
>> @@ -25,7 +27,7 @@ extensions = [
>>       'linuxdoc.rstKernelDoc',
>>       'sphinxcontrib.spelling',
>>       'sphinx.ext.autosectionlabel',
>> -    'sphinx.ext.extlinks'
>> +    'sphinx.ext.extlinks',
>>   ]
>>   
>>   exclude_patterns = ["html*", '_static*']
>> @@ -138,7 +140,6 @@ def generate_syscalls_stats(_):
>>       if error:
>>           return
>>   
>> -    syscalls_base_url = f"{ltp_repo}/tree/master"
>>       text = [
>>           'Syscalls\n',
>>           '--------\n\n',
>> @@ -176,7 +177,7 @@ def generate_syscalls_stats(_):
>>               path = dirpath.replace('../', '')
>>               name = match.group('name')
>>   
>> -            ltp_syscalls[name] = f'{syscalls_base_url}/{path}'
>> +            ltp_syscalls[name] = f'{ltp_repo_base_url}/{path}'
>>   
>>       # compare kernel syscalls with LTP tested syscalls
>>       syscalls = {}
>> @@ -186,7 +187,7 @@ def generate_syscalls_stats(_):
>>   
>>           if kersc not in syscalls:
>>               if kersc in white_list:
>> -                syscalls[kersc] = f'{syscalls_base_url}/{white_list[kersc]}'
>> +                syscalls[kersc] = f'{ltp_repo_base_url}/{white_list[kersc]}'
>>                   continue
>>   
>>               syscalls[kersc] = None
>> @@ -256,6 +257,97 @@ def generate_syscalls_stats(_):
>>           stats.writelines(text)
>>   
>>   
>> +def generate_test_catalog(_):
>> +    """
>> +    Generate the test catalog from ltp.json metadata file.
>> +    """
>> +    output = '_static/tests.rst'
>> +    metadata_file = '../metadata/ltp.json'
>> +    cve_url = "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
>> +    commit_url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
>> +    timeout_def = 0
>> +    text = []
>> +
>> +    metadata = None
>> +    with open(metadata_file, 'r', encoding='utf-8') as data:
>> +        metadata = json.load(data)
>> +
>> +    timeout_def = metadata['defaults']['timeout']
>> +
>> +    for test_name, conf in metadata['tests'].items():
>> +        text.extend([
>> +            f'{test_name}\n',
>> +            len(test_name) * '-' + '\n'
>> +        ])
>> +
>> +        # source url location
>> +        test_fname = conf.get('fname', None)
>> +        if test_fname:
>> +            text.append(f"\n`source <{ltp_repo_base_url}/{test_fname}>`_\n\n")
>> +
>> +        # test description
>> +        desc = conf.get('doc', None)
>> +        if desc:
>> +            desc_text = []
>> +            for line in desc:
>> +                if line.startswith("[Descr"):
>> +                    desc_text.append("**Description**")
>> +                elif line.startswith("[Algo"):
> Huh, why not the whole [Description] and [Algorithm]?
Typos in the code :-) I just overlay it fixing the result. But yes, in 
the final version we need to use the full name. Maybe a comment there 
would have helped.
>
>> +                    desc_text.append("**Algorithm**")
>> +                else:
>> +                    desc_text.append(line)
>> +
>> +            text.extend([
>> +                '\n'.join(desc_text),
>> +                '\n'
>> +            ])
>> +
>> +        timeout = conf.get('timeout', None)
>> +        if timeout:
>> +            text.append(f'\nTest timeout to {timeout} seconds.')
>> +        else:
>> +            text.append(f'\nTest timeout defaults to {timeout_def} seconds.')
>> +
>> +        text.append('\n\n')
>> +
>> +        # tags information
>> +        tags = conf.get('tags', None)
>> +        if tags:
>> +            text.extend([
>> +                '\n.. list-table::\n',
>> +                '   :widths: 50 50\n'
>> +                '   :header-rows: 1\n\n',
>> +                '   * - Tag\n',
>> +                '     - Info\n',
>> +            ])
>> +
>> +            for tag in tags:
>> +                tag_key = tag[0]
>> +                tag_val = tag[1]
>> +
>> +                if tag_key == 'CVE':
>> +                    tag_val = f'`{tag_val} <{cve_url}{tag_val}>`_'
>> +                elif tag_key == 'linux-git':
>> +                    tag_val = f'`{tag_val} <{commit_url}{tag_val}>`_'
> We also have glibc-git and musl-git, see print_test_tags() in
> lib/tst_test.c
Thanks for pointing it out
>> +                text.extend([
>> +                    f'   * - {tag_key}\n',
>> +                    f'     - {tag_val}\n',
>> +                ])
>> +
>> +            text.append('\n')
>> +
>> +        # small separator between tests
>> +        text.extend([
>> +            '\n',
>> +            '.. raw:: html\n\n',
>> +            '    <hr>\n\n',
>> +        ])
>> +
>> +    with open(output, 'w+', encoding='utf-8') as new_tests:
>> +        new_tests.writelines(text)
>> +
>> +
>>   def setup(app):
>>       """
>>       Setup the current documentation, using self generated data and graphics
>> @@ -263,3 +355,4 @@ def setup(app):
>>       """
>>       app.add_css_file('custom.css')
>>       app.connect('builder-inited', generate_syscalls_stats)
>> +    app.connect('builder-inited', generate_test_catalog)
>> diff --git a/doc/index.rst b/doc/index.rst
>> index b907ac36f0c9328c576d25dee5777d808c2e5119..c00a59d31345142e78deb74eacc9da2941291d76 100644
>> --- a/doc/index.rst
>> +++ b/doc/index.rst
>> @@ -11,6 +11,7 @@
>>      users/setup_tests
>>      users/supported_systems
>>      users/stats
>> +   users/test_catalog
>>   
>>   .. toctree::
>>      :maxdepth: 3
>> @@ -54,6 +55,9 @@ For users
>>   :doc:`users/stats`
>>      Some LTP statistics
>>   
>> +:doc:`users/test_catalog`
>> +   The LTP test catalog
>> +
>>   For developers
>>   --------------
>>   
>> diff --git a/doc/users/test_catalog.rst b/doc/users/test_catalog.rst
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b1674f9dc614ea04a89cf084e92b72c6862a5f48
>> --- /dev/null
>> +++ b/doc/users/test_catalog.rst
>> @@ -0,0 +1,7 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +Test catalog
>> +============
>> +
>> +.. include:: ../_static/tests.rst
>> +
>>
>> ---
>> base-commit: 728759506cbe08612183275b3543007d1c47f7f4
>> change-id: 20250131-doc_tests_list-1b82f51e43fd
>>
>> Best regards,
>> -- 
>> Andrea Cervesato <andrea.cervesato@suse.com>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
