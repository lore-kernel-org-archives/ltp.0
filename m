Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91239C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738575599; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zAj9YcUy6RPe7zMMRoH5NQMhVM0KENgQWWac/W+YMk0=;
 b=fQIjqWVBDKqhuvBu6rjp2KAarMvEkpL99qwi1xkEq6ESJiswevInLP8cEcNKpJ4BG7nNk
 09lQvxL/MeeqL/405Fkd11Q64ZI820HEXsiKqy3cw3Ngyg3mkJ8oUmjbeWJhD1n1Po70FGq
 YDhs4W49ETKp7HZ8yGm/elmXrAlUpaI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B324E3C88AF
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:39:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 423183C8E74
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:39:38 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E1180141050B
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:39:36 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso30337355e9.2
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 01:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738575576; x=1739180376; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OC2mnIzGRVckG6Mb3aTpw+U+FyfU0SH1IyL7uQi1ONM=;
 b=U7+WRbONG0REln1bcGwUOCDrYbXNfzYGltbzYlSvp1BHXjFMK8zVMH/zqfd5kZOoTd
 Pd+I0R9aWz+2ZoO/syxLnFJ5s6uti8FWEgLxK7fQ2LfHdwXhoPYYnRVFcidne/xaFqff
 rmhoeEEfpVuo187sO8LOnimInEs7Iw5ztFEpLRXB4K0EK2FKvGIOxAsLIChuHRNV6CHA
 q2WFQAen6VmgSGe8Ol70xk/gskNPF4vJ0qa5319lgLAI9QzaOIrI8K5X+i2V4xlhgs+s
 HW2EbkMr5NJ0W/mWIjoQqHEUZs2IccJMWYLhw6Tc9NV68py21fm19evBSos3pDAK3UW2
 q+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738575576; x=1739180376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OC2mnIzGRVckG6Mb3aTpw+U+FyfU0SH1IyL7uQi1ONM=;
 b=IInhqMidlxG9WdmQWDVuba65DuHf0WoFn0smSNbKJuynJFVhUhds13qgcFCSPDbFwS
 tHUwsRqtzGN+5fezznVg5783IRz/6azDx6a5RaU9IxjGfCuxtgT0Sdg7NrHisCZlal9J
 Sx7Y1BI9P9CCIQhRc/aNAr35wMSyfvj58Z7bDbXI6c7v0KZNguoTDwU5mnhWWKYHaLOy
 1UOmGHPuTjQlgntdwxiilNKK3t3GsRTMLTHIA8jrD65U8rgRercCxTDb+U+kZOFFV9e6
 VH1BEJ3mZ/tAq8iNWuPHOwj0RJGhC09a1ulKDFrFVdm83UdP0FtXB7n99GJzQl59rBCG
 vsNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfFtT6KaYW9PnZKFwguBQ5T64eR4MAT99Ck9ejOXuwZ8OOVDdWDeLk1osuZMcIW/FAp58=@lists.linux.it
X-Gm-Message-State: AOJu0YzKvcPtqMNm4P/WyrF3Xa6cfX9fUCwqi6ZiZVx6ZffExag2bI7S
 1X39VtqJNK3mCa8WYQFnCgaDAcFdldettCvZVI50VjUmkBHMJqYAPpUs+eq+qpnJois6A7wmp0q
 1vCECnQ==
X-Gm-Gg: ASbGncuv1dsoPZeu+76I4Gseg9xAd25HVj/TCh8HUhVlVeI7QEMn5vRAPHhtO4ATC8c
 iOPRGSfeveEMTawywZCh1ge+xG/o+vbL4Ef2tt0bm2iv15SKUR+VxJrhduG/UQJxiAWJFeXldOP
 SJHcDEF6ifqdlWEKrqrzJhx3EViM8UmrxarQent0a0e1LC4MGCmFHJpdjBl51AdjaZFWlW36XvH
 Nlz4ogQhqB/f3i0dtiDdv5KvOvN3ETEVNooldeNPv87OrY9kS33vYqoyVS4mAD8ltkyzqlUSL3O
 iAuTtbxQR5lgfZ8Nn+a2/LUlKw==
X-Google-Smtp-Source: AGHT+IHIX8gyG3Olq+Z+9QHzuOUBTZ7CykcH9pUm7RfCe+PWhgR191pbv3DlBTnzq+c1AR2oJjyffQ==
X-Received: by 2002:a05:600c:4f49:b0:438:a5fe:3885 with SMTP id
 5b1f17b1804b1-438dc40bf25mr173859085e9.23.1738575575783; 
 Mon, 03 Feb 2025 01:39:35 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f49dsm147727175e9.35.2025.02.03.01.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 01:39:35 -0800 (PST)
Message-ID: <956cc184-a640-4318-828b-10c1732117ac@suse.com>
Date: Mon, 3 Feb 2025 10:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
Content-Language: en-US
In-Reply-To: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

please consider this as a WIP. I'm searching for feedbacks before 
proceeding.
What do you think?

Andrea

On 2/3/25 10:38, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Add a new section in the LTP documentation website, where we list all
> tests which are available in LTP and supporting new API.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This patch-set is meant to introduce a new page in the LTP
> documentation, showing tests which are currently available with their
> description and information.
> ---
>   doc/.gitignore             |   1 +
>   doc/conf.py                | 101 +++++++++++++++++++++++++++++++++++++++++++--
>   doc/index.rst              |   4 ++
>   doc/users/test_catalog.rst |   7 ++++
>   4 files changed, 109 insertions(+), 4 deletions(-)
>
> diff --git a/doc/.gitignore b/doc/.gitignore
> index 173179852070f25acb6a729975df9d52d171b422..2b05a1ec368573778cfe7ee6a1cb5d6c5ecb0b5a 100644
> --- a/doc/.gitignore
> +++ b/doc/.gitignore
> @@ -1,4 +1,5 @@
>   html/
>   build/
>   _static/syscalls.rst
> +_static/tests.rst
>   syscalls.tbl
> diff --git a/doc/conf.py b/doc/conf.py
> index c6a84ea5810424ce6e1c21d81946c1819f10a3cc..2ecfeb80ece1e14f94b757f26fa5e08fb79f1c69 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -5,6 +5,7 @@
>   
>   import os
>   import re
> +import json
>   import socket
>   import urllib.request
>   import sphinx
> @@ -17,6 +18,7 @@ copyright = '2024, Linux Test Project'
>   author = 'Linux Test Project'
>   release = '1.0'
>   ltp_repo = 'https://github.com/linux-test-project/ltp'
> +ltp_repo_base_url = f"{ltp_repo}/tree/master"
>   
>   # -- General configuration ---------------------------------------------------
>   # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
> @@ -25,7 +27,7 @@ extensions = [
>       'linuxdoc.rstKernelDoc',
>       'sphinxcontrib.spelling',
>       'sphinx.ext.autosectionlabel',
> -    'sphinx.ext.extlinks'
> +    'sphinx.ext.extlinks',
>   ]
>   
>   exclude_patterns = ["html*", '_static*']
> @@ -138,7 +140,6 @@ def generate_syscalls_stats(_):
>       if error:
>           return
>   
> -    syscalls_base_url = f"{ltp_repo}/tree/master"
>       text = [
>           'Syscalls\n',
>           '--------\n\n',
> @@ -176,7 +177,7 @@ def generate_syscalls_stats(_):
>               path = dirpath.replace('../', '')
>               name = match.group('name')
>   
> -            ltp_syscalls[name] = f'{syscalls_base_url}/{path}'
> +            ltp_syscalls[name] = f'{ltp_repo_base_url}/{path}'
>   
>       # compare kernel syscalls with LTP tested syscalls
>       syscalls = {}
> @@ -186,7 +187,7 @@ def generate_syscalls_stats(_):
>   
>           if kersc not in syscalls:
>               if kersc in white_list:
> -                syscalls[kersc] = f'{syscalls_base_url}/{white_list[kersc]}'
> +                syscalls[kersc] = f'{ltp_repo_base_url}/{white_list[kersc]}'
>                   continue
>   
>               syscalls[kersc] = None
> @@ -256,6 +257,97 @@ def generate_syscalls_stats(_):
>           stats.writelines(text)
>   
>   
> +def generate_test_catalog(_):
> +    """
> +    Generate the test catalog from ltp.json metadata file.
> +    """
> +    output = '_static/tests.rst'
> +    metadata_file = '../metadata/ltp.json'
> +    cve_url = "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
> +    commit_url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
> +    timeout_def = 0
> +    text = []
> +
> +    metadata = None
> +    with open(metadata_file, 'r', encoding='utf-8') as data:
> +        metadata = json.load(data)
> +
> +    timeout_def = metadata['defaults']['timeout']
> +
> +    for test_name, conf in metadata['tests'].items():
> +        text.extend([
> +            f'{test_name}\n',
> +            len(test_name) * '-' + '\n'
> +        ])
> +
> +        # source url location
> +        test_fname = conf.get('fname', None)
> +        if test_fname:
> +            text.append(f"\n`source <{ltp_repo_base_url}/{test_fname}>`_\n\n")
> +
> +        # test description
> +        desc = conf.get('doc', None)
> +        if desc:
> +            desc_text = []
> +            for line in desc:
> +                if line.startswith("[Descr"):
> +                    desc_text.append("**Description**")
> +                elif line.startswith("[Algo"):
> +                    desc_text.append("**Algorithm**")
> +                else:
> +                    desc_text.append(line)
> +
> +            text.extend([
> +                '\n'.join(desc_text),
> +                '\n'
> +            ])
> +
> +        timeout = conf.get('timeout', None)
> +        if timeout:
> +            text.append(f'\nTest timeout to {timeout} seconds.')
> +        else:
> +            text.append(f'\nTest timeout defaults to {timeout_def} seconds.')
> +
> +        text.append('\n\n')
> +
> +        # tags information
> +        tags = conf.get('tags', None)
> +        if tags:
> +            text.extend([
> +                '\n.. list-table::\n',
> +                '   :widths: 50 50\n'
> +                '   :header-rows: 1\n\n',
> +                '   * - Tag\n',
> +                '     - Info\n',
> +            ])
> +
> +            for tag in tags:
> +                tag_key = tag[0]
> +                tag_val = tag[1]
> +
> +                if tag_key == 'CVE':
> +                    tag_val = f'`{tag_val} <{cve_url}{tag_val}>`_'
> +                elif tag_key == 'linux-git':
> +                    tag_val = f'`{tag_val} <{commit_url}{tag_val}>`_'
> +
> +                text.extend([
> +                    f'   * - {tag_key}\n',
> +                    f'     - {tag_val}\n',
> +                ])
> +
> +            text.append('\n')
> +
> +        # small separator between tests
> +        text.extend([
> +            '\n',
> +            '.. raw:: html\n\n',
> +            '    <hr>\n\n',
> +        ])
> +
> +    with open(output, 'w+', encoding='utf-8') as new_tests:
> +        new_tests.writelines(text)
> +
> +
>   def setup(app):
>       """
>       Setup the current documentation, using self generated data and graphics
> @@ -263,3 +355,4 @@ def setup(app):
>       """
>       app.add_css_file('custom.css')
>       app.connect('builder-inited', generate_syscalls_stats)
> +    app.connect('builder-inited', generate_test_catalog)
> diff --git a/doc/index.rst b/doc/index.rst
> index b907ac36f0c9328c576d25dee5777d808c2e5119..c00a59d31345142e78deb74eacc9da2941291d76 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -11,6 +11,7 @@
>      users/setup_tests
>      users/supported_systems
>      users/stats
> +   users/test_catalog
>   
>   .. toctree::
>      :maxdepth: 3
> @@ -54,6 +55,9 @@ For users
>   :doc:`users/stats`
>      Some LTP statistics
>   
> +:doc:`users/test_catalog`
> +   The LTP test catalog
> +
>   For developers
>   --------------
>   
> diff --git a/doc/users/test_catalog.rst b/doc/users/test_catalog.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1674f9dc614ea04a89cf084e92b72c6862a5f48
> --- /dev/null
> +++ b/doc/users/test_catalog.rst
> @@ -0,0 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Test catalog
> +============
> +
> +.. include:: ../_static/tests.rst
> +
>
> ---
> base-commit: 728759506cbe08612183275b3543007d1c47f7f4
> change-id: 20250131-doc_tests_list-1b82f51e43fd
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
