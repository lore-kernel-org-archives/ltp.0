Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAE4CCD187
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760425351; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1BC4cVkyczXpoiTlqFA6nXPqDKsfhd1taenawX+fHb4=;
 b=FPCd9+mlVhkW5twO5RwLRC7fBUgZlnlYyJyaprFIFDnlVOpUdBXLB4Q5E/CTzdNMro6NN
 C69gLamQ8P/l4C1KbG5lzBp/tVsfaRaYXQWcwrbuU4/Morcc5gvGUjTjHTypa6AuvU4z9r6
 K6dUmlHDDCjHTG0e9dSgiXok3kfEYM8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 214EA3CEC2B
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:02:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 190C43CEC3C
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:02:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33FBD2009DC
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:02:08 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so900791666b.0
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760425327; x=1761030127; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbCU0RGw5f4cxsaB1L1o4lu2Gw+MzmLBQXGH6Rv1qis=;
 b=aX812uMk/11c9JnFzT7BMUvZfYnYFjsj64MhdGplNlf3p5uzIGJT9si0LSPagSR8Vq
 mKsk3PNLjFRhHKzfBKGyA2YcN/l1/bhWhMM04/8/urq7gYMSDyB08qPPQJs7H2LLY4Xn
 V5cCOewh2/IsDEyc3S/PTj6ohry3yxGI9PLIeq8M19wdDa5gOpe+fThZAS3TFTrN2su9
 s93YAXwk2xUdji8HIQULb6COq+gdn+Q1ye7KIixL6Uj9FIoA+U16nS4pkQVHSOS/oWH9
 Z31EYCLyqwlKIQPF5uiNh8yzVAHY8LdM7MijkegtGGIichhmDs5eSenFE6mTG3R7Tjw+
 7vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760425327; x=1761030127;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xbCU0RGw5f4cxsaB1L1o4lu2Gw+MzmLBQXGH6Rv1qis=;
 b=YWUAzlGxWia/YesdImxbFQVuW/YHzK3Yblb6SGg+J1odZWz+p41GQXWqDoRAv5oFK0
 FEucNuYtT4ERwig2kdf8hHDLs2wrbgrAudFufeNCefnWquDMqyK4Z5BtLKa3eTJlV6Rz
 J5LoHyj1mplemrNxvAJXZnw1z4UF2EE5zLKruOV+gPOtV+OALK9n0/vS0twqW8ZZad/d
 EbfwauJqI91YMECooLkRBMGEnnmD3pu8sETtnql35ylt3q+SwM0LCj69SbZtDfp+8gi9
 /IHXEagZiYLbKAYeC6ufsflU8a3TFMu4oC+Z1FGKHdatHuYG3sb06MQioXZlq0SdKCGQ
 MG6Q==
X-Gm-Message-State: AOJu0YynQezW1FQOnw6TG2L20c+CMO3GunsdqAAPHdHN6AOBQccAydlA
 M6gGUdGbHyDkEY6LiOc29hrAX6u7OzdzCeeLQZ6NZZJBHtYuYvTmLbdJQkhObEfP9EE=
X-Gm-Gg: ASbGnctBB3ks/xj/cqP2imIT7TBiRNMZz9N90/PrQ2s/uagBbt/QQfTWu5Bn6kk7OBb
 pZT/1PnqJo0PoR3DHje7Rhefg5SE4cU/EnNpGHqiHHRGMOWLiABWq7dVvj9I9tlE5DJY1L4mp6H
 9d3vdNSEFG/RnVZupMPs3aeJCo6Qg0AIuo3m4mJ8m4V2Atrr8z8ciXwOAVjTMZaY72CXsTAccWX
 IbLJfQdUAkQEHcUWLxeAL6RM5uYPGISragz9geLgryn1KTwOzuD+pNvkndgfglmFvXffAvBRhpp
 ApKj2KrGzQhVqJYHqQa7P2QuoZNOCdipfkb8WGjO+vFu4KM9l9K4aJRG+9PpjzbWNlXDyPzR2+h
 yNS8eUe1jm1Esyka2ei3GFjHzgakrkuYDEUGpGvdzYR16Y0cZSpWB220ZNpSqaiBBioanSgCyzs
 CizrVD/7FJ+u6gYPK/opAzdmlq6i4dspllagDIzQh6/9Gj
X-Google-Smtp-Source: AGHT+IF0Bidrl1ERShynTXPqMNUajTTIn8vZ4SmO0KBaj4pY31WvKqRzh0ynIMOA7vJFgl3pQUD/pQ==
X-Received: by 2002:a17:906:dc90:b0:aff:fe6:78f0 with SMTP id
 a640c23a62f3a-b50ac8e5533mr2691445466b.54.1760425327402; 
 Tue, 14 Oct 2025 00:02:07 -0700 (PDT)
Received: from localhost
 (p200300ef2f1c890086c8658517a2433a.dip0.t-ipconnect.de.
 [2003:ef:2f1c:8900:86c8:6585:17a2:433a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad8adsm1110156866b.7.2025.10.14.00.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 00:02:06 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 14 Oct 2025 09:02:06 +0200
Message-Id: <DDHUP29SK1SL.1S23JCE19D2OB@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251013-remove_todo-v3-1-533e47439a94@suse.com>
 <20251013153838.GA111830@pevik>
In-Reply-To: <20251013153838.GA111830@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Remove TODO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Mon Oct 13, 2025 at 5:38 PM CEST, Petr Vorel wrote:
> Hi Andrea,
>
> once more, now Cc the list. I'm sorry for the noise.
>
> Generally LGTM, notes below.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> TODO file is not updated and it talks about goals we already reached via
>> new LTP documentation. In general, it contains generic and random topics
>> which none is updating anymore, so it's better to remove it in order to
>> create less confusion for new comers.
>
> nit: s/new comers/newcomers/
>
>> Instead, we create a todo list in the new documentation, providing a
>> more clear intention of what are the current LTP goals.
>
>> Acked-by: Petr Vorel <pvorel@suse.cz>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> Changes in v3:
>> - fix typo
>> - update command to generate test with old API
>> - add kirk link in TODO
>> - shell loader reference
>> - Link to v2: https://lore.kernel.org/r/20251013-remove_todo-v2-1-d0a46ad14e34@suse.com
>
>> Changes in v2:
>> - add doc/users/todo.rst section
>> - Link to v1: https://lore.kernel.org/r/20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com
>> ---
>>  TODO               | 39 ----------------------------
>>  doc/index.rst      |  4 +++
>>  doc/users/todo.rst | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 78 insertions(+), 39 deletions(-)
>
> ...
>> diff --git a/doc/users/todo.rst b/doc/users/todo.rst
>> new file mode 100644
>> index 000000000..2484eaf32
>> --- /dev/null
>> +++ b/doc/users/todo.rst
>
> IMHO this TODO page is for new LTP developers to see ideas what to work on,
> right?  Thinking about it twice, IMHO this should be in doc/developers/.
> At least normal LTP users (testers) don't bother what we want to develop.

Probably better yes, I will move it to developers.

>
>> @@ -0,0 +1,74 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +List of ongoing tasks
>> +=====================
>> +
>> +This is a comprehensive list of tasks where LTP maintainers are currently
>> +working on. Priorities might change over time, but these are the most important
>> +points which are currently being achieved.
>> +
>> +Fade out old tests runner
>> +-------------------------
>> +
>> +``runltp`` script is old and unmaintaned. We are slowly shifting to
>> +`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
>> +tests runner in the next future.
>> +
>> +kirk provides support for remote testing via Qemu, SSH, LTX, parallel
>> +execution and much more.
>
> IMHO this TODO page is for new LTP developers to see ideas what to work on,
> right? Wouldn't be more useful to put it to the page which people using LTP will
> be reading? Maybe one of these:
>
> https://linux-test-project.readthedocs.io/en/latest/users/quick_start.html
> https://linux-test-project.readthedocs.io/en/latest/users/setup_tests.html

I don't know about this, it makes sense to have a separate place for
this list. TODO/quickstart/setup are different things.

>
>> +
>> +Test new syscalls
>> +-----------------
>> +
>> +Syscalls and new syscalls flags are added to Linux kernel each development
>> +cycle and LTP still falls behind. Unfortunately there is no single place that
>> +would store comprehensive list of syscalls, but there are a few places to look
>> +at:
>> +
>> +- `man-pages repository <http://git.kernel.org/cgit/docs/man-pages/man-pages.git>`_
>> +  or the ``man2`` directory, where it's possible to find newly documented
>> +  functionalities.
>> +- `LWN <http://lwn.net>`_ weekly editions.
>> +- `linux-api mailing list <https://lore.kernel.org/linux-api/>`_ where
>> +  changes in kernel userspace API are discussed.
>> +- `LTP Github issues <https://github.com/linux-test-project/ltp/issues>`_
>> +
>> +Rewrite old API tests
>> +---------------------
>> +
>> +LTP has a long story and, at certain point of its development, new API were
>> +introduced to make kernel testing easier and more efficient. This happened when
>> +lots of tests were still using old, messy API.
>> +
>> +Some of these tests have been converted to the new API, but this process is
>> +still ongoing for many others. To have an overview of the tests using old API,
>> +please run the following command inside the LTP root folder:
>> +
>> +.. code-block:: bash
>> +
>> +        git --no-pager grep 'include "test\.h"' testcases/ | cut -d: -f1
>
> I quite like your first version which showed number of lines. But if you want to
> just list of the old API tests, why not use git grep -l ?
>
> git --no-pager grep -l 'include "test\.h"' testcases/
>
>> +
>> +Fade out shell scripts
>> +----------------------
>> +
>> +LTP was initially thought as a generic framework for running tests with both
>> +shell and plain-C languages. Even if writing tests in shell script might seem
>> +easy, the reality is that debugging and maintaining certain test cases is
>> +difficult and slow down the whole validation process. This is particularly
>> +visible for cgroup tests, since shell doesn't add enough control over race
>> +conditions.
>
> That reminds me Cyril's saying "it's easy to write portable shell *interpreter*
> than portable shell *scripts*. :).
>
>> +
>> +LTP maintainers are working on converting shell scripts to plain-C tests, in
>> +order to reduce the impact that shell scripts might have on the overall kernel
>> +testing.
>> +
>> +For a complete list of shell tests, please run the following command inside the
>> +LTP root folder:
>> +
>> +.. code-block:: bash
>> +
>> +        git --no-pager grep -l -e '^\. .*_lib\.sh' -e '^\. .*test.sh'
>> +
>> +LTP also provides a shell loader implementation for plain-C tests using
>> +``tst_run_script`` features. Please take a look at the
>
> That's tst_run_shell. Could you please use link to the source?
>
> :master:`testcases/lib/tst_run_shell.c`
>
>> +:doc:`LTP API <../developers/api_c_tests>`.
> For shell loader are useful only struct tst_test tags in JSON comments.
> Maybe point directly to struct tst_test?
>
> Maybe the most descriptive are tests in testcases/lib/tests/.
>
> :master:`testcases/lib/tst_run_shell.c` features. Please take a look at the
> :ref:`struct tst_test` and examples in :master:`testcases/lib/tests/`.
>
> (NOTE: besides testcases/lib/tst_run_shell.c there is also
> testcases/lib/tst_run.sh and testcases/lib/tst_env.sh but we can ignore it in
> this short info.  If we really convert most of the shell tests to shell runner,
> we should write doc in a separate page. In that case we could leave
> doc/old/Shell-Test-API.asciidoc unconverted).

I will just skip the C API reference and point to the tst_run_shell
file.
>
> Kind regards,
> Petr


Kind regards,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
