Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7B5C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744736054; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jxHjcFU4RlRly3CP8k4654zVnmM3pdiShpvkxjh2kfI=;
 b=kMO1AwQ1hKioej4LGN19m2IDyztmEq3nLMgweCvLT1j3c7DLsyGc+Tf0nr4c6hvhrODM/
 nXK/foKJep2y3hoJq+y1nH/T4k28LqFxZCmDRNIuaFLuc1b5JWAbaiqG0EedujSWYu8bjTt
 9jRZJvDYA2U9LQ7kY+8cBkFSG2VMrZU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E28E3CB921
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:54:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A208F3CB68D
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:53:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 33CAB1400046
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:53:51 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3324399f8f.2
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744736030; x=1745340830; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aY+GyiHh8R3oJVVO6w26K4+z4tXobp9IV7X1qXDRcWI=;
 b=Vi6gilTHD0jMFXGAJ3vZ0euwycvfB3Uz7DJetWmR48Xr6rs22BNaKI1CY6PgEQUBwn
 9kJgWoFcpgjAHcx8raGERhS6dBec+QGD+KAiOAIXXtGbiWzpimT3FOM+3VrLSDaKLciB
 tlNNYgxFehBpr/B5YbJ9+NtjxZlZfMozWXO1TdfJsOOY4hUhRe7LibsRVtgs+75Df9LB
 ib8YhcaQ3CScTat+hoaNRtlt2dG/k0L/IbRt1c7u+7mbzBNVlQsBrQRxHdc8TwXy2JDq
 iev1h4jm7aObIWmPzyI2x3Vzg7ERXaEPVxvVqUBf8323hCTGtP6rBhnKAIAM0cUNUqPH
 oRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744736030; x=1745340830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aY+GyiHh8R3oJVVO6w26K4+z4tXobp9IV7X1qXDRcWI=;
 b=eB09CchDk8stzA7HHZJWpxEf7Cz5crNLIqunRz4ztn7n2lEQkSf08C8UPhlgKtiPMf
 LzT0Gbjx8GdA+cVgXtI3rRE/Sq2SrjZYsqN73+ROfmQVwLwTeHGZNQsFtrde4VwR6T2U
 pgaAYebL5j2XtMowvn8PdEKU68MOP1SKSjbLNFiLs1Anupi64dJVYTheQeaA4usZJuUf
 h0kSzVbJB0BMaGcChmLW9rXKlAU7W5H3TEtq9wfR2329WFAMMG0fntpeqvMBVhfELYNL
 aY0b/v84q5tQxmvWtg9D1pW+jMsefaBfe45qeqKstDtnDVQvOx3LX1zwWOx49Yth2zJk
 7jtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbHUX6+RmtP1Lvjpvggd0MByT2oxtSfzoI/a1kxIghPY3bEpqbNX8Y9ra+ci5PQorCoHw=@lists.linux.it
X-Gm-Message-State: AOJu0Yyepr58kbNKMT5AfPDJHkv2yL00oTy2y7V47oJp8F9uzeZkUCkU
 UsENHkolqd6p87eHRrJokaDbwzWT8HOMKEmY8+k/kkpvOSNp/fVeetRGVnfHLA4=
X-Gm-Gg: ASbGncs87Xaa1HHGwLCCREhuqAiYp/+SRvksDfchSJVOs3b+b2HONjJLuCxvOAlY3UD
 Y6JLEbgb+sufL984rl42O8bWNZY/UrUR0RKZu/1Iei/eUAPt2qGUmtg6g/7WpbZvEJxTJ0s64Oo
 pfhI2beEHezQv9TiSTiSKHi7ufpQYJHyxq9gKKsMh1BvRrPw+gjHOCc9BW9VZaubQCFvOMAblf9
 FenTWbMjth5AmZnvFDx6NCNUJnAy1wCXEBOmT/WJYmWQ6/Kdf00ZGXNHvkE+JX4IBfeOCWJIXOg
 Jp72mABr+YSBB3fAZzBy1YijkrLJYzrSlplJXIE8JJ69U+KT80wN/xlp7qtVZf4ru4us6ZvzNx3
 1rbQcb2Q9THs82kbQjIptVkQCF3JUovzlrV+Xnzg3hZQHIfQ1mbEjovg+pFGrkBlEwzpqCfjyri
 xwqzU=
X-Google-Smtp-Source: AGHT+IHaxam8oE5148gAm378iIWUYYuL4/54Cv1b4UT6dQ3xbYzO6+x3r2ECIvYNnBEUmVNnrPEudw==
X-Received: by 2002:a05:6000:4308:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-39ee2773b5cmr150467f8f.59.1744736030430; 
 Tue, 15 Apr 2025 09:53:50 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2338d6ebsm222218885e9.2.2025.04.15.09.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 09:53:50 -0700 (PDT)
Message-ID: <276493e4-496b-48a7-8bff-3d0e7debbed6@suse.com>
Date: Tue, 15 Apr 2025 18:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
Content-Language: en-US
In-Reply-To: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 0/4] Support for Patchwork CI
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

Hi,

I temporarily disabled the schedule on my personal master branch, since 
this patch-set is going to be merged soon. FYI:

- we need a patchwork user to test new ML patches, so we can use its token
- we need to setup this token into the LTP settings, so we are able to 
communicate with patchwork

Kind regards,
Andrea Cervesato

On 4/15/25 18:39, Andrea Cervesato wrote:
> Add support for patch-series validation in the patchwork ML.
> We use Github to schedule a trigger every 30 minutes, checking for new
> patche-series in parchwork which has not been tested yet.
>
> The way we decide if a patch-series has been tested in patchwork, is
> by looking at its status (in particular, if it's "Needs Review / ACK"),
> as well as checking if test report has been uploaded to any of the
> series patches.
>
> All communication to Patchwrok is done via REST API, using curl and js
> tools.
>
> First, we create a script called patchwork-ci.sh that provides all the
> commands to read new untested patch-series, set their status and testing
> report. Then, we create a scheduled workflow in Gitlab, checking every
> 30 minutes if there are new untested patch-series. At the end, we
> trigger the main build workflow, used to validate LTP commits in our
> Github mainline. All the times we trigger the build workflow, we also
> provide the patch-series ID, that will be fetched and applied on the
> current branch before running the tests.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v7:
> - patchwork.sh: fix bashism ==
> - patchwork.sh: fix return code check for curl
> - patchwork.sh: remove IFS= from loops
> - patchwork.sh: local cmd in command_exists
> - fix message for trigger scripts commit
> - Link to v6: https://lore.kernel.org/r/20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com
>
> Changes in v6:
> - patchwork.sh: use more "[ $stuff ] || do_something" syntax
> - patchwork.sh: remove set -ex
> - patchwork.sh: variables default setup
> - patchwork.sh: move file creation in tmp folder
> - patchwork.sh: check multiple commands exist in once
> - trigger workflow now triggers only on linux-test-project/ltp repo
> - Link to v5: https://patchwork.ozlabs.org/project/ltp/list/?series=452320
>
> Changes in v5:
> - patchwork is now a utility that can be used separately
> - Link to v4: https://lore.kernel.org/r/20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com
>
> Changes in v4:
> - make use of secrets to apply patches in order to set state to
>    needs-review-ack
> - check for curl failures and eventually exit 1
> - use a different format for stored file in 'patchwork-ci.sh verify'
>    command
> - define PATCHWORK_CI_FILE
> - some symbols like . are not supported by patchwork checks, so slurmify
>    the string before sending checks context
> - Link to v3: https://lore.kernel.org/r/20250411-patchwork_ci-v3-0-c9bb90c6961b@suse.com
>
> Changes in v3:
> - secrets are not supported by if: statement, so we remove it
> - Link to v2: https://lore.kernel.org/r/20250410-patchwork_ci-v2-0-288f4be835ff@suse.com
>
> Changes in v2:
> - check for secrets.PATCHWORK_TOKEN before sending tests results
> - v2 to re-trigger lore after missing 3/4 patch
> - Link to v1: https://lore.kernel.org/r/20250410-patchwork_ci-v1-0-def85825f46a@suse.com
>
> ---
> Andrea Cervesato (4):
>        ci: install dependences for patchwork-ci script
>        ci: add patchwork communication script
>        ci: add ci-patchwork-trigger workflow
>        ci: apply patchwork series in ci-docker-build workflow
>
>   .github/workflows/ci-docker-build.yml      |  39 ++++++-
>   .github/workflows/ci-patchwork-trigger.yml |  65 +++++++++++
>   ci/alpine-runtime.sh                       |   2 +
>   ci/alpine.sh                               |   2 +
>   ci/debian.i386.sh                          |   2 +
>   ci/debian.sh                               |   2 +
>   ci/fedora.sh                               |   2 +
>   ci/tools/patchwork.sh                      | 173 +++++++++++++++++++++++++++++
>   ci/tumbleweed.sh                           |   2 +
>   9 files changed, 288 insertions(+), 1 deletion(-)
> ---
> base-commit: 40c559787d15b2167ba657b3ba431e3299969d98
> change-id: 20250410-patchwork_ci-7dc4ae02c40d
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
