Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A5EC04FFE
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 07:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714117321; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=8D3zQn6VC3lo/gYzp0pMTl//gcJ9Zz2xGH5D5fk7dEA=;
 b=lTbI1cqtV58NcLfzrIykhUi/Czd7wysqOhv2QdkH0CmzdbiCnfYS7JoD0L3SV/DKQLl7X
 pfMRMiSRZb5jMbSA5HRfM1fu/FI58N5eOYf5vhaGf9NmDt52MePkeLQOzIOlkrpGOg0ewvX
 3Gle8M2sigcbvmRSuqVVzZg1iJue0BU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F24D3CFFBF
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 09:42:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B5803CF615
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 09:41:39 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29F541A0123C
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 09:41:37 +0200 (CEST)
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-571bddddbc2so2212164a12.1
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714117296; x=1714722096; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqgsQ80KlitoDohnjY62xr/Nbi+2/jm7BCq1mSEmCYY=;
 b=guF6UFakN4vzshSoWmHefsqfbnB/Rmmu393SzxkRglhFEJ0/3tIwGCRA4Sy7+QZz1V
 6c1LmP+i4mD+us6QzNUDn/hsc/7yflQea9zCtLjp3ZjvJOUQw2TaWeHFqIlX8z1Gh4yA
 sdYYGG8px2gniBQBeoU2wPQQ5D/t0RQw2sAw73EM5KMJpRlRQLWZXrl48xCHwyN6Qjdg
 eOohgX+joW+Vy7W7B/iiy4nEJFBSP1dTxa+4lPomSQGMaP3zWoEw4NQRkjI8nkldrNb+
 DAFVQnJpkfUfphPYrb5sR3Bp4Fe0iJxgkX0bwQ5KQjA2qFcTrv7+S7tLMrPPYMjtep5G
 fJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714117296; x=1714722096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqgsQ80KlitoDohnjY62xr/Nbi+2/jm7BCq1mSEmCYY=;
 b=P6MOYgBPHqvGguxSLOY/aRGkbNiMGNa4osfdsE5KGkrRj1aTJqAEEopX9ddJDlhEv5
 qsZENioytJ/27pPJkJAsEp6EXqkdzdIGG8fUlDlHafdSJcodI0pZaUNeaK/SVWRxGVYj
 QF7ZZPeDmqvfyn7/uRR+dYKuMK/aszOscHshygzotTuaiVdoIETTpihaVSJUBh9VcchI
 qpWF2yGkW3FW3iZGTwZ2dYPzp3iW2N+rEzxXUE/sm1jeJtP+NcoRD+wXRXMbnY3DgOn0
 v7YTB0IQqJC/vyZ2WAVwUBfyYZDsRyCo+QHSGiTp7NkNmDecp4Pp95vGPseLpF5Fd56J
 Z4Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCValF037nyB9pPypuTfyOKAi/+RkafnADJ1GiId/gYpLKZBcO0hO6IvLsUGXplqAzGNwfpBpZyTOsW/f/3cl3DzxZU=
X-Gm-Message-State: AOJu0Yx2mRtTzpZyUcGN5vQCJ7/QCSWY7krj8jr7RrExHnzg6QrIbwd3
 xxqdoqueF9rf4Bk7wPhG++oXKP/KEgBpkQ7RBpNzDu/an2051JLBsCqwJrh9sz8=
X-Google-Smtp-Source: AGHT+IGDO2s5u9rvXLCY7bsp02sknqve5xfZhazUWN9DZ0MQjPRV93L1CUbrqFjBef8gqRUaFc2seg==
X-Received: by 2002:a17:907:780c:b0:a52:53f2:5ae0 with SMTP id
 la12-20020a170907780c00b00a5253f25ae0mr1239795ejc.74.1714117296361; 
 Fri, 26 Apr 2024 00:41:36 -0700 (PDT)
Received: from [10.232.133.119] ([88.128.88.8])
 by smtp.gmail.com with ESMTPSA id
 kn9-20020a170906aa4900b00a534000d525sm10335444ejb.158.2024.04.26.00.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 00:41:36 -0700 (PDT)
Message-ID: <189a3266-45ac-4e17-bdb8-8533b75a8848@suse.com>
Date: Fri, 26 Apr 2024 09:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240425222331.315701-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240425222331.315701-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link file/directory names to GitHub
 sources
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 4/26/24 00:23, Petr Vorel wrote:
> Convert all the files/directory names which actually points to real
> files/directories to the links to GitHub sources. Exception is
> datafiles/Makefile and some examples.
>
> For now we use link to the master, maybe we want to change that if we
> ever generate stable docs.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/conf.py                           |  2 +-
>   doc/developers/test_case_tutorial.rst | 18 +++++++++---------
>   doc/developers/writing_tests.rst      | 22 +++++++++++-----------
>   doc/users/quick_start.rst             |  2 +-
>   4 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index d0f185b28..80f6df99b 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -162,7 +162,7 @@ def generate_syscalls_stats(_):
>   
>       # generate the statistics file
>       tested_syscalls = [key for key, val in syscalls.items() if val]
> -    text.append('syscalls which are tested under **testcases/kernel/syscalls**:\n\n')
> +    text.append('syscalls which are tested under :master:`testcases/kernel/syscalls`:\n\n')
>       text.append(f'* kernel syscalls: {len(ker_syscalls)}\n')
>       text.append(f'* tested syscalls: {len(tested_syscalls)}\n\n')
>   
> diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
> index 6ec618b9b..6c38fdbf1 100644
> --- a/doc/developers/test_case_tutorial.rst
> +++ b/doc/developers/test_case_tutorial.rst
> @@ -56,7 +56,7 @@ test. At the time of writing there is no test for this call which was
>   introduced in Linux kernel version 4.11.
>   
>   Linux system call specific tests are primarily contained in
> -``testcases/kernel/syscalls``, but you should also ``git grep`` the entire LTP
> +:master:`testcases/kernel/syscalls`, but you should also ``git grep`` the entire LTP
>   repository to check for any existing usages of a system call.
>   
>   One way to find a system call which is not currently tested by the LTP is to
> @@ -195,7 +195,7 @@ following line after ``testcases.mk``.
>   
>       statx01: CFLAGS += -pthread
>   
> -Assuming you are in the test's subdirectory ``testcases/kernel/syscalls/statx``,
> +Assuming you are in the test's subdirectory :master:`testcases/kernel/syscalls/statx`,
>   please do:
>   
>   .. code-block:: bash
> @@ -204,10 +204,10 @@ please do:
>       ./statx01
>   
>   This should build the test and then run it. However, even though the test is
> -in the ``syscalls`` directory it won't be automatically ran as part of the
> -syscalls test group (e.g. ``./runltp -f syscalls``).
> -For this we need to add it to the ``runtest`` file. So open
> -``runtest/syscalls`` and add the lines starting with a ``+``.
> +in :master:`testcases/kernel/syscalls/` directory it won't be automatically ran
> +as part of the syscalls test group (e.g. not run via ``kirk -r math`` or
> +``./runltp -f syscalls``). For this we need to add it to the runtest file. So
> +open :master:`runtest/syscalls` and add the lines starting with a ``+``.
>   
>   .. code-block::
>   
> @@ -219,9 +219,9 @@ For this we need to add it to the ``runtest`` file. So open
>       stime01 stime01
>       stime02 stime02
>   
> -The ``runtest`` files are in a two column format. The first column is the test
> -name, which is mainly used by test runners for reporting and filtering. It is
> -just a single string of text with no spaces. The second column, which can
> +The :master:`runtest` files are in a two column format. The first column is the
> +test name, which is mainly used by test runners for reporting and filtering. It
> +is just a single string of text with no spaces. The second column, which can
>   contain spaces, is passed to the shell in order to execute the test. Often it
>   is just the executable name, but some tests also take arguments (the LTP has a
>   library for argument parsing, by the way).
> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index daaa4b9f8..85a7a1d8a 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -211,7 +211,7 @@ There are several types of checks we use:
>   
>   * Sometimes it makes sense to define a few macros instead of creating a
>     configure test. One example is Linux specific POSIX clock ids in
> -  ``include/lapi/posix_clocks.h``
> +  :master:`include/lapi/posix_clocks.h`.
>   
>   Dealing with messed up legacy code
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -242,11 +242,11 @@ portable shell or C. The test gets a configuration via environment variables
>   and/or command line parameters, it prints additional information into the
>   stdout and reports overall success/failure via the exit value.
>   
> -Tests are generally placed under the ``testcases/`` directory. Everything that
> +Tests are generally placed under the :master:`testcases/` directory. Everything that
>   is a syscall or (slightly confusingly) libc syscall wrapper, goes under
> -``testcases/kernel/syscalls/``.
> +:master:`testcases/kernel/syscalls/`.
>   
> -There is also ``testcases/open_posix_testsuite/`` which is a well maintained
> +There is also :master:`testcases/open_posix_testsuite/` which is a well maintained
>   fork of the Open POSIX testsuite project, that has been dead since 2005.
>   
>   We also have a number of directories with tests for more specific features, such
> @@ -256,8 +256,8 @@ Runtest Files
>   ~~~~~~~~~~~~~
>   
>   The list of tests to be executed is stored in runtest files under the
> -``runtest/`` directory. The default set of runtest files to be executed is
> -stored in ``scenario_groups/default``. When you add a test, you should add
> +:master:`runtest/` directory. The default set of runtest files to be executed is
> +stored in :master:`scenario_groups/default`. When you add a test, you should add
>   corresponding entries into some runtest file(s) as well.
>   
>   Each line of runtest file contains one test. The first item is the test name.
> @@ -270,9 +270,9 @@ All other items, separated by space will be executed as a command.
>   
>   Blank lines and lines starting with a ``#`` (comments) are ignored.
>   
> -Syscalls tests, placed under ``testcases/kernel/syscalls/``, use
> -``runtest/syscalls`` file. For kernel related tests for memory management we
> -have ``runtest/mm``, etc.
> +Syscalls tests, placed under :master:`testcases/kernel/syscalls/`, use
> +:master:`runtest/syscalls` file. For kernel related tests for memory management we
> +have :master:`runtest/mm`, etc.
>   
>   .. note::
>   
> @@ -286,7 +286,7 @@ Datafiles
>   If your test needs data files, these should be put into a subdirectory
>   named ``datafiles`` and installed into the ``testcases/data/$TCID`` directory.
>   This will require to add ``INSTALL_DIR := testcases/data/TCID`` into
> -``datafiles/Makefile``.
> +correspondent ``datafiles/Makefile``.
>   
>   You can obtain path to datafiles via ``$TST_DATAROOT`` provided by ``test.sh``
>   or via C function ``tst_dataroot()`` provided by libltp:
> @@ -337,7 +337,7 @@ Testing pre-release kernel features
>   -----------------------------------
>   
>   Tests for features not yet in the mainline kernel release are accepted. However,
> -they must be added only to the **staging** runtest file. Once a feature is part
> +they must be added only to :master:`runtest/staging`. Once a feature is part
>   of the stable kernel ABI, the associated test must be moved out of staging.
>   
>   Testing builds with GitHub Actions
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 69792999b..4a48745be 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -123,4 +123,4 @@ Network tests
>   -------------
>   
>   Network tests usually require a certain setup that is described in
> -``testcases/network/README.md``.
> +:master:`testcases/network/README.md`.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
